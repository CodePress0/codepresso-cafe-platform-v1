package com.codepresso.codepresso.repository.product;

import com.codepresso.codepresso.entity.product.ProductOption;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.LinkedHashSet;
import java.util.List;

@Repository
public interface ProductOptionRepository extends JpaRepository<ProductOption, Long> {
}