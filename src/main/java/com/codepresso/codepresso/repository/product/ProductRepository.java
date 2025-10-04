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
//    List<Product> findAll();

    @Query("SELECT p FROM Product p LEFT JOIN FETCH p.category c " +
            "ORDER BY c.displayOrder")
    List<Product> findProductByCategory();

    @EntityGraph(attributePaths = {
            "nutritionInfo",
            "category",
            "hashtags"
    })
    Product findProductById(@Param("id") Long id);

    List<Product> findByProductNameContaining(@Param("keyword") String keyword);

    @Query("SELECT p FROM Product p LEFT JOIN FETCH p.hashtags h WHERE h.hashtagName = :hashtag")
    List<Product> findByHashtagsContaining(@Param("hashtag") String hashtag);

    @Query("SELECT p1 " +
            "FROM Product p1 " +
            "WHERE p1.id " +
            "IN(select distinct(p2.id)" +
            "FROM Product p2 join p2.hashtags h " +
            "WHERE h.hashtagName IN :hashtags " +
            "GROUP BY p2.id " +
            "HAVING COUNT(DISTINCT h.hashtagName) = :size)")
    List<Product> findByHashtagsIn(@Param("hashtags") List<String> hashtags,
                                   @Param("size") long size);

}