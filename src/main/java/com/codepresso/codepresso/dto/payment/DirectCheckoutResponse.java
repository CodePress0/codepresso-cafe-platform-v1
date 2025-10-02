package com.codepresso.codepresso.dto.payment;

import com.codepresso.codepresso.dto.product.ProductDetailResponse;
import com.codepresso.codepresso.dto.product.ProductOptionDTO;
import lombok.Builder;
import lombok.Data;

import java.util.List;

/**
 * 직접 결제 준비 응답 DTO
 */
@Data
@Builder
public class DirectCheckoutResponse {
    private ProductDetailResponse productDetail;
    private List<ProductOptionDTO> selectedOptions;
    private Integer totalAmount;
    private Integer quantity;
    private Boolean isFromCart;
}
