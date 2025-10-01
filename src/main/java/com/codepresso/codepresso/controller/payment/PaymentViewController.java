package com.codepresso.codepresso.controller.payment;

import com.codepresso.codepresso.dto.payment.CartCheckoutResponse;
import com.codepresso.codepresso.dto.payment.DirectCheckoutResponse;
import com.codepresso.codepresso.entity.branch.Branch;
import com.codepresso.codepresso.security.LoginUser;
import com.codepresso.codepresso.service.branch.BranchService;
import com.codepresso.codepresso.service.coupon.CouponService;
import com.codepresso.codepresso.service.payment.PaymentService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 결제 페이지 뷰 컨트롤러
 */
@Controller
@RequestMapping("/payments")
@RequiredArgsConstructor
public class PaymentViewController {

    private final PaymentService paymentService;
    private final BranchService branchService;
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

            CartCheckoutResponse checkoutData = paymentService.prepareCartCheckout(loginUser.getMemberId());
            model.addAttribute("cartData", checkoutData.getCartData());
            model.addAttribute("totalAmount", checkoutData.getTotalAmount());
            model.addAttribute("totalQuantity", checkoutData.getTotalQuantity());
            model.addAttribute("isFromCart", true);
            model.addAttribute("validCouponCount", couponService.getMemberValidCouponCount(loginUser.getMemberId()));

