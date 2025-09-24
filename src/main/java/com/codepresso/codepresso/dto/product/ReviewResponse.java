package com.codepresso.codepresso.dto.product;

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
}
