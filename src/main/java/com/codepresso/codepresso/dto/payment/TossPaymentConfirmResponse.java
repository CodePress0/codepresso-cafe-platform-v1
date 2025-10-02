package com.codepresso.codepresso.dto.payment;

import lombok.Data;

// TossPaymentConfirmResponse.java
@Data
public class TossPaymentConfirmResponse {
    private String paymentKey;
    private String orderId;
    private String orderName;
    private Integer totalAmount;
    private String status;
}

