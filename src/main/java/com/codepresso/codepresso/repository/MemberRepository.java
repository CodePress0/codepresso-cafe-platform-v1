package com.codepresso.codepresso.repository;

import com.codepresso.codepresso.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * 회원 Repository
 * Member 엔티티의 데이터 접근을 담당
 */
@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {

    /**
     * 이메일로 회원 조회
     * @param email 이메일
     * @return 회원 정보
     */
    Optional<Member> findByEmail(String email);

    /**
     * 계정 ID로 회원 조회
     * @param accountId 계정 ID
     * @return 회원 정보
     */
    Optional<Member> findByAccountId(String accountId);
}
