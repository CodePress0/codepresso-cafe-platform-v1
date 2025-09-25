package com.codepresso.codepresso.dto.payment;

import com.codepresso.codepresso.dto.cart.CartResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CartCheckoutResponse {

    private CartResponse cartData;

    private Integer totalAmount;

    private Integer totalQuantity;

    private Boolean isFromCart;

}
