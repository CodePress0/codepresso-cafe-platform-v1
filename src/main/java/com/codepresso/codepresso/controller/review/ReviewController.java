package com.codepresso.codepresso.controller.review;

import com.codepresso.codepresso.dto.product.ReviewCreateRequest;
import com.codepresso.codepresso.dto.product.ReviewResponse;
import com.codepresso.codepresso.dto.product.ReviewUpdateRequest;
import com.codepresso.codepresso.security.LoginUser;
import com.codepresso.codepresso.service.product.ReviewService;
import lombok.RequiredArgsConstructor;
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
        return ResponseEntity.ok(review);
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


    // 6. 리뷰 삭제
    @DeleteMapping("/{reviewId}")
    public ResponseEntity<Void> deleteReview(@AuthenticationPrincipal LoginUser loginUser,
                                             @PathVariable Long reviewId) {
        Long memberId = loginUser.getMemberId();

        reviewService.deleteReview(memberId, reviewId);

        return ResponseEntity.noContent().build(); // 상태 204, body 없음
    }
}
