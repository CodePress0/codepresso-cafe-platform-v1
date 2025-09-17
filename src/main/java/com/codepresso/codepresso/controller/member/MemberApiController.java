package com.codepresso.codepresso.controller.member;

import com.codepresso.codepresso.dto.member.ProfileUpdateRequest;
import com.codepresso.codepresso.dto.member.UserDetailResponse;
import com.codepresso.codepresso.service.member.MemberProfileService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.NoSuchElementException;

/**
 * 회원 관련 RESTful API 컨트롤러
 * JSON 형태의 API 응답 처리
 */
@RestController
@RequestMapping("/")
public class MemberApiController {

    private final MemberProfileService memberProfileService;

    public MemberApiController(MemberProfileService memberProfileService) {
        this.memberProfileService = memberProfileService;
    }

    /**
     * 내정보조회 RESTful API
     * 특정 회원의 상세 정보를 JSON 형태로 반환
     * 
     * @param memberId 조회할 회원 ID
     * @return ResponseEntity<UserDetailResponse> 회원 상세 정보 (JSON)
     */
    @GetMapping("/users/{member_id}")
    public ResponseEntity<UserDetailResponse> getMemberInfo(@PathVariable("member_id") Long memberId) {
        UserDetailResponse userDetailResponse = memberProfileService.getMemberInfo(memberId);
        return ResponseEntity.ok(userDetailResponse);
    }

    /**
     * 프로필변경 RESTful API
     * 회원의 프로필 정보를 수정하고 수정된 정보를 JSON 형태로 반환
     * 
     * @param memberId 수정할 회원 ID
     * @param request 수정할 프로필 정보
     * @return ResponseEntity<UserDetailResponse> 수정된 회원 상세 정보 (JSON)
     */
    @PutMapping("/users/{member_id}")
    public ResponseEntity<UserDetailResponse> updateProfile(@PathVariable("member_id") Long memberId, @RequestBody ProfileUpdateRequest request) {
        try {
            UserDetailResponse updatedMember = memberProfileService.updateProfile(memberId, request);
            return ResponseEntity.ok(updatedMember);
        } catch (NoSuchElementException e) {
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }
}
