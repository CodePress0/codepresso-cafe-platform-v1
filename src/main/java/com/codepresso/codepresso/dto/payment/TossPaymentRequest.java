package com.codepresso.codepresso.dto.payment;

import lombok.Data;

@Data
public class TossPaymentRequest {
    private Integer amount;
    private String orderId;
    private String orderName;
    private String customerName;
    private String customerEmail;
    private String successUrl;
    private String failUrl;
}

