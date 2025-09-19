package com.codepresso.codepresso.service.cart;

import com.codepresso.codepresso.dto.cart.CartOptionResponse;
import com.codepresso.codepresso.dto.cart.CartItemResponse;
import com.codepresso.codepresso.dto.cart.CartResponse;
import com.codepresso.codepresso.entity.cart.Cart;
import com.codepresso.codepresso.entity.cart.CartItem;
import com.codepresso.codepresso.entity.cart.CartOption;
import com.codepresso.codepresso.entity.member.Member;
import com.codepresso.codepresso.entity.product.Product;
import com.codepresso.codepresso.entity.product.ProductOption;
import com.codepresso.codepresso.repository.product.ProductOptionRepository;
import com.codepresso.codepresso.repository.product.ProductRepository;
import com.codepresso.codepresso.repository.cart.CartItemRepository;
import com.codepresso.codepresso.repository.cart.CartOptionRepository;
import com.codepresso.codepresso.repository.cart.CartRepository;
import com.codepresso.codepresso.repository.member.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class CartService {

    private final CartRepository cartRepository;
    private final CartItemRepository cartItemRepository;
    private final CartOptionRepository cartOptionRepository;
    private final ProductRepository productRepository;
    private final ProductOptionRepository productOptionRepository;
    private final MemberRepository memberRepository;

    // c - 장바구니 생성
    public void create(Long memberId) {
        if (cartRepository.existsByMemberId(memberId)) {
            throw new IllegalStateException("해당 회원의 장바구니가 이미 존재합니다. memberId=" + memberId);
        }
        Cart cart = new Cart();
        Optional<Member> optionalMember = memberRepository.findById(memberId);
        Member member = optionalMember
                .orElseThrow(() -> new IllegalArgumentException("회원이 존재하지 않습니다. memberId = " + memberId));
        cart.setMember(member);
        cartRepository.save(cart);
    }

    // item - c
    public CartItem addItemWithOptions(Long memberId, Long productId, int quantity, List<Long> optionIds) {
        if(quantity <= 0) throw new IllegalArgumentException("수량은 1 이상이어야 합니다.");

        //회원 장바구니 조회
        Cart cart = cartRepository.findByMemberId(memberId)
                .orElseThrow(() -> new IllegalArgumentException("장바구니가 없습니다. memberId : " + memberId));

        //상품 조회
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new IllegalArgumentException("상품이 없습니다. productId : " + productId));

        //옵션 중복 검증
        if(optionIds != null && !optionIds.isEmpty()) {
            long distinctCount = optionIds.stream().distinct().count();
            if(distinctCount != optionIds.size()) {
                throw new IllegalArgumentException("중복 옵션은 허용되지 않습니다.");
            }
        }

        //옵션 조회 (없으면 빈 리스트)
        List<ProductOption> options = (optionIds == null || optionIds.isEmpty())
                ? List.of()
                : productOptionRepository.findAllById(optionIds);

        //옵션 개수 검증(요청한 OptionIds 개수 == 조회된 options 개수)
        if (options.size() != (optionIds == null ? 0 : optionIds.size())) {
            throw new IllegalArgumentException("존재하지 않는 옵션이 포함되어 있습니다. ");
        }

        //옵션이 해당 상품에 속하는지 확인
        for (ProductOption op : options) {
            if (!op.getProduct().getId().equals(productId)) {
                throw new IllegalArgumentException("다른 상품의 옵션이 포함되어 있습니다. optionId : " + op.getId());
            }
        }

        //옵션 추가금 반영 가격 계산
        int optionExtraSum = options.stream()
                .mapToInt(op -> op.getOptionStyle().getExtraPrice())
                .sum();
        int unitPrice = product.getPrice() + optionExtraSum;
        int totalPrice = unitPrice * quantity;

        //장바구니 아이템 생성
        CartItem cartItem = CartItem.builder()
                .cart(cart)
                .product(product)
                .quantity(quantity)
                .price(totalPrice)
                .build();

        //저장
        CartItem savedItem = cartItemRepository.save(cartItem);

        //cartOption 저장
        for (ProductOption op : options) {
            CartOption cartOption = new CartOption();
            cartOption.setCartItem(savedItem);
            cartOption.setProductOption(op);
            cartOptionRepository.save(cartOption);
        }
        return savedItem;
    }

    // r - 특정 장바구니 안의 모든 아이템 조회 (DTO 변환 포함)
    @Transactional(readOnly = true)
    public CartResponse getCartByMemberId(Long memberId) {

        //장바구니 조회
        Cart cart = cartRepository.findByMemberId(memberId)
                .orElseThrow(()->new IllegalArgumentException("장바구니가 없습니다. memberId : " + memberId));

        //cartItem -> DTO 변환
        List<CartItemResponse> itemResponses = cart.getItems().stream()
                .map(item -> {
                    //CartItemOption -> DTO 변환
                    List<CartOptionResponse> optionResponses = item.getOptions().stream()
                            .map(cartOption -> CartOptionResponse.builder()
                                    .optionId(cartOption.getProductOption().getId())
                                    .optionName(cartOption.getProductOption().getOptionStyle().getOptionName().getOptionName())
                                    .extraPrice(cartOption.getProductOption().getOptionStyle().getExtraPrice())
                                    .build())
                            .toList();

                    return CartItemResponse.builder()
                            .cartItemId(item.getId())
                            .productId(item.getProduct().getId())
                            .productName(item.getProduct().getProductName())
                            .quantity(item.getQuantity())
                            .price(item.getPrice())
                            .options(optionResponses)
                            .build();
                })
                .toList();

        return CartResponse.builder()
                .cartId(cart.getId())
                .memberId(cart.getMember().getId())
                .items(itemResponses)
                .build();
    }

    // u - 수량 newQuantity로 덮어쓰기
    public void changeItemQuantity(Long memberId, Long cartItemId, int newQuantity){
        if(newQuantity <= 0) {
            throw new IllegalArgumentException("수량은 1 이상이어야 합니다.");
        }
        CartItem item = cartItemRepository.findById(cartItemId)
                .orElseThrow(() -> new IllegalArgumentException(
                        "장바구니에 아이템이 없습니다. cartItemId = " + cartItemId ));

        //회원 검증
        if(!item.getCart().getMember().getId().equals(memberId)) {
            throw new IllegalArgumentException("본인 장바구니 아이템만 수정할 수 있습니다.");
        }
        int optionExtraSum = (item.getOptions() == null ? 0 : item.getOptions().stream()
                .mapToInt(cartOption -> cartOption.getProductOption().getOptionStyle().getExtraPrice())
                .sum());

        int unitPrice = item.getProduct().getPrice() + optionExtraSum;
        int totalPrice = unitPrice * newQuantity;

        item.setQuantity(newQuantity);
        item.setPrice(totalPrice);
    }

    // d - cartItem 삭제
    public void deleteItem(Long memberId, Long cartItemId) {
        CartItem item = cartItemRepository.findById(cartItemId)
                .orElseThrow(() -> new IllegalArgumentException("장바구니 아이템이 없습니다. cartItemId :" + cartItemId));

        //소유권 검증
        if(!item.getCart().getMember().getId().equals(memberId)){
            throw new IllegalArgumentException("본인 장바구니 아이템만 삭제할 수 있습니다.");
        }

        //옵션 먼저 삭제
        cartOptionRepository.deleteByCartItemId(item.getId());

        //아이템 삭제
        cartItemRepository.deleteById(item.getId());
    }

    // 전체 삭제
    public void clearCart(Long memberId, Long cartId) {
        //cartId가 본인 소유인지 검증
        Cart cart = cartRepository.findById(cartId)
                .orElseThrow(() -> new IllegalArgumentException("장바구니가 없습니다. cartId = " + cartId));

        if(!cart.getMember().getId().equals(memberId)){
            throw new IllegalArgumentException("본인 장바구니만 비울 수 있습니다.");
        }

        //아이템들 조회
        List<CartItem> items = cartItemRepository.findByCartId(cartId);

        //옵션 전부 선삭제
        for(CartItem ci : items) {
            cartOptionRepository.deleteByCartItemId(ci.getId());
        }

        //아이템 전부 삭제
        cartItemRepository.deleteAll(items);
    }
}
