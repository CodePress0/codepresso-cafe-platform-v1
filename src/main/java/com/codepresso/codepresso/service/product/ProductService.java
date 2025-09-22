package com.codepresso.codepresso.service.product;

import com.codepresso.codepresso.dto.product.ProductDetailResponse;
import com.codepresso.codepresso.dto.product.ProductListResponse;
import com.codepresso.codepresso.dto.product.ReviewListResponse;
import com.codepresso.codepresso.entity.product.AllergenProduct;
import com.codepresso.codepresso.entity.product.Product;
import com.codepresso.codepresso.entity.product.ProductOption;
import com.codepresso.codepresso.entity.product.Review;
import com.codepresso.codepresso.repository.product.*;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepo;
    private final AllergenProductRepository allergenProdRepo;
    private final ProductOptionRepository productOptRepo;
    private final ReviewRepository reviewRepo;

//    public List<ProductResponseDTO> findAllProducts() {
//        List<Product> products = productRepo.findAll();
//
//        List<ProductResponseDTO> productResponseDTOS = new ArrayList<>();
//
//        for(Product product : products) {
//            ProductResponseDTO pr = new ProductResponseDTO(product);
//            productResponseDTOS.add(pr);
//        }
//
//        return productResponseDTOS;
//    }

    public List<ProductListResponse> findProductsByCategory(String categoryCode) {
        List<Product> products = productRepo.findByCategoryCategoryCode(categoryCode);

        List<ProductListResponse> productResponseDTOs = new ArrayList<>();
        for (Product product : products) {
            ProductListResponse pr = new ProductListResponse(product);
            productResponseDTOs.add(pr);
        }

        return productResponseDTOs;
    }

    public ProductDetailResponse findByProductId(Long productId) {
        Product product = productRepo.findWithNutrition(productId);
        List<AllergenProduct> allergenProducts = allergenProdRepo.findAllergenByProductId(productId);
        List<ProductOption> productOptions = productOptRepo.findOptionByProductId(productId);

        return new ProductDetailResponse(product, allergenProducts, productOptions);
    }


    public List<ReviewListResponse> findProductReviews(Long productId) {
        List<Review> reviews = reviewRepo.findByProductReviews(productId);

        List<ReviewListResponse> reviewResponseDTOs = new ArrayList<>();
        for (Review review : reviews) {
            ReviewListResponse pr = new ReviewListResponse(review);
            reviewResponseDTOs.add(pr);
        }
        return reviewResponseDTOs;
    }


}