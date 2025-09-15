package com.codepresso.codepresso.entity;

import com.codepresso.codepresso.utils.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "member",
        uniqueConstraints = {
                @UniqueConstraint(name = "uq_member_account", columnNames = "account_id"),
                @UniqueConstraint(name = "uq_member_nickname", columnNames = "nickname")
        })
@Entity
public class Member extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_id")
    private Long id;

    @Column(name = "account_id", nullable = false, length = 50)
    private String accountId;

    @Column(name = "password", length = 100)
    private String password;

    @Column(length = 50)
    private String name;

    @Column(nullable = false, length = 50)
    private String nickname;

    @Column(name = "birth_date")
    private LocalDate birthDate;

    @Column(length = 20)
    private String phone;

    private String email;

    @Column(name = "profile_image")
    private String profileImage;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private Role role; // USER/ADMIN

    @Column(name = "last_login_at")
    private LocalDateTime lastLoginAt; // 마지막 로그인 시간

    public enum Role { USER, ADMIN }

    @PrePersist
    void onCreate() {
        if (role == null) role = Role.USER;
    }
}