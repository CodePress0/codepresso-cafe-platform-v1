package com.codepresso.codepresso.controller;

import com.codepresso.codepresso.dto.member.ProfileUpdateRequest;
import com.codepresso.codepresso.dto.member.UserDetailResponse;
import com.codepresso.codepresso.dto.member.FavoriteListResponse;
import com.codepresso.codepresso.service.member.MemberProfileService;
import com.codepresso.codepresso.service.member.FavoriteService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * 뷰 컨트롤러.
 * - JSP를 렌더링하는 엔드포인트를 제공.
 */
@Controller
public class ViewController {

    private final MemberProfileService memberProfileService;
    private final FavoriteService favoriteService;

    public ViewController(MemberProfileService memberProfileService, FavoriteService favoriteService) {
        this.memberProfileService = memberProfileService;
        this.favoriteService = favoriteService;
    }

    
    @GetMapping("/")
    public String index() {
        // /WEB-INF/views/index.jsp
        return "index";
    }

    
    @GetMapping("/auth/signup")
    public String signupPage() {
        // /WEB-INF/views/auth/signup.jsp
        return "auth/signup";
    }






    /**
     * 마이페이지 (회원 정보 조회)
     * - 회원의 상세 정보를 표시하는 페이지
     * - 프로필 수정 모드로 전환 가능
     * 
     * @param memberId 조회할 회원 ID
     * @param model JSP에 전달할 데이터 (회원 정보, 에러 메시지)
     * @return String JSP 페이지 경로
     */
    @GetMapping("/mypage")
    public String myPage(@RequestParam Long memberId, Model model) {
        try {
            // 회원 정보 조회 후 JSP에 전달
            UserDetailResponse memberInfo = memberProfileService.getMemberInfo(memberId);
            model.addAttribute("member", memberInfo);
        } catch (Exception e) {
            // 에러 발생 시 에러 메시지를 JSP에 전달
            model.addAttribute("error", e.getMessage());
        }
        return "member/mypage";
    }

    /**
     * 프로필 수정 처리
     * - 마이페이지에서 수정된 프로필 정보를 저장
     * - 수정 완료 후 마이페이지로 리다이렉트
     * 
     * @param memberId 수정할 회원 ID
     * @param request 수정할 프로필 정보 (이름, 닉네임, 생년월일, 전화번호, 이메일, 프로필이미지)
     * @param model JSP에 전달할 데이터 (수정된 회원 정보, 성공/에러 메시지)
     * @return String JSP 페이지 경로
     */
    @PostMapping("/profile-update")
    public String updateProfile(@RequestParam Long memberId, ProfileUpdateRequest request, Model model) {
        try {
            // 프로필 수정 후 수정된 정보를 JSP에 전달
            UserDetailResponse updatedMember = memberProfileService.updateProfile(memberId, request);
            model.addAttribute("member", updatedMember);
            model.addAttribute("success", "프로필이 성공적으로 수정되었습니다.");
        } catch (Exception e) {
            // 에러 발생 시 에러 메시지를 JSP에 전달
            model.addAttribute("error", "프로필 수정 중 오류가 발생했습니다: " + e.getMessage());
        }
        return "member/mypage";
    }

    /**
     * 즐겨찾기 목록 JSP 화면
     * 회원의 즐겨찾기 목록을 JSP 페이지로 표시
     * 
     * @param memberId 조회할 회원 ID
     * @param model JSP에 전달할 데이터 (즐겨찾기 목록, 에러 메시지)
     * @return String JSP 페이지 경로
     */
    @GetMapping("/favorites")
    public String favoriteList(@RequestParam Long memberId, Model model) {
        try {
            // 즐겨찾기 목록 조회 후 JSP에 전달
            FavoriteListResponse favoriteList = favoriteService.getFavoriteList(memberId);
            model.addAttribute("favoriteList", favoriteList);
            model.addAttribute("memberId", memberId);
        } catch (Exception e) {
            // 에러 발생 시 에러 메시지를 JSP에 전달
            model.addAttribute("error", e.getMessage());
            model.addAttribute("memberId", memberId);
        }
        return "member/favorite-list";
    }
}
