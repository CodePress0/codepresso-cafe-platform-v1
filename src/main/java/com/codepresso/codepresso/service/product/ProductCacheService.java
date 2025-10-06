package com.codepresso.codepresso.service.product;

import com.codepresso.codepresso.dto.product.ProductListResponse;
import com.codepresso.codepresso.repository.product.CategoryRepository;
import com.codepresso.codepresso.repository.product.ProductRepository;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductCacheService {

    private final ProductRepository productRepo;
    private final CategoryRepository categoryRepo;

    // HashMap - 카테고리별 빠른 조회 O(1)
    private final Map<String, List<ProductListResponse>> categoryCache = new ConcurrentHashMap();

    // TreeMap - 카테고리 정렬 순서 유지 O(log n)
    private final TreeMap<String, Integer> categoryOrderMap = new TreeMap();

    @PostConstruct
    public void initCache() {
        log.info("상품 캐시 초기화 시작");
        long startTime = System.currentTimeMillis();

        // DB에서 전체 상품 조회
        List<ProductListResponse> allProducts = productRepo.findAllProductsAsDto();

        // 1. HashMap : 카테고리별 그룹화
        Map<String, List<ProductListResponse>> grouped = allProducts.stream()
                .collect(Collectors.groupingBy(ProductListResponse::getCategoryCode));

        categoryCache.putAll(grouped);

        // 2. TreeMap : 카테고리 순서(displayOrder 기준)
        categoryCache.keySet().forEach(categoryCode -> {
            int displayOrder = getCategoryDisplayOrder(categoryCode);
            categoryOrderMap.put(categoryCode, displayOrder);
        });

        long endTime = System.currentTimeMillis();
        log.info("상품 캐시 초기화 완료 : {}ms, 상품 {}개, 카테고리 {}개",
                endTime - startTime, allProducts.size(), categoryCache.size());
    }

    /**
     * O(1) 카테고리별 상품 조회
     */
    public List<ProductListResponse> getProductsByCategoryCode(String categoryCode) {
        return categoryCache.getOrDefault(categoryCode, Collections.emptyList());
    }

    /**
     * O(1) 전체 상품 조회
     */
    public List<ProductListResponse> getAllProducts() {
        return categoryCache.values().stream()
                .flatMap(List::stream) // 2차원 구조 -> 1차원 구조로 합쳐짐
                .collect(Collectors.toList());
    }

    /**
     * O(log n) 정렬된 카테고리 목록
     */
    public List<String> getSortedCategories() {
        return new ArrayList<>(categoryOrderMap.keySet());
    }

    /**
     * 캐시 갱신 (상품 추가/수정/삭제 시)
     */
    public void refreshCache() {
        log.info("캐시 갱신 중...");
        categoryCache.clear();
        categoryOrderMap.clear();
        initCache();
    }

    private int getCategoryDisplayOrder(String categoryCode) {
        return categoryRepo.findByCategoryCode(categoryCode);
    }
}
