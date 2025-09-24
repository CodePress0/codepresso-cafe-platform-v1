package com.codepresso.codepresso.controller.payment;

import com.codepresso.codepresso.dto.cart.CartResponse;
import com.codepresso.codepresso.entity.branch.Branch;
import com.codepresso.codepresso.security.LoginUser;
import com.codepresso.codepresso.service.payment.PaymentService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 결제 페이지 뷰 컨트롤러
 */
@Controller
@RequestMapping("/payments")
@RequiredArgsConstructor
public class PaymentViewController {

    private static final Logger logger = LoggerFactory.getLogger(PaymentViewController.class);
    private final PaymentService paymentService;

    @GetMapping("")
    public String paymentsPage(
            @AuthenticationPrincipal LoginUser loginUser,
            @RequestParam(value = "branchId", required = false) String branchId,
            Model model) {
        try {
            CartResponse cartData = paymentService.getValidCart(loginUser.getMemberId());
            // 요청 파라미터로 넘어온 branchId가 있으면 우선 사용, 없으면 기본값 사용
            Branch defaultBranch = paymentService.getValidBranch(branchId != null ? branchId : "1");

            int totalAmount = paymentService.calculateTotalAmountFromCart(cartData);
            int totalQuantity = paymentService.calculateTotalQuantityFromCart(cartData);

            model.addAttribute("cartData", cartData);
            model.addAttribute("totalAmount", totalAmount);
            model.addAttribute("totalQuantity", totalQuantity);
            model.addAttribute("branch", defaultBranch);

        } catch (IllegalArgumentException e) {
            return "redirect:/cart?error=" + e.getMessage();
        } catch (Exception e) {
            return "redirect:/cart?error=장바구니 정보를 불러올 수 없습니다";
        }

        return "payment/checkout";
    }

    @PostMapping("")
    public String paymentsPageFromCart(@AuthenticationPrincipal LoginUser loginUser,
                                       @RequestParam(required = false) String branchId,
                                       Model model) {
        logger.info("장바구니에서 결제 페이지 요청 - memberId: {}, branchId: '{}'", loginUser.getMemberId(), branchId);
        
        try {
            CartResponse cartData = paymentService.getValidCart(loginUser.getMemberId());
            logger.info("장바구니 조회 성공 - 아이템 수: {}", cartData.getItems() != null ? cartData.getItems().size() : 0);
            
            Branch branch = paymentService.getValidBranch(branchId);
            //logger.info("매장 조회 성공 - branchId: {}, branchName: {}", branch.getBranchId(), branch.getBranchName());

            int totalAmount = paymentService.calculateTotalAmountFromCart(cartData);
            int totalQuantity = paymentService.calculateTotalQuantityFromCart(cartData);

            model.addAttribute("cartData", cartData);
            model.addAttribute("totalAmount", totalAmount);
            model.addAttribute("totalQuantity", totalQuantity);
            model.addAttribute("branch", branch);

        } catch (IllegalArgumentException e) {
            logger.warn("결제 페이지 요청 실패 - IllegalArgumentException: {}", e.getMessage());
            return "redirect:/cart?error=" + e.getMessage();
        } catch (Exception e) {
            logger.error("결제 페이지 요청 중 예상치 못한 오류", e);
            return "redirect:/cart?error=장바구니 정보를 불러올 수 없습니다";
        }

        return "payment/checkout";
    }
}

