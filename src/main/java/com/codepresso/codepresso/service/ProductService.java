package com.codepresso.codepresso.service;

import com.codepresso.codepresso.entity.Product;
import com.codepresso.codepresso.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.NoSuchElementException;

/**
 * 상품 관련 비즈니스 로직을 처리하는 서비스 클래스
 */
@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;

    /**
     * 특정 상품의 상세 정보를 조회합니다.
     *
     * @param productId 조회할 상품의 ID
     * @return 상품 엔티티
     * @throws NoSuchElementException 해당 ID의 상품이 없을 경우
     */
    @Transactional(readOnly = true)
    public Product getProductById(Long productId) {
        return productRepository.findById(productId)
                .orElseThrow(() -> new NoSuchElementException("Product not found with id: " + productId));
    }
}
