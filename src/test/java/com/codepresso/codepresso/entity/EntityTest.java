package com.codepresso.codepresso.entity;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Entity 설계 테스트
 */
@SpringBootTest
@ActiveProfiles("test")
public class EntityTest {

    @Test
    public void testMemberEntity() {
        // Member 엔티티 생성 테스트
        Member member = new Member();
        member.setAccountId("test123");
        member.setPassword("password123");
        member.setName("테스트");
        member.setNickname("닉네임");
        member.setEmail("test@example.com");
        member.setRole("USER");

        assertNotNull(member);
        assertEquals("test123", member.getAccountId());
        assertEquals("테스트", member.getName());
    }

    @Test
    public void testProductEntity() {
        // Product 엔티티 생성 테스트
        Product product = new Product();
        product.setProductName("아메리카노");
        product.setProductContent("맛있는 아메리카노");
        product.setPrice(4500);

        assertNotNull(product);
        assertEquals("아메리카노", product.getProductName());
        assertEquals(4500, product.getPrice());
    }

    @Test
    public void testFavoriteEntity() {
        // Favorite 엔티티 생성 테스트
        FavoriteId favoriteId = new FavoriteId(1L, 1L);
        Favorite favorite = new Favorite();
        favorite.setMemberId(1L);
        favorite.setProductId(1L);
        favorite.setOrderby(1);

        assertNotNull(favorite);
        assertEquals(1L, favorite.getMemberId());
        assertEquals(1L, favorite.getProductId());
        assertEquals(1, favorite.getOrderby());
    }

    @Test
    public void testFavoriteIdCompositeKey() {
        // 복합키 테스트
        FavoriteId favoriteId1 = new FavoriteId(1L, 1L);
        FavoriteId favoriteId2 = new FavoriteId(1L, 1L);
        FavoriteId favoriteId3 = new FavoriteId(1L, 2L);

        // 같은 값이면 equals true
        assertEquals(favoriteId1, favoriteId2);
        // 다른 값이면 equals false
        assertNotEquals(favoriteId1, favoriteId3);
    }
}
