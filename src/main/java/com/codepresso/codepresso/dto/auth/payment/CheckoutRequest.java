package com.codepresso.codepresso.dto.auth.payment;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 결제하기 요청 DTO
 * */
@Data
public class CheckoutRequest {

    @NotNull
    private Long memberId;

    @NotNull
    private Long branchId;

    @NotNull
    private Boolean isTakeout;

    private LocalDateTime pickupTime;

    @NotBlank
    private String pickupMethod;

    private String requestNote;

    @NotEmpty
    @Valid
    private List<OrderItem> orderItems;

    @Data
    public static class OrderItem {
        @NotNull
        private Long productId;

        @NotNull
        @Positive
        private Integer quantity;

        @NotNull
        @Positive
        private Integer price;

        private List<Long> optionIds; //선택된 옵션들
    }

}
