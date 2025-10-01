package com.codepresso.codepresso.dto.review;

import com.codepresso.codepresso.entity.product.Review;
import lombok.Getter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
public class ReviewListResponse {
    private Long reviewId;
    private String nickname;
    private BigDecimal rating;
    private Double avgRating;
    private String content;
    private String photoUrl;
    private LocalDateTime createdAt;

    public ReviewListResponse(Review review, Double avgRating) {
        this.reviewId = review.getId();
        this.nickname = review.getMember().getNickname();
        this.rating = review.getRating();
        this.avgRating = avgRating;
        this.content = review.getContent();
        this.photoUrl = review.getPhotoUrl();
        this.createdAt = review.getCreatedAt();
    }
}