package com.codepresso.codepresso.repository.product;

import com.codepresso.codepresso.dto.product.ProductDetailResponse;
import com.codepresso.codepresso.dto.product.ProductListResponse;
import com.codepresso.codepresso.entity.order.OrdersDetail;
import com.codepresso.codepresso.entity.product.Product;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findAll();

    List<Product> findByCategoryCategoryCode(String categoryCode);

    @EntityGraph(attributePaths = {
            "nutritionInfo",
            "category",
            "hashtags"
    })
    Product findProductById(@Param("id") Long id);

    List<Product> findByProductNameContaining(@Param("keyword") String keyword);

    @Query("SELECT p FROM Product p LEFT JOIN FETCH p.hashtags h WHERE h.hashtagName = :hashtag")
    List<Product> findByHashtagsContaining(@Param("hashtag") String hashtag);

}