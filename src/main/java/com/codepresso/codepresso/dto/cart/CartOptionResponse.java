package com.codepresso.codepresso.dto.cart;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CartOptionResponse {
    private Long optionId;
    private String optionName;
    private Integer extraPrice;
}