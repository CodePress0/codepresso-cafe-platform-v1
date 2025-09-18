package com.codepresso.codepresso.repository.product;

import com.codepresso.codepresso.entity.product.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * 상품 데이터 접근 레포지토리
 * JPA를 활용한 상품 데이터 CRUD 작업
 */
@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    
    /**
     * 상품명으로 상품 조회
     * 
     * @param productName 조회할 상품명
     * @return Product 상품 정보 (없으면 null)
     */
    Product findByProductName(String productName);
}
