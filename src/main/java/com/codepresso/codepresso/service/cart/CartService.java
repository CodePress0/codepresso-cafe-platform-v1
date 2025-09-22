package com.codepresso.codepresso.service.cart;

import com.codepresso.codepresso.dto.cart.CartOptionResponse;
import com.codepresso.codepresso.dto.cart.CartItemOptionResponse;
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

import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

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
        Member member = optionalMember.orElseThrow();
        cart.setMember(member);
        cartRepository.save(cart);
    }

    // item - c
    public CartItem addItemWithOptions(Long memberId, Long productId, int quantity, List<Long> optionIds) {
        if(quantity <= 0) throw new IllegalArgumentException("수량은 1 이상이어야 합니다.");
    public CartItem createItem(Long cartId, Long productId, int quantity) {
        if (quantity <= 0) {
            throw new IllegalArgumentException("수량은 1 이상이어야 합니다.");
        }

        //회원 장바구니 조회
        Cart cart = cartRepository.findByMemberId(memberId)
                .orElseThrow(() -> new IllegalArgumentException("장바구니가 없습니다. memberId : " + memberId));
        Cart cart = cartRepository.findById(cartId)
                .orElseThrow(() -> new IllegalArgumentException("장바구니를 찾을 수 없습니다. cartId=" + cartId));

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
                .orElseThrow(() -> new IllegalArgumentException("상품을 찾을 수 없습니다. productId=" + productId));

        //옵션이 해당 상품에 속하는지 확인
        for (ProductOption op : options) {
            if (!op.getProduct().getId().equals(productId)) {
                throw new IllegalArgumentException("다른 상품의 옵션이 포함되어 있습니다. optionId : " + op.getId());
            }
        }
        int unitPrice = Optional.ofNullable(product.getPrice())
                .orElseThrow(() -> new IllegalStateException("상품 가격이 설정되어 있지 않습니다. productId=" + productId));

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
                .price(calculateTotalPrice(unitPrice, Collections.emptyList(), quantity))
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
        return cartItemRepository.save(cartItem);
    }

    // r - 특정 장바구니 안의 모든 아이템 조회 (DTO 변환 포함)
    @Transactional(readOnly = true)
    public CartResponse getCart(Long cartId){
        List<CartItem> cartItems = cartItemRepository.findByCartId(cartId);

        List<Long> cartItemIds = cartItems.stream()
                .map(CartItem::getId)
                .collect(Collectors.toList());
    public CartResponse getCartByMemberId(Long memberId) {

        List<CartItemResponse> itemResponses;
        if (cartItemIds.isEmpty()) {
            itemResponses = Collections.emptyList();
        } else {
            List<CartOption> options = cartOptionRepository.findByCartItemIdIn(cartItemIds);
            Map<Long, List<CartOption>> optionMap = options.stream()
                    .collect(Collectors.groupingBy(option -> option.getCartItem().getId()));
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
            itemResponses = cartItems.stream()
                    .map(item -> toCartItemResponse(item, optionMap.getOrDefault(item.getId(), Collections.emptyList())))
                    .collect(Collectors.toList());
        }

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
        return CartResponse.of(cartId, itemResponses);
    }

    // r - cartItem 단건 조회
    @Transactional(readOnly = true)
    public Optional<CartItem> getItemById(Long itemId){
        return cartItemRepository.findById(itemId);
    }

    @Transactional(readOnly = true)
    public CartItemResponse getCartItem(Long cartItemId) {
        CartItem cartItem = cartItemRepository.findById(cartItemId)
                .orElseThrow(() -> new IllegalArgumentException("장바구니 아이템을 찾을 수 없습니다. cartItemId=" + cartItemId));
        return toCartItemResponse(cartItem);
    }

    // r - 중복 확인용 조회
    @Transactional(readOnly = true)
    public Optional<CartOption> findByCartItemAndProductOption(Long cartItemId, Long productOptionId){
        return cartOptionRepository.findByCartItem_IdAndProductOption_Id(cartItemId, productOptionId);
    }

    // u - 수량 newQuantity로 덮어쓰기
    public void changeItemQuantity(Long cartItemId, Long memberId, int newQuantity){
        if(newQuantity <= 0) {
    public void updateQuantity(Long cartItemId, int newQuantity){
        if(newQuantity <= 0){
            throw new IllegalArgumentException("수량은 1 이상이어야 합니다.");
        }
        CartItem item = cartItemRepository.findById(cartItemId)
                .orElseThrow(() -> new IllegalArgumentException(
                        "장바구니에 아이템이 없습니다. cartItemId = " + cartItemId ));
        CartItem cartItem = cartItemRepository.findById(cartItemId)
                .orElseThrow(() -> new IllegalArgumentException("장바구니 아이템을 찾을 수 없습니다. cartItemId=" + cartItemId));

        cartItem.setQuantity(newQuantity);
        List<CartOption> options = cartOptionRepository.findByCartItemId(cartItemId);
        int unitPrice = Optional.ofNullable(cartItem.getProduct().getPrice())
                .orElseThrow(() -> new IllegalStateException("상품 가격이 설정되어 있지 않습니다. productId=" + cartItem.getProduct().getId()));
        cartItem.setPrice(calculateTotalPrice(unitPrice, options, newQuantity));

        cartItemRepository.save(cartItem);
    }

    // u - cartId + productId가 이미 있으면 수량만 증가
    public void increaseQuantity(Long cartItemId,  int quantity) {
        if (quantity <= 0) {
            throw new IllegalArgumentException("추가할 수량은 1 이상이어야 합니다.");
        }
        CartItem cartItem = cartItemRepository.findById(cartItemId)
                .orElseThrow(() -> new IllegalArgumentException("장바구니 아이템을 찾을 수 없습니다. cartItemId=" + cartItemId));
        int updated = cartItem.getQuantity() + quantity;
        if(updated <= 0) {
            throw new IllegalArgumentException("최종 수량은 1 이상이어야 합니다.");
        }
        cartItem.setQuantity(updated);
        List<CartOption> options = cartOptionRepository.findByCartItemId(cartItemId);
        int unitPrice = Optional.ofNullable(cartItem.getProduct().getPrice())
                .orElseThrow(() -> new IllegalStateException("상품 가격이 설정되어 있지 않습니다. productId=" + cartItem.getProduct().getId()));
        cartItem.setPrice(calculateTotalPrice(unitPrice, options, updated));
        cartItemRepository.save(cartItem);
    }

    // u - 옵션 변경
    public void updateOptions(Long cartItemId, List<Long> newOptionIds) {
        if (newOptionIds == null) {
            throw new IllegalArgumentException("옵션 ID 목록은 null 일 수 없습니다.");
        }

        CartItem cartItem = cartItemRepository.findById(cartItemId)
                .orElseThrow(() -> new IllegalArgumentException("장바구니 아이템을 찾을 수 없습니다. cartItemId=" + cartItemId));

        //회원 검증
        if(!item.getCart().getMember().getId().equals(memberId)) {
            throw new IllegalArgumentException("본인 장바구니 아이템만 수정할 수 있습니다.");
        Long productId = cartItem.getProduct().getId();
        LinkedHashSet<Long> targetOptionIds = new LinkedHashSet<>(newOptionIds);
        if (targetOptionIds.size() != newOptionIds.size()) {
            throw new IllegalArgumentException("옵션 ID는 중복될 수 없습니다.");
        }
        int optionExtraSum = (item.getOptions() == null ? 0 : item.getOptions().stream()
                .mapToInt(cartOption -> cartOption.getProductOption().getOptionStyle().getExtraPrice())
                .sum());

        int unitPrice = item.getProduct().getPrice() + optionExtraSum;
        int totalPrice = unitPrice * newQuantity;
        List<ProductOption> requestedOptions = productOptionRepository.findAllById(targetOptionIds);
        if (requestedOptions.size() != targetOptionIds.size()) {
            throw new IllegalArgumentException("존재하지 않는 옵션 ID가 포함되어 있습니다.");
        }

        item.setQuantity(newQuantity);
        item.setPrice(totalPrice);
        boolean hasMismatchedProduct = requestedOptions.stream()
                .anyMatch(option -> option.getProduct() == null || !option.getProduct().getId().equals(productId));
        if (hasMismatchedProduct) {
            throw new IllegalArgumentException("해당 상품의 옵션만 선택할 수 있습니다. productId=" + productId);
        }

        List<CartOption> currentOptions = cartOptionRepository.findByCartItemId(cartItemId);
        Set<Long> currentOptionIds = currentOptions.stream()
                .map(CartOption::getProductOption)
                .filter(option -> option != null)
                .map(ProductOption::getId)
                .collect(Collectors.toSet());

        List<CartOption> optionsToRemove = currentOptions.stream()
                .filter(option -> option.getProductOption() == null || !targetOptionIds.contains(option.getProductOption().getId()))
                .collect(Collectors.toList());
        cartOptionRepository.deleteAll(optionsToRemove);
        currentOptionIds.removeAll(optionsToRemove.stream()
                .map(CartOption::getProductOption)
                .filter(option -> option != null)
                .map(ProductOption::getId)
                .collect(Collectors.toSet()));

        for (ProductOption option : requestedOptions) {
            if (!currentOptionIds.contains(option.getId())) {
                CartOption newOption = new CartOption();
                newOption.setCartItem(cartItem);
                newOption.setProductOption(option);
                cartOptionRepository.save(newOption);
                currentOptionIds.add(option.getId());
            }
        }

        List<CartOption> updatedOptions = cartOptionRepository.findByCartItemId(cartItemId);
        int unitPrice = Optional.ofNullable(cartItem.getProduct().getPrice())
                .orElseThrow(() -> new IllegalStateException("상품 가격이 설정되어 있지 않습니다. productId=" + productId));
        cartItem.setPrice(calculateTotalPrice(unitPrice, updatedOptions, cartItem.getQuantity()));
        cartItemRepository.save(cartItem);
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
    public void deleteItem(Long cartItemId) {
        CartItem cartItem = cartItemRepository.findById(cartItemId)
                .orElseThrow(() -> new IllegalArgumentException("장바구니 아이템을 찾을 수 없습니다. cartItemId :" + cartItemId));
        cartOptionRepository.deleteByCartItemId(cartItemId);
        cartItemRepository.deleteById(cartItemId);
    }

    // 전체 삭제
    public void clearCart(Long memberId, Long cartId) {
        //cartId가 본인 소유인지 검증
        Cart cart = cartRepository.findById(cartId)
                .orElseThrow(() -> new IllegalArgumentException("장바구니가 없습니다. cartId = " + cartId));
    public void deleteOption(Long cartItemId) {
        if (!cartItemRepository.existsById(cartItemId)) {
            throw new IllegalArgumentException("장바구니 아이템을 찾을 수 없습니다. cartItemId=" + cartItemId);
        }
        cartOptionRepository.deleteByCartItemId(cartItemId);
    }

        if(!cart.getMember().getId().equals(memberId)){
            throw new IllegalArgumentException("본인 장바구니만 비울 수 있습니다.");
        }
    // DTO 변환 헬퍼
    private CartItemResponse toCartItemResponse(CartItem cartItem) {
        List<CartOption> options = cartOptionRepository.findByCartItemId(cartItem.getId());
        return toCartItemResponse(cartItem, options);
    }

        //아이템들 조회
        List<CartItem> items = cartItemRepository.findByCartId(cartId);
    private CartItemResponse toCartItemResponse(CartItem cartItem, List<CartOption> options) {
        Product product = cartItem.getProduct();

        List<CartItemOptionResponse> optionResponses = options.stream()
                .map(this::toCartItemOptionResponse)
                .collect(Collectors.toList());

        Integer unitPrice = product != null ? product.getPrice() : null;

        return CartItemResponse.builder()
                .cartItemId(cartItem.getId())
                .productId(product != null ? product.getId() : null)
                .productName(product != null ? product.getProductName() : null)
                .quantity(cartItem.getQuantity())
                .unitPrice(unitPrice)
                .options(optionResponses)
                .build();
    }

        //옵션 전부 선삭제
        for(CartItem ci : items) {
            cartOptionRepository.deleteByCartItemId(ci.getId());
    private CartItemOptionResponse toCartItemOptionResponse(CartOption cartOption) {
        ProductOption productOption = cartOption.getProductOption();
        if (productOption == null) {
            return new CartItemOptionResponse(null, null, 0);
        }
        return new CartItemOptionResponse(
                productOption.getId(),
                productOption.getOptionName(),
                productOption.getExtraPrice()
        );
    }

        //아이템 전부 삭제
        cartItemRepository.deleteAll(items);
    // 총 금액 계산
    //옵션이 null 이면 추가금은 0 아니면 스트림으로 계산
    private int calculateTotalPrice(int unitPrice, List<CartOption> options, int quantity) {
        int optionExtra = options == null ? 0 : options.stream()
                .map(CartOption::getProductOption)
                .filter(option -> option != null)
                .mapToInt(ProductOption::getExtraPrice)
                .sum();
        try {
            return Math.multiplyExact(unitPrice + optionExtra, quantity);
        } catch (ArithmeticException ex) {
            throw new IllegalStateException("장바구니 금액 계산 중 오버플로우가 발생했습니다.", ex);
        }
    }
}
