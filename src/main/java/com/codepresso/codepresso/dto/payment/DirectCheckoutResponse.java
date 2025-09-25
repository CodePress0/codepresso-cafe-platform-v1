package com.codepresso.codepresso.dto.payment;

import com.codepresso.codepresso.dto.product.ProductDetailResponse;
import com.codepresso.codepresso.dto.product.ProductOptionDTO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DirectCheckoutResponse {

    private ProductDetailResponse productDetail;

    private Integer quantity;

    /**
     * 선택된 옵션들 (productDetail의 옵션 중에서 사용자가 선택한 것들)
     */
    private List<ProductOptionDTO> selectedOptions;

   private Integer totalAmount;

   private Boolean isFromCart;
}
