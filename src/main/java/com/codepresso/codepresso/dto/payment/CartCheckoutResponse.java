package com.codepresso.codepresso.dto.payment;

import com.codepresso.codepresso.dto.cart.CartResponse;
import lombok.Builder;
import lombok.Data;

/**
 * 장바구니 결제 준비 응답 DTO
 */
@Data
@Builder
public class CartCheckoutResponse {
    private CartResponse cartData;
    private Integer totalAmount;
    private Integer totalQuantity;
    private Boolean isFromCart;
}
