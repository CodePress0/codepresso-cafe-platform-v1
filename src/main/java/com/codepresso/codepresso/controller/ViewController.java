package com.codepresso.codepresso.controller;

import com.codepresso.codepresso.dto.member.FavoriteListResponse;
import com.codepresso.codepresso.security.LoginUser;
import com.codepresso.codepresso.service.member.FavoriteService;
import lombok.Getter;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * JSP 뷰를 반환하는 컨트롤러
 */
@Controller
public class ViewController {

    @Getter
    private final FavoriteService favoriteService;

    public ViewController(FavoriteService favoriteService) {
        this.favoriteService = favoriteService;
    }

    @GetMapping("/")
    public String index() { return "index"; }

    @GetMapping("/auth/signup") // /WEB-INF/views/auth/signup.jsp
    public String signupPage() {
        return "auth/signup";
    }

    @GetMapping("/auth/login") // 로그인 화면 (이미 로그인 시 매장 선택으로 이동)
    public String loginPage() {
        return "auth/login";
    }

    // 매장 목록은 BranchController에서 처리

    @GetMapping("/member/mypage") // GET /member/mypage → 마이페이지 (보안설정에서 보호)
    public String mypage() {
        return "member/mypage";
    }

    /**
     * 즐겨찾기 목록
     */
    @GetMapping("/favorites")
    public String favoriteList(Authentication authentication, Model model) {
        Long memberId = null;
        Object principal = authentication.getPrincipal();
        if (principal instanceof LoginUser lu) {
            memberId = lu.getMemberId();
        }
        try {
            // 즐겨찾기 목록 조회 후 JSP에 전달
            FavoriteListResponse favoriteList = favoriteService.getFavoriteList(memberId);
            model.addAttribute("favoriteList", favoriteList);
        } catch (Exception e) {
            // 에러 발생 시 에러 메시지를 JSP에 전달
            model.addAttribute("error", e.getMessage());
        }
        return "member/favorite-list";
    }


}
