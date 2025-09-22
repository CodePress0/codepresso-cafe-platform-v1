package com.codepresso.codepresso.dto.product;
import com.codepresso.codepresso.entity.product.*;
import lombok.Builder;
import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Builder
public class ProductDetailResponse {
    private Long productId;
    private String productName;
    private String productPhoto;
    private Integer price;
    private String productContent;
    private String categoryName;
    private List<Hashtag> hashtags;
    private NutritionInfoDTO nutritionInfo;
    private List<Allergen> allergens;
    private List<ProductOptionDTO> productOptions;

    public static ProductDetailResponse of(Product product, List<ProductOption> options) {

        List<ProductOptionDTO> productOptionDTOs = new ArrayList<>();
        for(ProductOption option : options) {
            productOptionDTOs.add(new ProductOptionDTO(option));
        }

        return ProductDetailResponse.builder()
                .productId(product.getId())
                .productName(product.getProductName())
                .productPhoto(product.getProductPhoto())
                .price(product.getPrice())
                .productContent(product.getProductContent())
                .categoryName(product.getCategory() != null ? product.getCategory().getCategoryCode() : "COFFEE")
                .hashtags(product.getProductHashtags())
                .nutritionInfo(new NutritionInfoDTO(product.getNutritionInfo()))
                .allergens(product.getAllergens())
                .productOptions(productOptionDTOs)
                .build();
    }
}