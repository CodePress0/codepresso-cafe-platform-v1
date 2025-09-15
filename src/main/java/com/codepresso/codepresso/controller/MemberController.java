package com.codepresso.codepresso.controller;

import com.codepresso.codepresso.dto.AuthResponse;
import com.codepresso.codepresso.dto.FavoriteListResponse;
import com.codepresso.codepresso.dto.ProfileUpdateRequest;
import com.codepresso.codepresso.dto.UserDetailResponse;
import com.codepresso.codepresso.service.FavoriteService;
import com.codepresso.codepresso.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * 회원 관련 API 컨트롤러
 * 5가지 기능: 내정보조회, 프로필변경, 즐겨찾기추가, 즐겨찾기목록, 즐겨찾기삭제
 */
@RestController
@RequestMapping("/v1/users")
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;
    private final FavoriteService favoriteService;

    /**
     * 내정보조회 - GET /v1/users
     * 현재 로그인한 사용자의 정보를 조회합니다.
     * 
     * @param memberId 회원 ID (실제로는 JWT 토큰에서 추출)
     * @return 회원 상세 정보
     */
    @GetMapping
    public ResponseEntity<UserDetailResponse> getMyInfo(@RequestParam Long memberId) {
        try {
            UserDetailResponse response = memberService.getMemberDetails(memberId);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    /**
     * 프로필변경 - PATCH /v1/users/profile
     * 회원의 프로필 정보를 변경합니다.
     * 
     * @param memberId 회원 ID (실제로는 JWT 토큰에서 추출)
     * @param request 프로필 변경 요청 데이터
     * @return 변경된 회원 상세 정보
     */
    @PatchMapping("/profile")
    public ResponseEntity<UserDetailResponse> updateProfile(
            @RequestParam Long memberId,
            @RequestBody ProfileUpdateRequest request) {
        try {
            UserDetailResponse response = memberService.updateMemberProfile(memberId, request);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    /**
     * 즐겨찾기추가 - POST /v1/users/favorites
     * 즐겨찾기에 상품을 추가합니다.
     * 
     * @param memberId 회원 ID (실제로는 JWT 토큰에서 추출)
     * @param productId 추가할 상품 ID
     * @return 성공/실패 응답
     */
    @PostMapping("/favorites")
    public ResponseEntity<AuthResponse> addFavorite(
            @RequestParam Long memberId,
            @RequestParam Long productId) {
        try {
            AuthResponse response = favoriteService.addFavorite(memberId, productId);
            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest()
                    .body(AuthResponse.builder()
                            .success(false)
                            .message(e.getMessage())
                            .build());
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body(AuthResponse.builder()
                            .success(false)
                            .message("즐겨찾기 추가 중 오류가 발생했습니다.")
                            .build());
        }
    }

    /**
     * 즐겨찾기목록 - GET /v1/users/favorites
     * 회원의 즐겨찾기 목록을 조회합니다.
     * 
     * @param memberId 회원 ID (실제로는 JWT 토큰에서 추출)
     * @return 즐겨찾기 목록
     */
    @GetMapping("/favorites")
    public ResponseEntity<FavoriteListResponse> getFavoriteList(@RequestParam Long memberId) {
        try {
            FavoriteListResponse response = favoriteService.getFavoriteList(memberId);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    /**
     * 즐겨찾기삭제 - DELETE /v1/users/favorites/{productId}
     * 즐겨찾기에서 상품을 삭제합니다.
     * 
     * @param memberId 회원 ID (실제로는 JWT 토큰에서 추출)
     * @param productId 삭제할 상품 ID
     * @return 성공/실패 응답
     */
    @DeleteMapping("/favorites/{productId}")
    public ResponseEntity<AuthResponse> removeFavorite(
            @RequestParam Long memberId,
            @PathVariable Long productId) {
        try {
            AuthResponse response = favoriteService.removeFavorite(memberId, productId);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body(AuthResponse.builder()
                            .success(false)
                            .message("즐겨찾기 삭제 중 오류가 발생했습니다.")
                            .build());
        }
    }
}
