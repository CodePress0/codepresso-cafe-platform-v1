package com.codepresso.codepresso.controller.review;

import com.codepresso.codepresso.dto.review.OrdersDetailResponse;
import com.codepresso.codepresso.security.LoginUser;
import com.codepresso.codepresso.service.order.OrderService;
import com.codepresso.codepresso.service.product.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
@RequestMapping("/users/reviews")
public class ReviewViewController {

    private final ReviewService reviewService;
    private final OrderService orderService;

    @PostMapping
    public String writeReviewForm(@AuthenticationPrincipal LoginUser loginUser,
                               @RequestParam Long orderDetailId,
                               Model model) {
        OrdersDetailResponse orderDetail = orderService.getOrdersDetail(orderDetailId);
        model.addAttribute("orderDetail", orderDetail);

        return "review/writeReviewForm";
    }

//    @GetMapping
//    public String orderProduct() {
//
//        return "review/writeReviewForm";
//    }

}