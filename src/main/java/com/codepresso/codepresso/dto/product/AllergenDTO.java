package com.codepresso.codepresso.dto.product;

import com.codepresso.codepresso.entity.product.Allergen;
import com.codepresso.codepresso.entity.product.AllergenProduct;
import com.codepresso.codepresso.entity.product.Product;
import lombok.Getter;

import java.util.List;

@Getter
public class AllergenDTO {
    private Long allegenId;
    private String allergenName;
    private String allergenCode;

    public AllergenDTO(AllergenProduct allergenProduct){
        allegenId = allergenProduct.getAllergen().getId();
        allergenName = allergenProduct.getAllergen().getAllegenName();
        allergenCode = allergenProduct.getAllergen().getAllegenCode();
    }
}
