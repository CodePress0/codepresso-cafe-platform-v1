package com.codepresso.codepresso.repository.cart;

import com.codepresso.codepresso.entity.cart.CartOption;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CartOptionRepository extends JpaRepository<CartOption, Long> {

    //특정 CartItem에 속한 옵션 조회
    List<CartOption> findByCartItemId(Long cartItemId);

    //장바구니 아이템 여러 건의 옵션을 한 번에 조회
    List<CartOption> findByCartItemIdIn(List<Long> cartItemIds);

    //이 장바구니 아이템에 대한 상품 옵션이 이미 있는지 중복확인 (있으면 수량에 +1, 없으면 새로 추가)
    Optional<CartOption> findByCartItem_IdAndProductOption_Id(Long cartItemId, Long productOptionId);

    //삭제
    void deleteByCartItemId(Long cartItemId);
}
