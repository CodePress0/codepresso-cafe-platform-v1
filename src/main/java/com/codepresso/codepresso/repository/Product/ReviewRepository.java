package com.codepresso.codepresso.repository.Product;

import com.codepresso.codepresso.dto.product.ReviewListResponse;
import com.codepresso.codepresso.entity.product.Review;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {
//    "SELECT * FROM review r LEFT OUTER JOIN orderDetail od " +
//            "ON od.order_detail_id = r.order_detail_id " +
//            "WHERE or.order_detail_id = :productId", nativeQuery = true

    @Query("SELECT r FROM Review r LEFT JOIN FETCH r.ordersDetail od WHERE od.product.id = :productId")
    List<ReviewListResponse> findByProductReviews(@Param("productId") Long productId);

}
