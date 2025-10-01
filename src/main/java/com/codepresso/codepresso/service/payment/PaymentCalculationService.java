package com.codepresso.codepresso.service.payment;

import com.codepresso.codepresso.dto.product.ProductDetailResponse;
import com.codepresso.codepresso.dto.product.ProductOptionDTO;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 결제 관련 가격 계산을 담당하는 서비스 클래스
 */
@Component
class PaymentCalculationService {

    /**
     * 총 가격 계산 및 선택된 옵션 수집
     */
    public int calculateTotalAmount(ProductDetailResponse productDetail, 
                                   List<Long> optionIds,
                                   Integer quantity, 
                                   List<ProductOptionDTO> selectedOptions) {

        int basePrice = (productDetail.getPrice() != null) ? productDetail.getPrice() : 0;
        int optionPrice = 0;

        // 옵션이 선택된 경우
        if (optionIds != null && !optionIds.isEmpty()) {
            // 선택된 옵션들 찾기 및 가격 계산
            for (Long optionId : optionIds) {
                ProductOptionDTO foundOption = productDetail.getProductOptions().stream()
                        .filter(option -> option.getOptionId().equals(optionId))
                        .findFirst()
                        .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 옵션입니다: " + optionId));

                selectedOptions.add(foundOption);
                optionPrice += (foundOption.getExtraPrice() != null) ? foundOption.getExtraPrice() : 0;
            }
        }
        return (basePrice + optionPrice) * quantity;
    }
}