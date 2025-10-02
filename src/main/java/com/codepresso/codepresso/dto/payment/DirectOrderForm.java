package com.codepresso.codepresso.dto.payment;

import lombok.Data;

import java.util.List;

/**
 * 바로구매 진입을 위한 최소 폼 DTO
 */
@Data
public class DirectOrderForm {
    private Long productId;
    private Integer quantity;
    private List<Long> optionIds;
}

