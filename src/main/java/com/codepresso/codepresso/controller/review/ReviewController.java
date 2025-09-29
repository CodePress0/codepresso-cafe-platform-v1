package com.codepresso.codepresso.controller.review;

import com.codepresso.codepresso.dto.review.MyReviewProjection;
import com.codepresso.codepresso.dto.review.ReviewCreateRequest;
import com.codepresso.codepresso.dto.review.ReviewResponse;
import com.codepresso.codepresso.dto.review.ReviewUpdateRequest;
import com.codepresso.codepresso.security.LoginUser;
import com.codepresso.codepresso.service.ReviewFileUploadService;
import com.codepresso.codepresso.service.product.ReviewService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/users/reviews")
@CrossOrigin(origins = "*", allowedHeaders = "*", methods = {RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE, RequestMethod.PATCH})
public class ReviewController {

    private final ReviewService reviewService;

//    /**
//     * 리뷰 작성
//     */
//    @PostMapping("/")
//    public ResponseEntity<ReviewResponse> createReview(@AuthenticationPrincipal LoginUser loginUser,
//                                                       @ModelAttribute ReviewCreateRequest request) {
//        Long memberId = loginUser.getMemberId();
//
//        // 파일 업로드 처리
//        String photoUrl = null;
//        if (request.getPhotos() != null && !request.getPhotos().isEmpty()) {
//            try {
//                photoUrl = fileUploadService.saveFile(request.getPhotos());
//            } catch (Exception e) {
//                // 파일 업로드 실패 시 로그 처리 (선택사항)
//            }
//        }
//
//        ReviewResponse review = reviewService.createReview(memberId, request, photoUrl);
//        return ResponseEntity.ok(review);
//    }

    /**
     * 리뷰 수정
     */
    @PatchMapping("/{reviewId}")
    public ResponseEntity<ReviewResponse> editReview(@AuthenticationPrincipal LoginUser loginUser,
                                                     @PathVariable Long reviewId,
                                                     @RequestBody ReviewUpdateRequest request) {
        Long memberId = loginUser.getMemberId();

        ReviewResponse review = reviewService.editReview(memberId, reviewId, request);
        return ResponseEntity.ok(review);
    }


    /**
     * 리뷰 삭제
     */
    @DeleteMapping("/{reviewId}")
    public ResponseEntity<Void> deleteReview(@AuthenticationPrincipal LoginUser loginUser,
                                             @PathVariable Long reviewId) {
        log.info("DELETE request received for reviewId: {}", reviewId);
        log.info("Request mapping: /api/users/reviews/{}", reviewId);

        Long memberId = loginUser.getMemberId();
        log.info("Member ID: {}", memberId);

        reviewService.deleteReview(memberId, reviewId);
        log.info("Review deleted successfully for reviewId: {}", reviewId);

        return ResponseEntity.noContent().build(); // 상태 204, body 없음
    }

    /**
     * 내 리뷰 확인
     */
    @GetMapping("/myReviews")
    public ResponseEntity<List<MyReviewProjection>> getMyReviews(@AuthenticationPrincipal LoginUser loginUser) {
        Long memberId = loginUser.getMemberId();

        List<MyReviewProjection> userReviews = reviewService.getReviewsByMember(memberId);

        return ResponseEntity.ok(userReviews);
    }


}