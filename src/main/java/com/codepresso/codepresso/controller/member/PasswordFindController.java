package com.codepresso.codepresso.controller.member;

import com.codepresso.codepresso.dto.member.PasswordFindRequest;
import com.codepresso.codepresso.dto.member.PasswordFindResponse;
import com.codepresso.codepresso.dto.member.PasswordResetRequest;
import com.codepresso.codepresso.dto.member.PasswordResetResponse;
import com.codepresso.codepresso.service.member.PasswordFindService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * 비밀번호 찾기 RESTful API 컨트롤러
 */
@RestController
@RequestMapping("/api")
public class PasswordFindController {

    private final PasswordFindService passwordFindService;

    public PasswordFindController(PasswordFindService passwordFindService) {
        this.passwordFindService = passwordFindService;
    }

    /**
     * 비밀번호 찾기 - 사용자 확인 및 인증번호 발급
     */
    @PostMapping("/password/find")
    public ResponseEntity<PasswordFindResponse> findPassword(@RequestBody PasswordFindRequest request) {
        try {
            PasswordFindResponse response = passwordFindService.findPassword(request);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            PasswordFindResponse errorResponse = PasswordFindResponse.builder()
                    .success(false)
                    .message(e.getMessage())
                    .build();
            return ResponseEntity.badRequest().body(errorResponse);
        }
    }

    /**
     * 비밀번호 재설정
     */
    @PostMapping("/password/reset")
    public ResponseEntity<PasswordResetResponse> resetPassword(@RequestBody PasswordResetRequest request) {
        try {
            PasswordResetResponse response = passwordFindService.resetPassword(request);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            PasswordResetResponse errorResponse = PasswordResetResponse.builder()
                    .success(false)
                    .message(e.getMessage())
                    .build();
            return ResponseEntity.badRequest().body(errorResponse);
        }
    }
}
