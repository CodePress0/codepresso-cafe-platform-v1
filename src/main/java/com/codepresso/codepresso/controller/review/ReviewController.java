package com.codepresso.codepresso.controller.review;

import com.codepresso.codepresso.dto.product.ReviewCreateRequest;
import com.codepresso.codepresso.dto.product.ReviewResponse;
import com.codepresso.codepresso.dto.product.ReviewUpdateRequest;
import com.codepresso.codepresso.entity.product.Review;
import com.codepresso.codepresso.security.LoginUser;
import com.codepresso.codepresso.service.product.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/users/reviews")
public class ReviewController {

    private final ReviewService reviewService;

    // 4. 리뷰 작성
    @PostMapping("/")
    public ResponseEntity<ReviewResponse> createReview(@AuthenticationPrincipal LoginUser loginUser
            , @RequestBody ReviewCreateRequest request) {
        Long memberId = loginUser.getMemberId();

        ReviewResponse review = reviewService.createReview(memberId, request);
        return ResponseEntity.status(HttpStatus.CREATED).body(review);
    }

    // 5. 리뷰 수정
    @PatchMapping("/{reviewId}")
    public ResponseEntity<ReviewResponse> editReview(@AuthenticationPrincipal LoginUser loginUser,
            @PathVariable Long reviewId,
            @RequestBody ReviewUpdateRequest request) {
        Long memberId = loginUser.getMemberId();

        ReviewResponse review = reviewService.editReview(memberId, reviewId, request);
        return ResponseEntity.ok(review);
    }

    // TODO: 추가 구현 필요한 API들

    // 6. 리뷰 삭제
    // @DeleteMapping("/reviews/{reviewId}")
    // public ResponseEntity<Void> deleteReview(@PathVariable Long reviewId) {
    //     reviewService.deleteReview(reviewId);
    //     return ResponseEntity.noContent().build();
    // }
}
