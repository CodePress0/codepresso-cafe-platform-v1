package com.codepresso.codepresso.dto.cart;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartItemOptionResponse {
    private Long optionId;
    private String optionName;
    private Integer addPrice;
}