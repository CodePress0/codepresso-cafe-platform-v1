package com.codepresso.codepresso.controller.product;

import com.codepresso.codepresso.dto.product.ProductListResponse;
import com.codepresso.codepresso.dto.review.ReviewListResponse;
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

    /**
     * 상품 리뷰 목록 조회
     */
    @GetMapping("/{productId}/reviews")
    public ResponseEntity<List<ReviewListResponse>> getProductReviews(
            @PathVariable Long productId) {
        List<ReviewListResponse> reviews = productService.findProductReviews(productId);
        return ResponseEntity.ok(reviews);
    }

    /**
     * 상품 검색(keyword)
     */
    @PostMapping("/search/keyword")
    public ResponseEntity<List<ProductListResponse>> searchProductsByKeyword(@RequestParam String keyword) {
        List<ProductListResponse> products = productService.searchProductsByKeyword(keyword);
        return ResponseEntity.ok(products);
    }

    @PostMapping("/search/hashtag")
    public ResponseEntity<List<ProductListResponse>> searchProductsByHashtag(@RequestParam String hashtag) {
        List<ProductListResponse> products = productService.searchProductsByHashtag(hashtag);
        return ResponseEntity.ok(products);
    }

}