package com.codepresso.codepresso.dto.product;

import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.URL;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewUpdateRequest {

    @DecimalMin(value = "1.0", message = "별점은 1.0 이상이어야 합니다.")
    @DecimalMax(value = "5.0", message = "별점은 5.0 이하여야 합니다.")
    private BigDecimal rating;

    @Size(max = 500, message = "내용은 최대 500자까지만 가능합니다.")
    private String content;

    @URL
    private String photoUrl;
}