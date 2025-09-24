package com.codepresso.codepresso.repository.product;

import com.codepresso.codepresso.dto.product.ReviewListResponse;
import com.codepresso.codepresso.entity.order.OrdersDetail;
import com.codepresso.codepresso.entity.product.Review;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

    @Query("SELECT r FROM Review r LEFT JOIN FETCH r.ordersDetail od WHERE od.product.id = :productId")
    List<Review> findByProductReviews(@Param("productId") Long productId);

    // 중복 리뷰 방지를 위한 존재 여부 확인
    boolean existsByOrdersDetail(OrdersDetail ordersDetail);

}