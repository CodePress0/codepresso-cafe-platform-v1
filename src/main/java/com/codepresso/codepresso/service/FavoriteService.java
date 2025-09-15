package com.codepresso.codepresso.service;

import com.codepresso.codepresso.dto.AuthResponse;
import com.codepresso.codepresso.dto.FavoriteItemDto;
import com.codepresso.codepresso.dto.FavoriteListResponse;
import com.codepresso.codepresso.entity.Favorite;
import com.codepresso.codepresso.entity.FavoriteId;
import com.codepresso.codepresso.entity.Member;
import com.codepresso.codepresso.entity.Product;
import com.codepresso.codepresso.repository.FavoriteRepository;
import com.codepresso.codepresso.repository.MemberRepository;
import com.codepresso.codepresso.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

/**
 * 즐겨찾기 관련 비즈니스 로직을 처리하는 서비스 클래스
 */
@Service
@RequiredArgsConstructor
public class FavoriteService {

    private final FavoriteRepository favoriteRepository;
    private final MemberRepository memberRepository;
    private final ProductRepository productRepository;

    /**
     * 즐겨찾기에 상품을 추가합니다.
     *
     * @param memberId 즐겨찾기를 추가할 회원의 ID
     * @param productId 즐겨찾기에 추가할 상품의 ID
     * @return 성공 응답 DTO
     * @throws IllegalArgumentException 이미 즐겨찾기에 추가된 상품일 경우
     * @throws NoSuchElementException 회원 또는 상품이 존재하지 않을 경우
     */
    @Transactional
    public AuthResponse addFavorite(Long memberId, Long productId) {
        // 회원 및 상품 존재 여부 확인
        Member member = memberRepository.findById(memberId)
                .orElseThrow(() -> new NoSuchElementException("Member not found with id: " + memberId));
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new NoSuchElementException("Product not found with id: " + productId));

        // 이미 즐겨찾기에 있는지 확인
        if (favoriteRepository.findByMemberIdAndProductId(memberId, productId).isPresent()) {
            throw new IllegalArgumentException("Product is already in favorites for member: " + memberId);
        }

        // orderby 값 설정 (가장 마지막 순서로 추가)
        long maxOrderby = favoriteRepository.countByMemberId(memberId);
        int newOrderby = (int) maxOrderby + 1;

        Favorite favorite = Favorite.builder()
                .memberId(memberId)
                .productId(productId)
                .orderby(newOrderby)
                .member(member)
                .product(product)
                .build();

        favoriteRepository.save(favorite);

        return AuthResponse.builder()
                .success(true)
                .message("즐겨찾기에 성공적으로 추가되었습니다.")
                .build();
    }

    /**
     * 특정 회원의 즐겨찾기 목록을 조회합니다.
     *
     * @param memberId 즐겨찾기 목록을 조회할 회원의 ID
     * @return 즐겨찾기 목록 DTO
     * @throws NoSuchElementException 해당 ID의 회원이 없을 경우
     */
    @Transactional(readOnly = true)
    public FavoriteListResponse getFavoriteList(Long memberId) {
        // 회원 존재 여부 확인
        memberRepository.findById(memberId)
                .orElseThrow(() -> new NoSuchElementException("Member not found with id: " + memberId));

        List<Favorite> favorites = favoriteRepository.findByMemberIdOrderByOrderbyAsc(memberId);

        List<FavoriteItemDto> favoriteItemDtos = favorites.stream()
                .map(favorite -> {
                    Product product = favorite.getProduct();
                    return FavoriteItemDto.builder()
                            .productId(product.getId())
                            .productName(product.getProductName())
                            .productPhoto(product.getProductPhoto())
                            .price(product.getPrice())
                            .orderby(favorite.getOrderby())
                            .build();
                })
                .collect(Collectors.toList());

        return FavoriteListResponse.builder()
                .favorites(favoriteItemDtos)
                .totalCount(favoriteItemDtos.size())
                .build();
    }

    /**
     * 즐겨찾기에서 상품을 삭제합니다.
     *
     * @param memberId 즐겨찾기에서 삭제할 회원의 ID
     * @param productId 즐겨찾기에서 삭제할 상품의 ID
     * @return 성공 응답 DTO
     * @throws NoSuchElementException 해당 즐겨찾기가 존재하지 않을 경우
     */
    @Transactional
    public AuthResponse removeFavorite(Long memberId, Long productId) {
        FavoriteId favoriteId = new FavoriteId(memberId, productId);
        Favorite favorite = favoriteRepository.findById(favoriteId)
                .orElseThrow(() -> new NoSuchElementException("Favorite not found for member " + memberId + " and product " + productId));

        favoriteRepository.delete(favorite);

        return AuthResponse.builder()
                .success(true)
                .message("즐겨찾기에서 성공적으로 삭제되었습니다.")
                .build();
    }
}
