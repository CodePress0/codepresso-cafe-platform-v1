package com.codepresso.codepresso.dto.product;

import com.codepresso.codepresso.entity.product.Review;
import lombok.Getter;

import java.math.BigDecimal;

@Getter
public class ReviewListResponse {
    private Long reviewId;
    private String nickname;
    private BigDecimal rating;
    private String photoUrl;
    private Long productId;

    public ReviewListResponse(Review review) {
        reviewId = review.getId();
        nickname = review.getMember().getNickname();
        rating = review.getRating();
        photoUrl = review.getPhotoUrl();
        // productId = review.getOrdersDetail().getProduct().getId();
    }
}