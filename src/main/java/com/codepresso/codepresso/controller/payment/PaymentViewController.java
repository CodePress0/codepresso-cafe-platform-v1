package com.codepresso.codepresso.controller.payment;

import com.codepresso.codepresso.dto.payment.CartCheckoutResponse;
import com.codepresso.codepresso.security.LoginUser;
import com.codepresso.codepresso.service.payment.PaymentService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * 결제 페이지 뷰 컨트롤러
 */
@Controller
@RequestMapping("/payments")
@RequiredArgsConstructor
public class PaymentViewController {

    private final PaymentService paymentService;

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
            @RequestParam Long productId,
            @RequestParam Integer quantity,
            @RequestParam(required = false) List<Long> optionIds,
            Model model
    ) {
        try {
            var vm = paymentService.buildDirectViewModel(productId, quantity, optionIds);
            for (var entry : vm.entrySet()) {
                model.addAttribute(entry.getKey(), entry.getValue());
            }
        } catch (Exception e) {
            model.addAttribute("errorMessage", "결제 정보를 준비하는 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/products/" + productId + "?error=" + e.getMessage();
        }
        return "payment/checkout";
    }

}
