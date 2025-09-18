package com.codepresso.codepresso.dto.cart;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Objects;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CartItemResponse {
    private Long cartItemId;
    private Long productId;
    private Integer quantity;
    private String productName;
    private Integer unitPrice;
    private List<CartItemOptionResponse> options;

    public Integer getTotalPrice() {
        if (unitPrice == null || quantity == null) {
            return null;
        }
        return (unitPrice + getOptionExtraPerUnit()) * quantity;
    }

    public Integer getOptionExtraPerUnit() {
        if (options == null) {
            return 0;
        }
        return options.stream()
                .map(CartItemOptionResponse::getAddPrice)
                .filter(Objects::nonNull)
                .mapToInt(Integer::intValue)
                .sum();
    }
}
