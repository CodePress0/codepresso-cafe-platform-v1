package com.codepresso.codepresso.controller;

import com.codepresso.codepresso.dto.cart.CartItemAddRequest;
import com.codepresso.codepresso.dto.cart.CartItemResponse;
import com.codepresso.codepresso.dto.cart.CartItemUpdateRequest;
import com.codepresso.codepresso.dto.cart.CartResponse;
import com.codepresso.codepresso.service.cart.CartService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@Validated
@RequestMapping("/users/cart")
public class CartController {

    private final CartService cartService;

    // 장바구니 조회
    @GetMapping
    public ResponseEntity<CartResponse> getCart(@RequestParam("cartId") Long cartId) {
        return ResponseEntity.ok(cartService.getCart(cartId));
    }

    // 장바구니 상품 추가
    @PostMapping("/{cartId}")
    public ResponseEntity<CartItemResponse> addItem(
            @PathVariable Long cartId,
            @Valid @RequestBody CartItemAddRequest request
    ) {
        var cartItem = cartService.createItem(cartId, request.getProductId(), request.getQuantity());

        if (request.getOptionIds() != null && !request.getOptionIds().isEmpty()) {
            cartService.updateOptions(cartItem.getId(), request.getOptionIds());
        }

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(cartService.getCartItem(cartItem.getId()));
    }

    // 장바구니 상품 수정
    @PutMapping("/{cartItemId}")
    public ResponseEntity<CartItemResponse> updateItem(
            @PathVariable Long cartItemId,
            @Valid @RequestBody CartItemUpdateRequest request
    ) {
        cartService.updateQuantity(cartItemId, request.getQuantity());

        if (request.getOptionIds() != null) {
            cartService.updateOptions(cartItemId, request.getOptionIds());
        }

        return ResponseEntity.ok(cartService.getCartItem(cartItemId));
    }

    // 장바구니 상품 삭제
    @DeleteMapping("/{cartItemId}")
    public ResponseEntity<Void> deleteItem(@PathVariable Long cartItemId) {
        cartService.deleteItem(cartItemId);
        return ResponseEntity.noContent().build();
    }
}
