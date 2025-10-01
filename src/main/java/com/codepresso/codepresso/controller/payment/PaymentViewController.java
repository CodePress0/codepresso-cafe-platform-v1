package com.codepresso.codepresso.controller.payment;

import com.codepresso.codepresso.dto.payment.CheckoutResponse;
import com.codepresso.codepresso.dto.payment.DirectOrderForm;
import com.codepresso.codepresso.dto.cart.CartResponse;
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

    /**
     * 장바구니에서 결제페이지로
     * GET /payments/cart
     */
    @GetMapping("/cart")
    public String cartCheckoutPage(
            @AuthenticationPrincipal LoginUser loginUser,
            @RequestParam(required = false) Long branchId,
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
        return "payment/checkout";
    }

}
