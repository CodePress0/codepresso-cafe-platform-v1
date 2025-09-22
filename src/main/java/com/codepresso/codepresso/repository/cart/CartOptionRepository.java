package com.codepresso.codepresso.repository.cart;

import com.codepresso.codepresso.entity.cart.CartOption;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CartOptionRepository extends JpaRepository<CartOption, Long> {

    //특정 CartItem에 속한 옵션 조회
    List<CartOption> findByCartItemId(Long cartItemId);

    //삭제
    void deleteByCartItemId(Long cartItemId);
}
