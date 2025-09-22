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
public class CartResponse {
    private Long cartId;
    private Long memberId;
    private List<CartItemResponse> items;
    private Integer totalAmount;
    private Integer itemCount;

    public void recalculateSummary() {
        int amount = items == null ? 0 : items.stream()
                .map(CartItemResponse::getTotalPrice)
                .filter(Objects::nonNull)
                .mapToInt(Integer::intValue)
                .sum();
        int count = items == null ? 0 : items.stream()
                .map(CartItemResponse::getQuantity)
                .filter(Objects::nonNull)
                .mapToInt(Integer::intValue)
                .sum();
        this.totalAmount = amount;
        this.itemCount = count;
    }

    public static CartResponse of(Long cartId, List<CartItemResponse> items) {
        CartResponse response = new CartResponse();
        response.setCartId(cartId);
        response.setItems(items);
        response.recalculateSummary();
        return response;
    }
}



