package com.codepresso.codepresso.controller.review;

import com.codepresso.codepresso.dto.product.ReviewCreateRequest;
import com.codepresso.codepresso.dto.product.ReviewResponse;
import com.codepresso.codepresso.dto.product.ReviewUpdateRequest;
import com.codepresso.codepresso.security.LoginUser;
import com.codepresso.codepresso.service.ReviewFileUploadService;
import com.codepresso.codepresso.service.product.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/users/reviews")
public class ReviewController {

    private final ReviewService reviewService;
    private final ReviewFileUploadService fileUploadService;

    /**
     * 리뷰 작성
     */
    @PostMapping("/")
    public ResponseEntity<ReviewResponse> createReview(@AuthenticationPrincipal LoginUser loginUser,
                                                       @ModelAttribute ReviewCreateRequest request) {
        Long memberId = loginUser.getMemberId();

        // 파일 업로드 처리
        String photoUrl = null;
        if (request.getPhotos() != null && !request.getPhotos().isEmpty()) {
            try {
                photoUrl = fileUploadService.saveFile(request.getPhotos());
            } catch (Exception e) {
                // 파일 업로드 실패 시 로그 처리 (선택사항)
            }
        }

        ReviewResponse review = reviewService.createReview(memberId, request, photoUrl);
        return ResponseEntity.ok(review);
    }

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
        Long memberId = loginUser.getMemberId();

        reviewService.deleteReview(memberId, reviewId);

        return ResponseEntity.noContent().build(); // 상태 204, body 없음
    }
}
