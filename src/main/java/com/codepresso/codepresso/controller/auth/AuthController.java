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

    @GetMapping("/check/{field}")
    public Map<String, Object> checkDynamic(@PathVariable("field") CheckField field,
                                            @RequestParam("value") String value) {
        boolean duplicate = switch (field) {
            case NICKNAME -> memberService.isNicknameDuplicate(value);
            case EMAIL -> memberService.isEmailDuplicate(value);
            case ID -> memberService.isAccountIdDuplicate(value);
        };
        Map<String, Object> resp = new HashMap<>();
        resp.put("field", field.asKey());
        resp.put("duplicate", duplicate);
        return resp;
    }

    @GetMapping({"/check", "/check/"})
    public Map<String, Object> checkFallback(
            @RequestParam("value") String value,
            @RequestParam(value = "type", required = false) CheckField type,
            @RequestParam(value = "field", required = false) CheckField field
    ) {
        CheckField target = type != null ? type : (field != null ? field : CheckField.ID);
        boolean duplicate = switch (target) {
            case NICKNAME -> memberService.isNicknameDuplicate(value);
            case EMAIL -> memberService.isEmailDuplicate(value);
            case ID -> memberService.isAccountIdDuplicate(value);
        };
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
}
