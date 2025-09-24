package com.codepresso.codepresso.controller.payment;

import com.codepresso.codepresso.dto.cart.CartResponse;
import com.codepresso.codepresso.security.LoginUser;
import com.codepresso.codepresso.service.payment.PaymentService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 결제 페이지 뷰 컨트롤러
 */
@Controller
@RequestMapping("/payments")
@RequiredArgsConstructor
public class PaymentViewController {

    private static final Logger logger = LoggerFactory.getLogger(PaymentViewController.class);
    private final PaymentService paymentService;

    @GetMapping
    public String paymentsPage(
            @AuthenticationPrincipal LoginUser loginUser,
            @RequestParam(required = false) Long branchId,
            Model model) {
        try {
            listCartItems(loginUser, model);

        } catch (Exception e) {
            return "redirect:/cart?error=장바구니 정보를 불러올 수 없습니다";
        }

        return "payment/checkout";
    }

    @PostMapping
    public String paymentsPageFromCart(@AuthenticationPrincipal LoginUser loginUser,
                                       @RequestParam(required = false) Long branchId,
                                       Model model) {

        try {
            listCartItems(loginUser, model);
        } catch (Exception e) {
            logger.error("결제 페이지 요청 중 예상치 못한 오류", e);
            return "redirect:/cart?error=장바구니 정보를 불러올 수 없습니다";
        }

        return "payment/checkout";
    }

    private void listCartItems(@AuthenticationPrincipal LoginUser loginUser, Model model) {
        CartResponse cartData = paymentService.getValidCart(loginUser.getMemberId());

        int totalAmount = paymentService.calculateTotalAmountFromCart(cartData);
        int totalQuantity = paymentService.calculateTotalQuantityFromCart(cartData);

        model.addAttribute("cartData", cartData);
        model.addAttribute("totalAmount", totalAmount);
        model.addAttribute("totalQuantity", totalQuantity);

    }
}
