package com.codepresso.codepresso.dto.auth.order;

import lombok.Builder;
import lombok.Data;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Bool;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 주문 목록 응답 DTO
 * */
@Data
@Builder
public class OrderListResponse {

    private List<OrderSummary> orders;

    @Data
    @Builder
    public static class OrderSummary {
        private Long orderId;
        private String orderNumber; // 주문번호 -> 그냥 orders의 PK를 쓰면 1년뒤엔 어마무시하게 늘어나있는데 어떻게 해결할것인지?
        private LocalDateTime orderDate;
        private String productionStatus; // 주문접수, 제조중, 제조완료, 픽업완료
        private String branchName;
        private Boolean isTakeout;
        private LocalDateTime pickupTime;
        private Integer totalAmount;
        private String representativeName; // 대표 상품명
        private String productImage; // 상품 이미지 URL (하드코딩)
        private Boolean canReview; // 리뷰 작성 가능 여부 (픽업완료 상태만)
    }
}