            if (branchId != null) {
                model.addAttribute("branchId", branchId);
            }

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
            @RequestParam Long productId,
            @RequestParam Integer quantity,
            @RequestParam(required = false) List<Long> optionIds,
            @RequestParam(required = false) Long branchId,
            Model model
    ) {
        try {
            // 직접 주문 데이터 준비
            DirectCheckoutResponse directData = paymentService.prepareDirectCheckout(productId, quantity, optionIds);

            // JSP에서 사용할 수 있도록 데이터 변환
            Map<String, Object> directItem = new HashMap<>();
            directItem.put("productName", directData.getProductDetail().getProductName());
            directItem.put("productPhoto", directData.getProductDetail().getProductPhoto());
            directItem.put("unitPrice", directData.getTotalAmount() / quantity);
            directItem.put("quantity", quantity);
            directItem.put("lineTotal", directData.getTotalAmount());

            List<String> optionNames = new ArrayList<>();
            if (directData.getSelectedOptions() != null) {
                for (var option : directData.getSelectedOptions()) {
                    optionNames.add(option.getOptionStyleName());
                }
            }
            directItem.put("optionNames", optionNames);

            List<Map<String, Object>> directItems = new ArrayList<>();
            directItems.add(directItem);

            model.addAttribute("directItems", directItems);
            model.addAttribute("directItemsCount", 1);
            model.addAttribute("totalAmount", directData.getTotalAmount());
            model.addAttribute("totalQuantity", quantity);
            model.addAttribute("isFromCart", false);
            model.addAttribute("branchId", branchId != null ? branchId : 1L);

            // 쿠폰 개수 추가 (로그인된 경우에만)
            if (loginUser != null) {
                model.addAttribute("validCouponCount", couponService.getMemberValidCouponCount(loginUser.getMemberId()));
            }

            // 매장 정보 조회 및 추가
            Long finalBranchId = branchId != null ? branchId : 1L;
            Branch branch = branchService.getBranch(finalBranchId);
            model.addAttribute("branch", branch);
            model.addAttribute("branchName", branch.getBranchName());

            // orderItemsPayloadJson 생성
            String orderItemsPayloadJson = "[{" +
                    "\"productId\":" + productId +
                    ",\"quantity\":" + quantity +
                    ",\"price\":" + (directData.getTotalAmount() / quantity) +
                    ",\"optionIds\":[" + optionIds.stream().map(String::valueOf).collect(Collectors.joining(",")) + "]" +
                    "}]";
            model.addAttribute("orderItemsPayloadJson", orderItemsPayloadJson);

            return "payment/checkout";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "결제 정보를 준비하는 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/products/" + productId + "?error=" + e.getMessage();
        }
    }

    /**
     * 토스페이먼츠 결제 페이지
     * GET /payments/toss-checkout
     */
    @GetMapping("/toss-checkout")
    public String tossCheckoutPage(
            @AuthenticationPrincipal LoginUser loginUser,
            @RequestParam(required = false) Long branchId,
            @RequestParam(required = false) String from,
            @RequestParam(required = false) Integer amount,
            HttpServletRequest request,
            Model model) {
        try {
            if (loginUser == null) {
                return "redirect:/auth/login?redirect=/payments/toss-checkout";
            }

            // from 파라미터에 따라 다른 데이터 로드
            if ("cart".equals(from)) {
                // 장바구니에서 온 경우
                CartCheckoutResponse checkoutData = paymentService.prepareCartCheckout(loginUser.getMemberId());
                model.addAttribute("cartData", checkoutData.getCartData());
                model.addAttribute("totalAmount", checkoutData.getTotalAmount());
                model.addAttribute("totalQuantity", checkoutData.getTotalQuantity());
                model.addAttribute("isFromCart", true);
            } else if ("direct".equals(from)) {
                // 상품상세에서 바로 결제하는 경우
                // URL 파라미터에서 주문 정보 추출
                Long productId = Long.valueOf(request.getParameter("productId"));
                Integer quantity = Integer.valueOf(request.getParameter("quantity"));
                String optionIdsStr = request.getParameter("optionIds");
                
                List<Long> optionIds = new ArrayList<>();
                if (optionIdsStr != null && !optionIdsStr.isEmpty()) {
                    String[] optionIdArray = optionIdsStr.split(",");
                    for (String id : optionIdArray) {
                        optionIds.add(Long.valueOf(id.trim()));
                    }
                }
                
                // 직접 주문 데이터 준비
                DirectCheckoutResponse directData = paymentService.prepareDirectCheckout(productId, quantity, optionIds);
                
                // JSP에서 사용할 수 있도록 데이터 변환
                Map<String, Object> directItem = new HashMap<>();
                directItem.put("productName", directData.getProductDetail().getProductName());
                directItem.put("productPhoto", directData.getProductDetail().getProductPhoto());
                directItem.put("unitPrice", directData.getTotalAmount() / quantity);
                directItem.put("quantity", quantity);
                directItem.put("lineTotal", directData.getTotalAmount());
                
                List<String> optionNames = new ArrayList<>();
                if (directData.getSelectedOptions() != null) {
                    for (var option : directData.getSelectedOptions()) {
                        optionNames.add(option.getOptionStyleName());
                    }
                }
                directItem.put("optionNames", optionNames);
                
                List<Map<String, Object>> directItems = new ArrayList<>();
                directItems.add(directItem);
                
                model.addAttribute("directItems", directItems);
                model.addAttribute("directItemsCount", 1);
                model.addAttribute("totalAmount", directData.getTotalAmount());
                model.addAttribute("totalQuantity", quantity);
                model.addAttribute("isFromCart", false);
                
                // orderItemsPayloadJson 생성
                String orderItemsPayloadJson = "[{" +
                        "\"productId\":" + productId +
                        ",\"quantity\":" + quantity +
                        ",\"price\":" + (directData.getTotalAmount() / quantity) +
                        ",\"optionIds\":[" + optionIds.stream().map(String::valueOf).collect(Collectors.joining(",")) + "]" +
                        "}]";
                model.addAttribute("orderItemsPayloadJson", orderItemsPayloadJson);
            } else {
                // URL 파라미터로 전달된 amount가 있으면 사용, 없으면 기본값
                System.out.println("tossCheckoutPage - amount 파라미터: " + amount);
                if (amount != null && amount > 0) {
                    model.addAttribute("totalAmount", amount);
                    System.out.println("tossCheckoutPage - 전달된 amount 사용: " + amount);
                } else {
                    model.addAttribute("totalAmount", 5000);
                    System.out.println("tossCheckoutPage - 기본값 사용: 5000");
                }
                model.addAttribute("totalQuantity", 1);
                model.addAttribute("isFromCart", false);
            }

            // 매장 정보 조회
            Long finalBranchId = branchId != null ? branchId : 1L;
            Branch branch = branchService.getBranch(finalBranchId);
            
            model.addAttribute("branchId", finalBranchId);
            model.addAttribute("branchName", branch.getBranchName());
            model.addAttribute("branch", branch); // 전체 Branch 객체도 전달

        } catch (Exception e) {
            model.addAttribute("errorMessage", "결제 페이지를 불러올 수 없습니다: " + e.getMessage());
            return "redirect:/payments/cart?error=" + e.getMessage();
        }

        return "payment/toss-checkout";
    }

    /**
     * 토스페이먼츠 결제 성공 페이지
     * GET /payments/success
     */
    @GetMapping("/success")
    public String paymentSuccessPage(
            @RequestParam(required = false) String orderId,
            @RequestParam(required = false) String paymentKey,
            @RequestParam(required = false) String amount,
            @RequestParam(required = false) String orderName,
            Model model) {
        
        try {
            System.out.println("Payment success page called with:");
            System.out.println("  orderId: " + orderId);
            System.out.println("  paymentKey: " + paymentKey);
            System.out.println("  amount: " + amount);
            System.out.println("  orderName: " + orderName);
            
            model.addAttribute("orderId", orderId);
            model.addAttribute("paymentKey", paymentKey);
            model.addAttribute("amount", amount);
            model.addAttribute("orderName", orderName);
            
            System.out.println("Returning payment/success view");
            return "payment/success";
        } catch (Exception e) {
            // 로그 출력
            System.err.println("Payment success page error: " + e.getMessage());
            e.printStackTrace();
            
            // 실패 페이지로 리다이렉트
            try {
                return "redirect:/payments/fail?message=" + 
                       java.net.URLEncoder.encode("결제 성공 페이지를 불러올 수 없습니다: " + e.getMessage(), "UTF-8") + 
                       "&code=SERVER_ERROR";
            } catch (java.io.UnsupportedEncodingException ex) {
                return "redirect:/payments/fail?message=Server%20Error&code=SERVER_ERROR";
            }
        }
    }

    /**
     * 토스페이먼츠 결제 실패 페이지
     * GET /payments/fail
     */
    @GetMapping("/fail")
    public String paymentFailPage(
            @RequestParam(required = false) String code,
            @RequestParam(required = false) String message,
            @RequestParam(required = false) String orderId,
            Model model) {
        
        try {
            model.addAttribute("code", code);
            model.addAttribute("message", message);
            model.addAttribute("orderId", orderId);
            
            return "payment/fail";
        } catch (Exception e) {
            // 로그 출력
            System.err.println("Payment fail page error: " + e.getMessage());
            e.printStackTrace();
            
            // 기본 실패 페이지로 리다이렉트
            try {
                return "redirect:/payments/fail?message=" + 
                       java.net.URLEncoder.encode("결제 실패 페이지를 불러올 수 없습니다: " + e.getMessage(), "UTF-8") + 
                       "&code=PAGE_ERROR";
            } catch (java.io.UnsupportedEncodingException ex) {
                return "redirect:/payments/fail?message=Page%20Error&code=PAGE_ERROR";
            }
        }
    }

}
