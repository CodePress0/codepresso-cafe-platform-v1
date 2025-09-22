package com.codepresso.codepresso.repository.product;

import com.codepresso.codepresso.entity.product.AllergenProduct;
import lombok.RequiredArgsConstructor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AllergenProductRepository extends JpaRepository<AllergenProduct, Long> {
    // 알레르기 정보 가져오기
    @Query("SELECT ap " +
            "FROM AllergenProduct ap LEFT JOIN FETCH ap.allergen " +
            "WHERE ap.product.id = :productId")
    List<AllergenProduct> findAllergenByProductId(@Param("productId") Long productId);
}