package com.codepresso.codepresso.controller.payment;

import com.codepresso.codepresso.dto.payment.CartCheckoutResponse;
import com.codepresso.codepresso.dto.payment.CheckoutRequest;
import com.codepresso.codepresso.dto.payment.CheckoutResponse;
import com.codepresso.codepresso.dto.payment.DirectCheckoutResponse;
import com.codepresso.codepresso.security.LoginUser;
import com.codepresso.codepresso.service.payment.PaymentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.ArrayList;
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
            Model model) {
        try {
            CartCheckoutResponse checkoutData = paymentService.prepareCartCheckout(loginUser.getMemberId());
            model.addAttribute("cartData", checkoutData.getCartData());
            model.addAttribute("totalAmount", checkoutData.getTotalAmount());
            model.addAttribute("totalQuantity", checkoutData.getTotalQuantity());
            model.addAttribute("isFromCart", true);

        } catch (Exception e) {
            model.addAttribute("errorMessage", "장바구니 정보를 불러올 수 없습니다: " + e.getMessage());
            return "redirect:/cart?error=" + e.getMessage();
        }

        return "payment/checkout";
    }

    /**
     * 상품상세에서 바로 결제페이지로
     * GET /payments/direct
     */
    @GetMapping("/direct")
    public String directCheckoutPage(
            @AuthenticationPrincipal LoginUser loginUser,
            @RequestParam Long productId,
            @RequestParam Integer quantity,
            @RequestParam(required = false) String optionIds,
            Model model) {

        try {
            // optionIds를 List<Long>으로 변환
            List<Long> optionIdList = new ArrayList<>();
            if (optionIds != null && !optionIds.isEmpty()) {
                String[] ids = optionIds.split(",");
                for (String id : ids) {
                    try {
                        optionIdList.add(Long.parseLong(id.trim()));
                    } catch (NumberFormatException ignored) {
                        // 잘못된 optionId는 무시
                    }
                }
            }

            DirectCheckoutResponse checkoutData = paymentService.prepareDirectCheckout(
                    productId, quantity, optionIdList);
            model.addAttribute("directItems", checkoutData);
            model.addAttribute("isFromCart", false);

        } catch (Exception e) {
            model.addAttribute("errorMessage", "결제 정보를 준비하는 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/products/" + productId + "?error=" + e.getMessage();
        }

        return "payment/checkout";
    }

    /**
     * POST /payments/checkout
     */
    @PostMapping("/checkout")
    public String processCheckout(@AuthenticationPrincipal LoginUser loginUser,
                                  @ModelAttribute @Valid CheckoutRequest request,
                                  Model model){
        request.setMemberId(loginUser.getMemberId());

        CheckoutResponse checkoutData = paymentService.processCheckout(request);

        return "orders/Details";
    }

}
