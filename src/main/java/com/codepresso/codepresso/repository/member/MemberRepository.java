package com.codepresso.codepresso.repository.member;

import com.codepresso.codepresso.entity.member.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, Long> {
    boolean existsByAccountId(String accountId);
    boolean existsByNickname(String nickname);
    boolean existsByEmail(String email);
    Optional<Member> findByAccountId(String accountId);
    Optional<Member> findByAccountIdAndEmail(String accountId, String email);
}
