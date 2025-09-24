package com.codepresso.codepresso.controller.review;

import com.codepresso.codepresso.service.product.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/users/reviews")
public class ReviewViewController {

    private final ReviewService reviewService;


}