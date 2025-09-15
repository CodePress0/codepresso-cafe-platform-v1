package com.codepresso.codepresso.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 즐겨찾기 목록 응답 DTO
 * 즐겨찾기목록 API 응답에 사용
 */
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FavoriteListResponse {

    private List<FavoriteItem> favorites;
    private int totalCount;

    @Getter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class FavoriteItem {
        private Long productId;
        private String productName;
        private String productContent;
        private String productPhoto;
        private Integer price;
        private Integer orderby;
    }
}
