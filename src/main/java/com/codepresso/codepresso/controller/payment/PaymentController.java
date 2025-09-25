package com.codepresso.codepresso.controller.payment;

import com.codepresso.codepresso.dto.payment.CartCheckoutResponse;
import com.codepresso.codepresso.dto.payment.CheckoutRequest;
import com.codepresso.codepresso.dto.payment.CheckoutResponse;
import com.codepresso.codepresso.dto.payment.DirectCheckoutResponse;
import com.codepresso.codepresso.security.LoginUser;
import com.codepresso.codepresso.service.payment.PaymentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * 결제 관련 컨트롤러
 * */

@RestController
@RequestMapping("/api/payments")
@RequiredArgsConstructor
public class PaymentController {

    private final PaymentService paymentService;

    /**
     * 장바구니 결제페이지 데이터 조회 API
     */
    @GetMapping("/cart")
    public ResponseEntity<CartCheckoutResponse> getCartCheckoutData(@AuthenticationPrincipal LoginUser loginUser) {
        CartCheckoutResponse response = paymentService.prepareCartCheckout(loginUser.getMemberId());
        return ResponseEntity.ok(response);
    }

    /**
     * 직접 결제 페이지 데이터 조회 API
     */
    @GetMapping("/direct")
    public ResponseEntity<DirectCheckoutResponse> getDirectCheckoutData(
            @RequestBody @Valid CheckoutRequest.OrderItem orderItem) {
        try {
            DirectCheckoutResponse response = paymentService.prepareDirectCheckout(
                    orderItem.getProductId(),
                    orderItem.getQuantity(),
                    orderItem.getOptionIds());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            throw new IllegalArgumentException("결제 정보를 준비하는 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 결제 처리 API
     * POST /api/payments/checkout
     */
    @PostMapping("/checkout")
    public ResponseEntity<CheckoutResponse> processCheckout(
            @AuthenticationPrincipal LoginUser loginUser,
            @RequestBody @Valid CheckoutRequest request) {
        try {
            request.setMemberId(loginUser.getMemberId());

            CheckoutResponse response = paymentService.processCheckout(request);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            throw new IllegalArgumentException("결제 처리 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

}
