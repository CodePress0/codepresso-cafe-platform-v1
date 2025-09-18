package com.codepresso.codepresso.repository.cart;

import com.codepresso.codepresso.entity.cart.Cart;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CartRepository extends JpaRepository<Cart,Long > {

    Optional<Cart> findByMemberId(Long memberId);

    boolean existsByMemberId(Long memberId);
}
