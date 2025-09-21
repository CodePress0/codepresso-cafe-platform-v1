package com.codepresso.codepresso.repository.Product;

import com.codepresso.codepresso.entity.product.Product;
import com.codepresso.codepresso.repository.Product.ProductRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.ActiveProfiles;

import java.util.List;
import java.util.Optional;

@DataJpaTest
@ActiveProfiles("test")
class ProductRepositoryTest {

    @Autowired
    private ProductRepository productRepository;

    @Test
    void runTest() {
        // given

        // when
        List<Product> products = productRepository.findAll();
        Optional<Product> product = productRepository.findById(Long.valueOf(1));
        List<Product> product2 = productRepository.findByCategoryCategoryCode("COFFEE");

        // then
    }

    @Test
    void saveTest() {
        // given
        Product product = Product.builder()
                .productName("a")
                .productContent("good product")
                .productPhoto("~")
                .build();

        // when
        Product p = productRepository.save(product);

        // then
        System.out.println(p.getProductName());
        System.out.println(p.getProductName());

    }
}