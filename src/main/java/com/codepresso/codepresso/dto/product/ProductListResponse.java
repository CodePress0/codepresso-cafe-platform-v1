package com.codepresso.codepresso.dto.product;

import lombok.*;

@Getter
@Setter
@Builder
public class ProductListResponse {
    private Long productId;

    private String productName;

    private String productPhoto;

    private String productContent;

    private Integer price;

    private String categoryName;

    private String categoryCode;
}