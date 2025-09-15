package com.codepresso.codepresso.service;

import com.codepresso.codepresso.dto.ProfileUpdateRequest;
import com.codepresso.codepresso.dto.UserDetailResponse;
import com.codepresso.codepresso.entity.Member;
import com.codepresso.codepresso.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.NoSuchElementException;

/**
 * 회원 관련 비즈니스 로직을 처리하는 서비스 클래스
 */
@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;

    /**
     * 특정 회원의 상세 정보를 조회합니다.
     *
     * @param memberId 조회할 회원의 ID
     * @return 회원의 상세 정보 DTO
     * @throws NoSuchElementException 해당 ID의 회원이 없을 경우
     */
    @Transactional(readOnly = true)
    public UserDetailResponse getMemberDetails(Long memberId) {
        Member member = memberRepository.findById(memberId)
                .orElseThrow(() -> new NoSuchElementException("Member not found with id: " + memberId));

        return UserDetailResponse.builder()
                .memberId(member.getId())
                .accountId(member.getAccountId())
                .name(member.getName())
                .nickname(member.getNickname())
                .birthDate(member.getBirthDate())
                .phone(member.getPhone())
                .email(member.getEmail())
                .profileImage(member.getProfileImage())
                .role(member.getRole())
                .build();
    }

    /**
     * 회원의 프로필 정보를 변경합니다.
     *
     * @param memberId 변경할 회원의 ID
     * @param request 프로필 변경 요청 DTO
     * @return 변경된 회원의 상세 정보 DTO
     * @throws NoSuchElementException 해당 ID의 회원이 없을 경우
     */
    @Transactional
    public UserDetailResponse updateMemberProfile(Long memberId, ProfileUpdateRequest request) {
        Member member = memberRepository.findById(memberId)
                .orElseThrow(() -> new NoSuchElementException("Member not found with id: " + memberId));

        // 요청에 포함된 필드만 업데이트
        if (request.getNickname() != null) {
            member.setNickname(request.getNickname());
        }
        if (request.getName() != null) {
            member.setName(request.getName());
        }
        if (request.getPhone() != null) {
            member.setPhone(request.getPhone());
        }
        if (request.getBirthDate() != null) {
            member.setBirthDate(request.getBirthDate());
        }
        if (request.getProfileImage() != null) {
            member.setProfileImage(request.getProfileImage());
        }

        Member updatedMember = memberRepository.save(member);

        return UserDetailResponse.builder()
                .memberId(updatedMember.getId())
                .accountId(updatedMember.getAccountId())
                .name(updatedMember.getName())
                .nickname(updatedMember.getNickname())
                .birthDate(updatedMember.getBirthDate())
                .phone(updatedMember.getPhone())
                .email(updatedMember.getEmail())
                .profileImage(updatedMember.getProfileImage())
                .role(updatedMember.getRole())
                .build();
    }
}
