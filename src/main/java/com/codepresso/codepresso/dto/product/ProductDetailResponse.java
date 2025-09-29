package com.codepresso.codepresso.dto.product;
import com.codepresso.codepresso.entity.product.*;
import lombok.Builder;
import lombok.Getter;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Getter
@Builder
public class ProductDetailResponse {
    private Long productId;
    private String productName;
    private String productPhoto;
    private Integer price;
    private String productContent;
    private String categoryName;
    private long favCount;
    private Set<Hashtag> hashtags;
    private NutritionInfo nutritionInfo;
    private Set<Allergen> allergens;
    private List<ProductOptionDTO> productOptions;
    private static final String DEFAULT_CATEGORY = "COFFEE";

    public static ProductDetailResponse of(Product product, long favCount, List<ProductOption> options) {

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
                .categoryName(product.getCategory() != null ? product.getCategory().getCategoryCode() : DEFAULT_CATEGORY)
                .favCount(favCount)
                .hashtags(product.getHashtags())
                .nutritionInfo(product.getNutritionInfo())
                .allergens(product.getAllergens())
                .productOptions(productOptionDTOs)
                .build();
    }
}