package com.codepresso.codepresso.dto.auth.order;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 주문 상세 응답 DTO
 * */
@Data
@Builder
public class OrderDetailResponse {

    // 주문 정보
    private Long orderId;
    private String orderNumber;
    private LocalDateTime orderDate;
    private String productionStatus;
    private LocalDateTime pickupTime;
    private Boolean isTakeout;
    private String requestNote;

    // 지점 정보
    private BranchInfo branch;

    // 주문 상품 목록
    private List<OrderItem> orderItems;

    // 결제정보
    private PaymentInfo payment;

    @Data
    @Builder
    public static class BranchInfo {
        private Long branchId;
        private String branchName;
        private String address;
        private String branchNumber;
    }

    @Data
    @Builder
    public static class OrderItem {
        private Long orderDetailId;
        private String productName;
        private Integer quantity;
        private Integer price;
        private Integer totalPrice;
        private List<String> optionsName;
    }

    @Data
    @Builder
    public static class PaymentInfo {
        private String paymentMethod;
        private Integer totalAmount;
        private LocalDateTime paymentDate;
    }
}
