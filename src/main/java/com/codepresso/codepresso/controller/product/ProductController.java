package com.codepresso.codepresso.controller.product;

import com.codepresso.codepresso.dto.product.ProductDetailResponse;
import com.codepresso.codepresso.dto.product.ProductListResponse;
import com.codepresso.codepresso.dto.product.ReviewListResponse;
import com.codepresso.codepresso.service.product.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/products")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;

    // 1. 상품 전체 조회
    @GetMapping
    public ResponseEntity<List<ProductListResponse>> getProducts(
            @RequestParam(required = false, defaultValue = "COFFEE") String category) {
        // 카테고리별 상품 조회
        List<ProductListResponse> products = productService.findProductsByCategory(category);
        return ResponseEntity.ok(products);
    }

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

}