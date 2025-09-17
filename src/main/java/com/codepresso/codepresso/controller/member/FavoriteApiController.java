package com.codepresso.codepresso.controller.member;

import com.codepresso.codepresso.dto.AuthResponse;
import com.codepresso.codepresso.dto.member.FavoriteListResponse;
import com.codepresso.codepresso.dto.member.FavoriteRequest;
import com.codepresso.codepresso.service.member.FavoriteService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * 즐겨찾기 관련 RESTful API 컨트롤러
 * 즐겨찾기추가, 즐겨찾기목록, 즐겨찾기삭제 API 엔드포인트 제공
 */
@RestController
@RequestMapping("/users")
@RequiredArgsConstructor
public class FavoriteApiController {

    private final FavoriteService favoriteService;

    /**
     * 즐겨찾기 추가 API
     * 회원이 상품을 즐겨찾기에 추가
     * 
     * @param memberId 회원 ID
     * @param request 즐겨찾기 추가 요청
     * @return ResponseEntity<AuthResponse> 성공/실패 응답
     */
    @PostMapping("/favorites")
    public ResponseEntity<AuthResponse> addFavorite(
            @RequestParam Long memberId,
            @RequestBody FavoriteRequest request) {
        
        AuthResponse response = favoriteService.addFavorite(memberId, request);
        
        if (response.isSuccess()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.badRequest().body(response);
        }
    }

    /**
     * 즐겨찾기 목록 조회 API
     * 회원의 즐겨찾기 목록을 조회
     * 
     * @param memberId 회원 ID
     * @return ResponseEntity<FavoriteListResponse> 즐겨찾기 목록 응답
     */
    @GetMapping("/favorites")
    public ResponseEntity<FavoriteListResponse> getFavoriteList(
            @RequestParam Long memberId) {
        
        FavoriteListResponse response = favoriteService.getFavoriteList(memberId);
        return ResponseEntity.ok(response);
    }

    /**
     * 즐겨찾기 삭제 API
     * 회원의 특정 상품을 즐겨찾기에서 제거
     * 
     * @param memberId 회원 ID
     * @param productId 삭제할 상품 ID
     * @return ResponseEntity<AuthResponse> 성공/실패 응답
     */
    @DeleteMapping("/favorites/{productId}")
    public ResponseEntity<AuthResponse> removeFavorite(
            @RequestParam Long memberId,
            @PathVariable Long productId) {
        
        AuthResponse response = favoriteService.removeFavorite(memberId, productId);
        
        if (response.isSuccess()) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.badRequest().body(response);
        }
    }
}
