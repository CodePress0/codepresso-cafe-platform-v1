package com.codepresso.codepresso.repository.product;

import com.codepresso.codepresso.entity.product.AllergenProduct;
import com.codepresso.codepresso.entity.product.Product;
import com.codepresso.codepresso.entity.product.ProductOption;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findAll();
    List<Product> findByCategoryCategoryCode(String categoryCode);

    // 영양 정보 가져오기
    @Query("SELECT p " +
            "FROM Product p LEFT JOIN FETCH p.nutritionInfo " +
            "WHERE p.id = :id")
    Product findWithNutrition(@Param("id") Long id);

}