package com.codepresso.codepresso.repository.member.order;

import com.codepresso.codepresso.entity.order.Orders;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface OrdersRepository extends JpaRepository<Orders, Long> {

    /**
     * 회원별 주문 목록 조회 (최신순)
     * */
    List<Orders> findByMemberIdOrderByOrderDateDesc(Long memberId);

    /**
     * 회원별 + 기간별 주문 목록 조회 (최신순)
     * */
    @Query("SELECT o FROM Orders o WHERE o.member.id = :memberId AND o.orderDate >= :startDate ORDER BY o.orderDate DESC ")
    List<Orders> findByMemberIdAndOrderDateAfterOrderByOrderDateDesc(
            @Param("memberId") Long memberId,
            @Param("startDate") LocalDateTime startDate);

    /**
     * 특정 기간 내 주문 개수 조회 (주문번호 생성용)
     * */
    long countByOrderDateBetween(
            @Param("startOfDay") LocalDateTime startOfDay,
            @Param("endOfDay") LocalDateTime endOfDay);

    /**
     * 회원별 주문 개수 조회
     * */
    long countByMemberId(Long memberId);

    /**
     * 지점별 주문 목록 조회
     * */
    @Query("SELECT o FROM Orders o WHERE o.branch.id = :branchId order by o.orderDate DESC")
    List<Orders> findByBranchIdOrderByOrderDateDesc(@Param("branchId") Long branchId);

    /**
     * 주문 상태별 조회
     * */
    List<Orders> findByProductionStatusOrderByOrderDateDesc(String productionStatus);

    /**
     * 회원 + 상태별 주문 조회
     * */
    List<Orders> findByMemberIdAndProductionStatusOrderByOrderDateDesc(
            @Param("memberId") Long memberId,
            @Param("status") String productionStatus);

    /**
     * 픽업 시간 기준 조회 (픽업 예정 주문들)
     * */
    List<Orders> findByPickupTimeBetweenOrderByPickupTimeAsc(
            @Param("startTime") LocalDateTime startTime,
            @Param("endTime") LocalDateTime endTime);

    /**
     * 테이크아웃 여부별 주문 조회
     */
    List<Orders> findByIsTakeoutOrderByOrderDateDesc(Boolean isTakeout);

    /**
     * 특정 상태이면서 특정 시간 이전에 주문된 것들 조회 (상태 업데이트용)
     */
    @Query("SELECT o FROM Orders o WHERE o.productionStatus = :status AND o.orderDate <= :cutoffTime ORDER BY o.orderDate ASC")
    List<Orders> findByProductionStatusAndOrderDateBefore(
            @Param("status") String status,
            @Param("cutoffTime") LocalDateTime cutoffTime);
}
