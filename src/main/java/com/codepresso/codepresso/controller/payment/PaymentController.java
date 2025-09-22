package com.codepresso.codepresso.controller.payment;

import com.codepresso.codepresso.dto.payment.CheckoutRequest;
import com.codepresso.codepresso.dto.payment.CheckoutResponse;
import com.codepresso.codepresso.service.payment.PaymentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 결제 관련 컨트롤러
 * */

@RestController
@RequestMapping("/payments")
@RequiredArgsConstructor
public class PaymentController {

    private final PaymentService paymentService;

    /**
     * 결제하기 ( 주문 + 결제 처리 )
     * */
    @PostMapping("/checkout")
    public ResponseEntity<CheckoutResponse> checkout(
            @RequestBody @Valid CheckoutRequest request  // 고객이 보낸 주문정보를 받음
    ) {
        // 결제 서비스에게 "이 주문 처리해줘" 요청
        CheckoutResponse response = paymentService.processCheckout(request);

        // 처리 완료된 결과를 HTTP 200 OK와 함께 고객에게 전송
        return ResponseEntity.ok(response);
    }

}
