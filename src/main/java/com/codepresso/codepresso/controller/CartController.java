package com.codepresso.codepresso.controller;

import com.codepresso.codepresso.dto.cart.*;
import com.codepresso.codepresso.entity.cart.CartItem;
import com.codepresso.codepresso.service.cart.CartService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/users/cart")
public class CartController {

    private final CartService cartService;

    //장바구니 생성
    @PostMapping("/create")
    public ResponseEntity<String> createCart(@RequestParam Long memberId) {
        cartService.create(memberId);
        return ResponseEntity.ok("장바구니가 생성되었습니다.");
    }

    //장바구니 조회
    @GetMapping
    public ResponseEntity<CartResponse> getCart(@RequestParam Long memberId) {
        return ResponseEntity.ok(cartService.getCartByMemberId(memberId));
    }

    //장바구니 상품 추가
    @PostMapping
    public ResponseEntity<CartItemResponse> addItem(
            @RequestParam Long memberId,
            @RequestParam Long productId,
            @RequestParam int quantity,
            @RequestParam(required = false) List<Long> optionIds
    ){
        CartItem savedItem = cartService.addItemWithOptions(memberId, productId, quantity, optionIds);

        //cartItem -> DTO 변환
        CartItemResponse response = CartItemResponse.builder()
                .cartItemId(savedItem.getId())
                .productId(savedItem.getProduct().getId())
                .productName(savedItem.getProduct().getProductName())
                .quantity(savedItem.getQuantity())
                .price(savedItem.getPrice())
                .options(savedItem.getOptions().stream().map(opt ->
                        new CartOptionResponse(
                                opt.getProductOption().getId(),
                                opt.getProductOption().getOptionStyle().getOptionName().getOptionName(),
                                opt.getProductOption().getOptionStyle().getExtraPrice()
                        )
                ).toList())
                .build();

        return ResponseEntity.ok(response);
    }

    //장바구니 상품 수정
    @PatchMapping("/{cartItemId}")
    public ResponseEntity<String> updateQuantity(
            @PathVariable Long cartItemId,
            @RequestParam Long memberId,
            @RequestParam int quantity
    ) {
        cartService.changeItemQuantity(cartItemId, memberId, quantity);
        return ResponseEntity.ok("수량이 변경되었습니다.");
    }

    //장바구니 상품 삭제
    @DeleteMapping("/{cartItemId}")
    public ResponseEntity<String> deleteItem(
            @PathVariable Long cartItemId,
            @RequestParam Long memberId
    ){
    cartService.deleteItem(cartItemId, memberId);
    return ResponseEntity.ok("아이템이 삭제되었습니다.");
    }
}
