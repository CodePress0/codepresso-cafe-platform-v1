package com.codepresso.codepresso.service.member;

import com.codepresso.codepresso.dto.member.PasswordFindRequest;
import com.codepresso.codepresso.dto.member.PasswordFindResponse;
import com.codepresso.codepresso.dto.member.PasswordResetRequest;
import com.codepresso.codepresso.dto.member.PasswordResetResponse;
import com.codepresso.codepresso.entity.member.Member;
import com.codepresso.codepresso.repository.member.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.NoSuchElementException;

/**
 * 비밀번호 찾기 서비스
 * - 아이디/이메일로 사용자 확인
 * - 하드코딩된 인증번호로 인증
 * - 비밀번호 재설정
 */
@Service
@RequiredArgsConstructor
public class PasswordFindService {

    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;

    // 하드코딩된 인증번호 (개발용)
    private static final String HARDCODED_VERIFICATION_CODE = "123";

    /**
     * 비밀번호 찾기 - 사용자 확인 및 인증번호 발급
     */
    public PasswordFindResponse findPassword(PasswordFindRequest request) {
        // 아이디와 이메일로 사용자 확인
        Member member = memberRepository.findByAccountIdAndEmail(request.getAccountId(), request.getEmail())
                .orElseThrow(() -> new NoSuchElementException("아이디 또는 이메일이 일치하지 않습니다."));

        // 하드코딩된 인증번호 반환 (개발용)
        return PasswordFindResponse.builder()
                .success(true)
                .message("인증번호가 발급되었습니다. (개발용: 123)")
                .verificationCode(HARDCODED_VERIFICATION_CODE)
                .build();
    }

    /**
     * 비밀번호 재설정
     */
    @Transactional
    public PasswordResetResponse resetPassword(PasswordResetRequest request) {
        // 사용자 확인
        Member member = memberRepository.findByAccountIdAndEmail(request.getAccountId(), request.getEmail())
                .orElseThrow(() -> new NoSuchElementException("아이디 또는 이메일이 일치하지 않습니다."));

        // 인증번호 확인 (하드코딩된 값과 비교)
        if (!HARDCODED_VERIFICATION_CODE.equals(request.getVerificationCode())) {
            throw new IllegalArgumentException("인증번호가 일치하지 않습니다.");
        }

        // 새 비밀번호와 확인 비밀번호 일치 확인
        if (!request.getNewPassword().equals(request.getConfirmPassword())) {
            throw new IllegalArgumentException("새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
        }

        // 비밀번호 유효성 검사
        if (request.getNewPassword().length() < 8) {
            throw new IllegalArgumentException("비밀번호는 8자 이상이어야 합니다.");
        }

        // 비밀번호 암호화 및 저장
        String encodedPassword = passwordEncoder.encode(request.getNewPassword());
        member.setPassword(encodedPassword);
        memberRepository.save(member);

        return PasswordResetResponse.builder()
                .success(true)
                .message("비밀번호가 성공적으로 변경되었습니다.")
                .build();
    }
}
