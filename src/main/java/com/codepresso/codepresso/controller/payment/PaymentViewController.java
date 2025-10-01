package com.codepresso.codepresso.controller.payment;

import com.codepresso.codepresso.config.TossPaymentsConfig;
import com.codepresso.codepresso.dto.payment.CheckoutResponse;
import com.codepresso.codepresso.dto.payment.DirectOrderForm;
import com.codepresso.codepresso.dto.cart.CartResponse;
import com.codepresso.codepresso.dto.payment.TossPaymentConfirmResponse;
import com.codepresso.codepresso.security.LoginUser;
import com.codepresso.codepresso.service.coupon.CouponService;
import com.codepresso.codepresso.service.payment.PaymentService;
import com.codepresso.codepresso.service.cart.CartService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * 결제 페이지 뷰 컨트롤러
 */
@Controller
@RequestMapping("/payments")
@RequiredArgsConstructor
public class PaymentViewController {

    private final PaymentService paymentService;
    private final CartService cartService;
    private final CouponService couponService;
    private final TossPaymentsConfig tossPaymentsConfig;

    /**
     * 장바구니에서 결제페이지로
     * GET /payments/cart
     */
    @GetMapping("/cart")
    public String cartCheckoutPage(
            @AuthenticationPrincipal LoginUser loginUser,
            Model model) {
        try {
            if (loginUser == null) {
                return "redirect:/auth/login?redirect=/payments/cart";
            }

            CartResponse cartData = cartService.getCartByMemberId(loginUser.getMemberId());
            model.addAttribute("cartData", cartData);
            int totalAmount = cartData.getItems() == null ? 0 : cartData.getItems().stream().mapToInt(i -> i.getPrice()).sum();
            int totalQuantity = cartData.getItems() == null ? 0 : cartData.getItems().stream().mapToInt(i -> i.getQuantity()).sum();
            model.addAttribute("totalAmount", totalAmount);
            model.addAttribute("totalQuantity", totalQuantity);
            model.addAttribute("isFromCart", true);
            model.addAttribute("validCouponCount", couponService.getMemberValidCouponCount(loginUser.getMemberId()));

        } catch (Exception e) {
            model.addAttribute("errorMessage", "장바구니 정보를 불러올 수 없습니다: " + e.getMessage());
            return "redirect:/cart?error=" + e.getMessage();
        }

        model.addAttribute("clientKey", tossPaymentsConfig.getClientKey());
        return "payment/checkout";
    }

    /**
     * 상품상세에서 바로 결제페이지로 (POST)
     * POST /payments/direct
     */
    @PostMapping("/direct")
    public String directCheckoutPost(
            @AuthenticationPrincipal LoginUser loginUser,
            @ModelAttribute DirectOrderForm form,
            Model model
    ) {
        try {
            CheckoutResponse checkoutData = paymentService.prepareCheckout(
                loginUser.getMemberId(), form.getProductId(), form.getQuantity(), form.getOptionIds());

            model.addAttribute("directItems", checkoutData.getOrderItems());
            model.addAttribute("directItemsCount", checkoutData.getTotalQuantity());
            model.addAttribute("totalAmount", checkoutData.getTotalAmount());
            model.addAttribute("totalQuantity", checkoutData.getTotalQuantity());
            model.addAttribute("isFromCart", false);
            model.addAttribute("validCouponCount", couponService.getMemberValidCouponCount(loginUser.getMemberId()));
        } catch (Exception e) {
            model.addAttribute("errorMessage", "결제 정보를 준비하는 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/products/" + (form != null ? form.getProductId() : "") + "?error=" + e.getMessage();
        }

        model.addAttribute("clientKey", tossPaymentsConfig.getClientKey());
        return "payment/checkout";
    }

    /**
     * 토스 페이먼츠 결제 페이지
     * */
    @GetMapping("/toss-checkout")
    public String tossCheckoutPage(
            @AuthenticationPrincipal LoginUser loginUser,
            @RequestParam(required = false) String from,
            @RequestParam(required = false) Integer amount,
            @RequestParam(required = false) String orderName,
            Model model) {

        try{
            if (loginUser == null) {
                return "redirect:/auth/login?redirect=/payments/toss-checkout";
            }

            // 기본값 설정
            int finalAmount = amount != null ? amount : 500;
            String finalOrderName = orderName != null ? orderName : "CodePresso 카페주문";

            // 장바구니에서 온 경우
            if("cart".equals(from)){
                try{
                    CartResponse cartData = cartService.getCartByMemberId(loginUser.getMemberId());
                    finalAmount = cartData.getItems().stream().mapToInt(i -> i.getPrice()).sum();
                    finalOrderName = "장바구니 주문";

                    model.addAttribute("cartData", cartData);
                    model.addAttribute("isFromCart", true);
                }catch(Exception e){
                    model.addAttribute("errorMessage", "장바구니 정보 없음");
                }
            }

            // 토스 페이먼츠 설정값들
            model.addAttribute("clientKey",tossPaymentsConfig.getClientKey());
            model.addAttribute("successUrl", tossPaymentsConfig.getSuccessUrl());
            model.addAttribute("failureUrl", tossPaymentsConfig.getFailureUrl());

            // 결제 정보
            model.addAttribute("amount",finalAmount);
            model.addAttribute("orderName",finalOrderName);
            model.addAttribute("customerEmail",loginUser.getEmail());
            model.addAttribute("customerName",loginUser.getName());
            model.addAttribute("memberId", loginUser.getMemberId());

            // 고유한 주문 ID 생성 (현재시간 + 멤버ID)
            String orderId = "ORDER_" + System.currentTimeMillis() + "_" + loginUser.getMemberId();
            model.addAttribute("orderId", orderId);
        }catch(Exception e){
            model.addAttribute("errorMessage","결제 페이지를 불러올 수 없습니다: " + e.getMessage());
            return "redirect:/payments/toss-checkout?error=" + e.getMessage();
        }
        return "payment/toss-checkout";
    }
    /**
     * 토스 페이먼츠 결제 성공 페이지
     * */
    @GetMapping("/success")
    public String paymentSuccessPage(
            @RequestParam(required = false) String orderId,
            @RequestParam(required = false) String paymentKey,
            @RequestParam(required = false) String amount,
            @AuthenticationPrincipal LoginUser loginUser,
            Model model){
        try {
            // 이미 주문이 생성된 상태이므로 결제 승인만 처리
            TossPaymentConfirmResponse confirmResponse = paymentService.confirmTossPayment(
                    paymentKey, orderId, amount);

            // 주문 상세 페이지로 리다이렉트
            return "redirect:/orders/" + orderId;

        } catch (Exception e) {
            return "redirect:/payments/fail?message=" + e.getMessage();
        }

    }

    /**
     * 토스 페이먼츠 결제 실패 페이지
     * */
    @GetMapping("/fail")
    public String paymentFailPage(
            @RequestParam(required = false) String code,
            @RequestParam(required = false) String message,
            @RequestParam(required = false) String orderId,
            Model model
    ){
        model.addAttribute("code", code);
        model.addAttribute("errorMessage", message);
        model.addAttribute("orderId", orderId);

        return "payment/fail";
    }
}
