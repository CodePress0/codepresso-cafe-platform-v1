package com.codepresso.codepresso.dto.auth.payment;

import com.codepresso.codepresso.entity.payment.Payment;
import com.codepresso.codepresso.entity.payment.PaymentDetail;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 결제하기 응답 DTO
 * */
@Data
@Builder
public class CheckoutResponse {

    private Long orderId;
    private String productionStatus;
    private LocalDateTime orderDate;
    private LocalDateTime pickupTime;
    private Boolean isTakeout;
    private String requestNote;
    private Integer totalAmount;

    private List<CheckoutResponse.OrderItem> orderItems;

    @Data
    @Builder
    public static class OrderItem {
        private Long orderDetailId;
        private String productName;
        private Integer quantity;
        private Integer price;
        private List<String> optionNames;
    }

}
