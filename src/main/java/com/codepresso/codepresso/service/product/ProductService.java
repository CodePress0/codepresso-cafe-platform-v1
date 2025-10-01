package com.codepresso.codepresso.service.product;

import com.codepresso.codepresso.converter.product.ProductConverter;
import com.codepresso.codepresso.converter.review.ReviewConverter;
import com.codepresso.codepresso.dto.product.ProductDetailResponse;
import com.codepresso.codepresso.dto.product.ProductListResponse;
import com.codepresso.codepresso.dto.review.ReviewListResponse;
import com.codepresso.codepresso.entity.product.Product;
import com.codepresso.codepresso.entity.product.ProductOption;
import com.codepresso.codepresso.entity.product.Review;
import com.codepresso.codepresso.repository.member.FavoriteRepository;
import com.codepresso.codepresso.repository.product.*;
import com.codepresso.codepresso.repository.review.ReviewRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepo;
    private final ProductOptionRepository productOptRepo;
    private final FavoriteRepository favoriteRepo;
    private final ReviewRepository reviewRepo;

    private final ReviewConverter reviewConverter;
    private final ProductConverter productConverter;

    @Transactional
    public List<ProductListResponse> findProductsByCategory(String categoryCode) {
        List<Product> products = productRepo.findByCategoryCategoryCode(categoryCode);

        return products.stream()
                .map(productConverter::toDto)
                .toList();
    }

    @Transactional
    public List<ReviewListResponse> findProductReviews(Long productId) {
        List<Review> reviews = reviewRepo.findByProductReviews(productId);
        Double avgRating = reviewRepo.getAverageRatingByProduct(productId);

        return reviews.stream()
                .map(review -> reviewConverter.toDto(review, avgRating))
                .toList();
    }

    @Transactional
    public ProductDetailResponse findByProductId(Long productId) {
        Product product = productRepo.findProductById(productId);
        long favCount = favoriteRepo.countByProductId(productId);
        List<ProductOption> options = productOptRepo.findOptionByProductId(productId);

        return productConverter.toDetailDto(product, favCount, options);
    }

    @Transactional
    public List<ProductListResponse> searchProductsByKeyword(String keyword) {
        List<Product> products = productRepo.findByProductNameContaining(keyword);

        return products.stream()
                .map(productConverter::toDto)
                .toList();
    }

    @Transactional
    public List<ProductListResponse> searchProductsByHashtag(String hashtag) {
        List<Product> products = productRepo.findByHashtagsContaining(hashtag);

        return products.stream()
                .map(productConverter::toDto)
                .toList();
    }

}