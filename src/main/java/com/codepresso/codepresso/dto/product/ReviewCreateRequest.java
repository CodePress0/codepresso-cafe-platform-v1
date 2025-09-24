package com.codepresso.codepresso.dto.product;

import com.codepresso.codepresso.entity.order.OrdersDetail;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewCreateRequest {
    private Long orderId;
    private Long orderDetailId;
    private BigDecimal rating;
    private String content;
    private String photoUrl;
}
