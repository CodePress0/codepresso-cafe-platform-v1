package com.codepresso.codepresso.controller.product;

import com.codepresso.codepresso.dto.product.ProductDetailResponse;
import com.codepresso.codepresso.dto.product.ProductListResponse;
import com.codepresso.codepresso.dto.review.ReviewListResponse;
import com.codepresso.codepresso.entity.product.Review;
import com.codepresso.codepresso.service.product.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/products")
public class ProductViewController {

    private final ProductService productService;

    /**
     * 상품 목록 페이지
     */
    @GetMapping
    public String productList(@RequestParam(required = false, defaultValue = "COFFEE") String category, Model model) {
        try {
            List<ProductListResponse> products = productService.findProductsByCategory(category);
            model.addAttribute("products", products);
            model.addAttribute("currentCategory", category);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "상품 목록을 불러오는 중 오류가 발생했습니다: " + e.getMessage());
        }
        return "product/productList";
    }

    /**
     * 상품 상세 페이지
     */
    @GetMapping("/{productId}")
    public String productDetail(@PathVariable Long productId, Model model) {
        try {
            ProductDetailResponse product = productService.findByProductId(productId);
            model.addAttribute("product", product);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "상품 정보를 불러오는 중 오류가 발생했습니다: " + e.getMessage());
        }
        return "product/productDetail";
    }

    /**
     * 상품별 리뷰 조회
     */
    @GetMapping("/{productId}/reviews")
    public String productReviews(@PathVariable Long productId, Model model) {
        try {
            ProductDetailResponse product = productService.findByProductId(productId);
            model.addAttribute("product", product);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "상품 정보를 불러오는 중 오류가 발생했습니다: " + e.getMessage());
        }
        return "product/productReviews";
    }
}