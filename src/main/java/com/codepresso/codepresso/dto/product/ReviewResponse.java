package com.codepresso.codepresso.dto.product;

import com.codepresso.codepresso.entity.product.Review;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
public class ReviewResponse {
    private Long reviewId;
    private Long orderDetailId;
    private Long memberId;
    private BigDecimal rating;
    private String content;
    private String photoUrl;
    private LocalDateTime createdAt;

    public static ReviewResponse fromEntity(Review review) {
        return ReviewResponse.builder()
                .reviewId(review.getId())
                .orderDetailId(review.getOrdersDetail().getId())
                .memberId(review.getMember().getId())
                .rating(review.getRating())
                .content(review.getContent())
                .photoUrl(review.getPhotoUrl())
                .createdAt(review.getCreatedAt())
                .build();
    }
}
