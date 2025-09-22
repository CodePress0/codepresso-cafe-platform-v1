package com.codepresso.codepresso.dto.product;

import com.codepresso.codepresso.entity.product.Review;
import lombok.Getter;

import java.math.BigDecimal;
import java.util.List;

@Getter
public class ReviewListResponse {
    private Long reviewId;
    private String nickname;
    private BigDecimal rating;
    private String content;
    private String photoUrl;

    public ReviewListResponse(Review review) {
        reviewId = review.getId();
        nickname = review.getMember().getNickname();
        rating = review.getRating();
        content = review.getContent();
        photoUrl = review.getPhotoUrl();
    }
}