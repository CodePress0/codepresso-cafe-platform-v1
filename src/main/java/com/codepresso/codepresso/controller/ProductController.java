package com.codepresso.codepresso.controller;

import com.codepresso.codepresso.dto.product.ProductDetailResponse;
import com.codepresso.codepresso.dto.product.ProductListResponse;
import com.codepresso.codepresso.dto.product.ReviewListResponse;
import com.codepresso.codepresso.entity.product.Product;
import com.codepresso.codepresso.entity.product.Review;
import com.codepresso.codepresso.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/products")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;

    // 1. 상품 전체 조회
//    @GetMapping
//    public String getProducts(@RequestParam(required = false) String category, Model model) {
//
//        if (category == null || category.isEmpty()) {
//            return "redirect:/products?category=COFFEE";
//        }
//
//        List<ProductListResponse> products;
//
//        // 카테고리별 상품 조회
//        products = productService.findProductsByCategory(category);
//
//        model.addAttribute("products", products);
//        model.addAttribute("currentCategory", category);
//
//        return "product";
//    }

    // 1. 상품 전체 조회
    @GetMapping
    public ResponseEntity<List<ProductListResponse>> getProducts(
            @RequestParam(required = false, defaultValue = "COFFEE") String category) {
        // 카테고리별 상품 조회
        List<ProductListResponse> products = productService.findProductsByCategory(category);

        return ResponseEntity.ok(products);
    }

//    // 2. 상품 상세 조회
//    @GetMapping("/{productId}")
//    public String getProduct(@PathVariable Long productId, Model model) {
//        ProductDetailResponse pdResponse = productService.findByProductId(productId);
//        model.addAttribute("productDetail", pdResponse);
//        return "productDetail";
//    }

    // 팝업용 상품 상세 조회 (AJAX)
//    @GetMapping("/{productId}/detail")
//    @ResponseBody
//    public ProductDetailResponse getProductDetail(@PathVariable Long productId) {
//        return productService.findByProductId(productId);
//    }

    // 2. 상품 상세 조회
    @GetMapping("/{productId}")
    public ResponseEntity<ProductDetailResponse> getProduct(@PathVariable Long productId) {
        ProductDetailResponse product = productService.findByProductId(productId);

        return ResponseEntity.ok(product);
    }

    // 3. 상품 리뷰 목록 조회
    @GetMapping("/{productId}/reviews")
    public ResponseEntity<List<ReviewListResponse>> getProductReviews(@PathVariable Long productId) {
        List<ReviewListResponse> reviews = productService.findProductReviews(productId);

        return ResponseEntity.ok(reviews);
    }

//    // 4. 리뷰 작성
//    @PutMapping("/{productId}/reviews/{reviewId}")
//    public Review editReview(@PathVariable Long productId, Long reviewId, Review review) {
//        return productService.findByReviewId(reviewId);
//    }

    // 5. 리뷰 수정
    // @PutMapping("/{productId}/reviews/{reviewId}")

    // 6. 리뷰 삭제
    // @DeleteMapping("/{productId}/reviews/{reviewId}")
}