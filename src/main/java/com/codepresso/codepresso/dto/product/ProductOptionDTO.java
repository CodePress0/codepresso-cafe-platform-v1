package com.codepresso.codepresso.dto.product;

import com.codepresso.codepresso.entity.product.OptionStyle;
import com.codepresso.codepresso.entity.product.ProductOption;
import lombok.Getter;

@Getter
public class ProductOptionDTO {
    private Long optionStyleId;
    private String optionName;
    private String optionStyleName;
    private Integer extraPrice;

    public ProductOptionDTO(OptionStyle optionStyle) {
        optionStyleId = optionStyle.getId();
        optionName = optionStyle.getOptionName().getOptionName();
        optionStyleName = optionStyle.getOptionStyle();
        extraPrice = optionStyle.getExtraPrice();
    }

    public ProductOptionDTO(ProductOption productOption) {
        this(productOption.getOptionStyle());
    }
}
