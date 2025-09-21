package com.codepresso.codepresso.dto.product;

import com.codepresso.codepresso.entity.product.Product;
import lombok.*;

@Getter
@Setter
public class ProductListResponse {
    private Long productId;
    private String productName;
    private String productPhoto;
    private String productContent;
    private Integer price;
    private String categoryName;
    private String categoryCode;

    public ProductListResponse(Product product) {
        productId = product.getId();
        productName = product.getProductName();
        productPhoto = product.getProductPhoto();
        productContent = product.getProductContent();
        price = product.getPrice();
        categoryName = product.getCategory().getCategoryName();
        categoryCode = product.getCategory().getCategoryCode();
    }
}