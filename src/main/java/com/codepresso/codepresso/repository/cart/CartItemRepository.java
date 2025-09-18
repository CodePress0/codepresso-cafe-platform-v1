package com.codepresso.codepresso.repository.cart;

import com.codepresso.codepresso.entity.cart.CartItem;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CartItemRepository extends JpaRepository<CartItem, Long> {

    //특정 장바구니의 모든 아이템 조회
    List<CartItem> findByCartId (Long cartId);

    //특정 장바구니 안에서 특정 상품 담겼는지 조회
    Optional<CartItem> findByCartIdAndProductId (Long cartId, Long productId);

    //단일 아이템 조회
    Optional<CartItem> findById(Long cartItemId);
}
