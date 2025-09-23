package com.codepresso.codepresso.controller;

import com.codepresso.codepresso.dto.cart.CartResponse;
import com.codepresso.codepresso.dto.member.FavoriteListResponse;
import com.codepresso.codepresso.security.LoginUser;
import com.codepresso.codepresso.service.cart.CartService;
import com.codepresso.codepresso.service.member.FavoriteService;
import com.codepresso.codepresso.service.member.MemberProfileService;
import lombok.Getter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
    private final MemberProfileService memberProfileService;
    private final FavoriteService favoriteService;
    private final CartService cartService;

    public ViewController(MemberProfileService memberProfileService, FavoriteService favoriteService, CartService cartService) {
        this.memberProfileService = memberProfileService;
        this.favoriteService = favoriteService;
        this.cartService = cartService;
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

    @GetMapping("/cart")
    public String viewCart(@AuthenticationPrincipal LoginUser loginUser, Model model) {
        CartResponse cart = null;
        if (loginUser != null) {
            try {
                cart = cartService.getCartByMemberId(loginUser.getMemberId());
            } catch (IllegalArgumentException ignored) {
                // 장바구니가 없으면 빈 화면을 보여준다.
            }
        }
        model.addAttribute("cart", cart);
        return "cart/cart";
    }

    /**
     * 프로필 수정 처리
     */
//    @PostMapping("/profile-update")
//    public String updateProfile(@RequestParam Long memberId, ProfileUpdateRequest request, Model model) {
//        try {
//            // 프로필 수정 후 수정된 정보를 JSP에 전달
//            UserDetailResponse updatedMember = memberProfileService.updateProfile(memberId, request);
//            model.addAttribute("member", updatedMember);
//            model.addAttribute("success", "프로필이 성공적으로 수정되었습니다.");
//        } catch (Exception e) {
//            // 에러 발생 시 에러 메시지를 JSP에 전달
//            model.addAttribute("error", "프로필 수정 중 오류가 발생했습니다: " + e.getMessage());
//        }
//        return "member/mypage";
//    }
}
