package com.codepresso.codepresso.service.product;

import com.codepresso.codepresso.dto.product.ReviewCreateRequest;
import com.codepresso.codepresso.dto.product.ReviewResponse;
import com.codepresso.codepresso.entity.member.Member;
import com.codepresso.codepresso.entity.order.OrdersDetail;
import com.codepresso.codepresso.entity.product.Review;
import com.codepresso.codepresso.repository.member.MemberRepository;
import com.codepresso.codepresso.repository.order.OrdersDetailRepository;
import com.codepresso.codepresso.repository.product.ReviewRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
public class ReviewService {
    private final ReviewRepository reviewRepo;
    private final MemberRepository memberRepo;
    private final OrdersDetailRepository ordersDetailRepo;

    public ReviewResponse createReview(Long memberId, ReviewCreateRequest request) {
        Long orderDetailId = request.getOrderDetailId();

        // 1. 회원 조회 및 검증
        Member member = memberRepo.findById(memberId)
                .orElseThrow(() -> new IllegalArgumentException("회원을 찾을 수 없습니다: " + memberId));

        // 2. 주문상세 조회 및 검증
        OrdersDetail ordersDetail = ordersDetailRepo.findById(orderDetailId)
                .orElseThrow(() -> new IllegalArgumentException("주문 상세를 찾을 수 없습니다: " + orderDetailId));

        // 3. 권한 검증 - 본인 주문인지 확인
        if (!ordersDetail.getOrders().getMember().getId().equals(memberId)) {
            throw new IllegalArgumentException("본인 주문에만 리뷰 작성 가능합니다");
        }

        if (reviewRepo.existsByOrdersDetail(ordersDetail)) {
            throw new IllegalArgumentException("이미 해당 주문에 대한 리뷰가 존재합니다");
        }

        Review review = Review.builder()
                .rating(request.getRating())
                .content(request.getContent())
                .photoUrl(request.getPhotoUrl())
                .member(member)
                .ordersDetail(ordersDetail)
                .createdAt(LocalDateTime.now())
                .build();

        Review savedReview = reviewRepo.save(review);

        return ReviewResponse.builder()
                .reviewId(savedReview.getId())
                .orderDetailId(savedReview.getOrdersDetail().getId())
                .memberId(savedReview.getMember().getId())
                .rating(savedReview.getRating())
                .content(savedReview.getContent())
                .photoUrl(savedReview.getPhotoUrl())
                .createdAt(savedReview.getCreatedAt())
                .build();
    }

    public void delete(Long id) {
        reviewRepo.deleteById(id);
    }
}
