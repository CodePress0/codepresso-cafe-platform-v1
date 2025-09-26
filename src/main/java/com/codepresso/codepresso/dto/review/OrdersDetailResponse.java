package com.codepresso.codepresso.dto.review;

import com.codepresso.codepresso.entity.order.OrdersDetail;
import lombok.*;

import java.util.Optional;

@Data
@Builder
public class OrdersDetailResponse {
    private Long orderDetailId;
    private String productName;
    private String productPhoto;
    private String branchName;

    public static OrdersDetailResponse of(Optional<OrdersDetail> ordersDetail) {

        return OrdersDetailResponse.builder()
                .orderDetailId(ordersDetail.get().getId())
                .productName(ordersDetail.get().getProduct().getProductName())
                .productPhoto(ordersDetail.get().getProduct().getProductPhoto())
                .branchName(ordersDetail.get().getOrders().getBranch().getBranchName())
                .build();
    }
}
