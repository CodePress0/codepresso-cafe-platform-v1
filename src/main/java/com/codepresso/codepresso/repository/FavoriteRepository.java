package com.codepresso.codepresso.repository;

import com.codepresso.codepresso.entity.Favorite;
import com.codepresso.codepresso.entity.FavoriteId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 즐겨찾기 Repository
 * Favorite 엔티티의 데이터 접근을 담당
 */
@Repository
public interface FavoriteRepository extends JpaRepository<Favorite, FavoriteId> {

    /**
     * 회원의 즐겨찾기 목록 조회 (정렬순서대로)
     * @param memberId 회원 ID
     * @return 즐겨찾기 목록
     */
    @Query("SELECT f FROM Favorite f WHERE f.memberId = :memberId ORDER BY f.orderby ASC")
    List<Favorite> findByMemberIdOrderByOrderbyAsc(@Param("memberId") Long memberId);

    /**
     * 회원의 특정 상품 즐겨찾기 조회
     * @param memberId 회원 ID
     * @param productId 상품 ID
     * @return 즐겨찾기 정보
     */
    Optional<Favorite> findByMemberIdAndProductId(Long memberId, Long productId);

    /**
     * 회원의 즐겨찾기 개수 조회
     * @param memberId 회원 ID
     * @return 즐겨찾기 개수
     */
    long countByMemberId(Long memberId);
}
