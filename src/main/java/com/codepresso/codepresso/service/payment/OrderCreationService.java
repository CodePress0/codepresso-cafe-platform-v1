package com.codepresso.codepresso.service.payment;

import com.codepresso.codepresso.dto.payment.CheckoutRequest;
import com.codepresso.codepresso.entity.branch.Branch;
import com.codepresso.codepresso.entity.member.Member;
import com.codepresso.codepresso.entity.order.Orders;
import com.codepresso.codepresso.entity.order.OrdersDetail;
import com.codepresso.codepresso.entity.order.OrdersItemOptions;
import com.codepresso.codepresso.entity.product.Product;
import com.codepresso.codepresso.entity.product.ProductOption;
import com.codepresso.codepresso.repository.product.ProductOptionRepository;
import com.codepresso.codepresso.repository.product.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 주문 생성 로직을 담당하는 서비스 클래스
 */
@Component
@RequiredArgsConstructor
class OrderCreationService {

    private final ProductRepository productRepository;
    private final ProductOptionRepository productOptionRepository;

    /**
     * 주문 생성
     */
    public Orders createOrder(CheckoutRequest request, Member member, Branch branch) {
        return Orders.builder()
                .member(member)
                .branch(branch)
                .productionStatus("픽업완료")
                .isTakeout(request.getIsTakeout())
                .pickupTime(request.getPickupTime())
                .orderDate(LocalDateTime.now())
                .requestNote(request.getRequestNote())
                .isPickup(true)
                .totalAmount(request.getTotalAmount())
                .discountAmount(request.getTotalDiscountAmount())
                .finalAmount(request.getTotalAmount()-request.getTotalDiscountAmount())
                .usedCouponId(request.getUsedCouponId())
                .build();
    }

    /**
     * 주문 상세 생성
     */
    public List<OrdersDetail> createOrderDetails(List<CheckoutRequest.OrderItem> orderItems, Orders orders) {
        List<OrdersDetail> orderDetails = new ArrayList<>();

        for (CheckoutRequest.OrderItem item : orderItems) {

            Product product = productRepository.findById(item.getProductId())
                    .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 상품입니다: " + item.getProductId()));

            // 주문 상세 생성 (총액 = 단가*수량, 수량은 OrdersDetail에 저장)
            OrdersDetail orderDetail = OrdersDetail.builder()
                    .orders(orders)
                    .product(product)
                    .price(item.getPrice() * item.getQuantity())
                    .quantity(item.getQuantity())
                    .build();

            // 옵션 추가
            if (item.getOptionIds() != null && !item.getOptionIds().isEmpty()) {
                List<OrdersItemOptions> options = createOrderItemOptions(item.getOptionIds(), orderDetail);
                orderDetail.setOptions(options);
            }

            orderDetails.add(orderDetail);
        }

        return orderDetails;
    }

    /**
     * 주문 아이템 옵션 생성
     */
    public List<OrdersItemOptions> createOrderItemOptions(List<Long> optionIds, OrdersDetail orderDetail) {
        List<OrdersItemOptions> orderItemOptions = new ArrayList<>();

        for (Long optionId : optionIds) {
            ProductOption productOption = productOptionRepository.findById(optionId)
                    .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 옵션입니다: " + optionId));

            OrdersItemOptions orderItemOption = OrdersItemOptions.builder()
                    .option(productOption)
                    .ordersDetail(orderDetail)
                    .build();

            orderItemOptions.add(orderItemOption);
        }

        return orderItemOptions;
    }
}