package com.codepresso.codepresso.service.payment;

import com.codepresso.codepresso.dto.cart.CartItemResponse;
import com.codepresso.codepresso.dto.payment.CheckoutResponse;
import com.codepresso.codepresso.dto.product.ProductDetailResponse;
import com.codepresso.codepresso.dto.product.ProductOptionDTO;
import com.codepresso.codepresso.entity.order.Orders;
import com.codepresso.codepresso.entity.order.OrdersDetail;
import com.codepresso.codepresso.entity.order.OrdersItemOptions;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 결제 관련 데이터 변환을 담당하는 컨버터 클래스
 */
@Component
class PaymentConverter {

    /**
     * 장바구니 아이템을 OrderItem으로 변환
     */
    public CheckoutResponse.OrderItem convertCartItemToOrderItem(CartItemResponse item) {
        List<String> optionNames = item.getOptions().stream()
            .map(opt -> opt.getOptionStyle())
            .filter(style -> !"기본".equals(style))
            .collect(Collectors.toList());
            
        return CheckoutResponse.OrderItem.builder()
            .productName(item.getProductName())
            .productPhoto(item.getProductPhoto())
            .quantity(item.getQuantity())
            .unitPrice(item.getPrice() / item.getQuantity())
            .lineTotal(item.getPrice())
            .optionNames(optionNames)
            .build();
    }

    /**
     * 직접구매 정보를 OrderItem으로 변환
     */
    public CheckoutResponse.OrderItem convertDirectToOrderItem(ProductDetailResponse productDetail,
                                                             Integer quantity, 
                                                             Integer totalAmount,
                                                             List<ProductOptionDTO> selectedOptions,
                                                             Long productId,
                                                             List<Long> optionIds) {
        List<String> optionNames = selectedOptions.stream()
            .map(opt -> opt.getOptionName() + " : " + opt.getOptionStyleName())
            .filter(name -> !name.contains("기본"))
            .collect(Collectors.toList());
            
        return CheckoutResponse.OrderItem.builder()
            .productName(productDetail.getProductName())
            .productPhoto(productDetail.getProductPhoto())
            .quantity(quantity)
            .unitPrice(productDetail.getPrice())
            .lineTotal(totalAmount)
            .optionNames(optionNames)
            .productId(productId)
            .optionIds(optionIds)
            .build();
    }

    /**
     * 주문 완료 후 응답 데이터 생성
     */
    public CheckoutResponse buildCheckoutResponse(Orders orders) {
        // 1. 주문 상세 정보 리스트 생성
        List<CheckoutResponse.OrderItem> orderItems = new ArrayList<>();

        // 2. 각 주문 상세를 OrderItem으로 변환
        for (OrdersDetail detail : orders.getOrdersDetails()) {
            // 옵션 이름들 수집
            List<String> optionNames = new ArrayList<>();
            if (detail.getOptions() != null) {
                for (OrdersItemOptions option : detail.getOptions()) {
                    optionNames.add(option.getOption().getOptionStyle().getOptionName().getOptionName());
                }
            }

            // OrderItem 생성
            CheckoutResponse.OrderItem orderItem = CheckoutResponse.OrderItem.builder()
                    .orderDetailId(detail.getId())
                    .productName(detail.getProduct().getProductName())
                    .quantity(detail.getQuantity() != null ? detail.getQuantity() : 1)
                    .price(detail.getPrice())
                    .optionNames(optionNames)
                    .build();

            orderItems.add(orderItem);
        }

        // 3. 총 주문 금액 계산
        int totalAmount = 0;
        for (OrdersDetail detail : orders.getOrdersDetails()) {
            totalAmount += detail.getPrice();
        }

        // 4. 최종 응답 객체 생성
        return CheckoutResponse.builder()
                .orderId(orders.getId())
                .productionStatus(orders.getProductionStatus())
                .orderDate(orders.getOrderDate())
                .pickupTime(orders.getPickupTime())
                .isTakeout(orders.getIsTakeout())
                .requestNote(orders.getRequestNote())
                .totalAmount(totalAmount)
                .orderItems(orderItems)
                .build();
    }
}