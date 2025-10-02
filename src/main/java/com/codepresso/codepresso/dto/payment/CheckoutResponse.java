package com.codepresso.codepresso.dto.payment;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 통합 결제 응답 DTO (결제 준비 + 주문 완료 응답 통합)
 * */
@Data
@Builder
public class CheckoutResponse {

    // 주문 완료 후 필드들 (결제 준비 단계에서는 null)
    private Long orderId;
    private String productionStatus;
    private LocalDateTime orderDate;
    private LocalDateTime pickupTime;
    private Boolean isTakeout;
    private String requestNote;

    // 공통 필드
    private Integer totalAmount;
    private Integer totalQuantity;        // 총 수량
    private Boolean isFromCart;           // 장바구니/직접구매 구분

    private List<CheckoutResponse.OrderItem> orderItems;

    @Data
    @Builder
    public static class OrderItem {
        // 기존 필드
        private Long orderDetailId;    // 주문 완료 후에만 사용
        private String productName;
        private Integer quantity;
        private Integer price;
        private List<String> optionNames;

        // 결제 준비용 추가 필드
        private String productPhoto;   // 추가: 상품 이미지
        private Integer unitPrice;     // 추가: 단가
        private Integer lineTotal;     // 추가: 총액
        private Long productId;        // 추가: 상품 ID
        private List<Long> optionIds;  // 추가: 옵션 ID 리스트
    }

}
