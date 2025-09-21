package com.codepresso.codepresso.dto.product;
import com.codepresso.codepresso.entity.product.*;
import lombok.Getter;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Getter
public class ProductDetailResponse {
    private Long productId;
    private String productName;
    private String productPhoto;
    private Integer price;
    private String productContent;
    private NutritionInfoDTO nutritionInfo;
    private List<AllergenDTO> allergens;
    private List<ProductOptionDTO> productOptions;

    public ProductDetailResponse(Product product, List<AllergenProduct> allergens, List<ProductOption> options) {
        productId = product.getId();
        productName = product.getProductName();
        productPhoto = product.getProductPhoto();
        price = product.getPrice();
        productContent = product.getProductContent();
        nutritionInfo = new NutritionInfoDTO(product.getNutritionInfo());

        this.allergens = new ArrayList<>();

        for(AllergenProduct ap : allergens) {
            this.allergens.add(new AllergenDTO(ap));
        }

        this.productOptions = new ArrayList<>();

        for(ProductOption option : options) {
            this.productOptions.add(new ProductOptionDTO(option));
        }
    }
}