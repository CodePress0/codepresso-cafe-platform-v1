package com.codepresso.codepresso.repository;

import com.codepresso.codepresso.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Product 엔티티에 대한 데이터 접근 계층
 */
@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
}
