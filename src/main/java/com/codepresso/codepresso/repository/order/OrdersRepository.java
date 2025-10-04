package com.codepresso.codepresso.repository.order;

import com.codepresso.codepresso.entity.order.Orders;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface OrdersRepository extends JpaRepository<Orders, Long> {

    /**
     * 회원별 주문 목록 조회 (최신순 + 페이징)
     * */
    // List<Orders> findByMemberIdOrderByOrderDateDesc(Long memberId);
    @Query("SELECT DISTINCT o FROM Orders o " +
            "LEFT JOIN FETCH o.branch " +
            "LEFT JOIN FETCH o.member " +
            "WHERE o.member.id = :memberId " +
            "ORDER BY o.orderDate DESC")
    Page<Orders> findByMemberIdWithPaging(@Param("memberId") Long memberId, Pageable pageable);

    /**
     * 회원별 + 기간별 주문 목록 조회 (최신순 + 페이징)
     * */
//    @Query("SELECT o FROM Orders o WHERE o.member.id = :memberId AND o.orderDate >= :startDate ORDER BY o.orderDate DESC ")
//    List<Orders> findByMemberIdAndOrderDateAfterOrderByOrderDateDesc(
//            @Param("memberId") Long memberId,
//            @Param("startDate") LocalDateTime startDate);
    @Query("SELECT DISTINCT o FROM Orders o " +
            "LEFT JOIN FETCH o.branch " +
            "LEFT JOIN FETCH o.member " +
            "WHERE o.member.id = :memberId " +
            "AND o.orderDate >= :startDate " +
            "ORDER BY o.orderDate DESC")
    Page<Orders> findByMemberIdAndDateWithPaging(
            @Param("memberId") Long memberId,
            @Param("startDate") LocalDateTime startDate,
            Pageable pageable);

    /**
     * 해당 일자(startOfDay~endOfDay) 중에서 특정 주문시각(orderDate)까지 생성된 주문 수
     * (일일 순번 계산용)
     */
    long countByOrderDateBetweenAndOrderDateLessThanEqual(
            @Param("startOfDay") LocalDateTime startOfDay,
            @Param("endOfDay") LocalDateTime endOfDay,
            @Param("orderDate") LocalDateTime orderDate);

    /**
     * 회원별 주문 개수 조회
     * */
    long countByMemberId(Long memberId);
}
