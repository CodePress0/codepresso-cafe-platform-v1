package com.codepresso.codepresso.controller.auth;

import com.codepresso.codepresso.dto.auth.SignUpRequest;
import com.codepresso.codepresso.entity.member.Member;
import com.codepresso.codepresso.service.member.MemberService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 인증
 */
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@Slf4j
public class AuthController {

    private final MemberService memberService;

    /** 중복체크 */
    @GetMapping("/check")
    public Map<String, Object> check(
            @RequestParam("value") String value,
            @RequestParam(value = "field", required = false) CheckField field
    ) {
        CheckField target = field != null ? field : CheckField.ID;
        boolean duplicate = isDuplicate(target, value);

        Map<String, Object> resp = new HashMap<>();

        resp.put("field", target.asKey());
        resp.put("duplicate", duplicate);

        return resp;
    }

    /** 회원가입 */
    @PostMapping("/signup")
    public ResponseEntity<?> signup(@RequestBody @Valid SignUpRequest request) {
        log.info("[signup] req accountId={}, name={}, phone={}", request.getAccountId(), request.getName(), request.getPhone());

        Member member = memberService.register(
                request.getAccountId(),
                request.getPassword(),
                request.getNickname(),
                request.getEmail(),
                request.getName(),
                request.getPhone()
        );

        log.info("[signup] saved id={}, name={}, phone={}", member.getId(), member.getName(), member.getPhone());

        Map<String, Object> resp = new HashMap<>();
        resp.put("id", member.getId());
        resp.put("accountId", member.getAccountId());
        resp.put("name", member.getName());
        resp.put("phone", member.getPhone());
        resp.put("nickname", member.getNickname());
        resp.put("email", member.getEmail());
        return ResponseEntity.ok(resp);
    }

    private boolean isDuplicate(CheckField target, String value) {
        return switch (target) {
            case NICKNAME -> memberService.isNicknameDuplicate(value);
            case EMAIL -> memberService.isEmailDuplicate(value);
            case ID -> memberService.isAccountIdDuplicate(value);
        };
    }
}
