package com.codepresso.codepresso.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

/**
 * 프로필 업데이트 요청 DTO
 * 프로필변경 API 요청에 사용
 * 프로필 이미지, 닉네임, 이름, 전화번호, 생년월일 수정 가능
 */
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class ProfileUpdateRequest {

    private String profileImage;
    private String nickname;
    private String name;
    private String phone;
    private LocalDate birthDate;
}
