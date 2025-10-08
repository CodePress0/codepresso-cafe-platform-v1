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
public class OrderCreationService {

    private final ProductRepository productRepository;
    private final ProductOptionRepository productOptionRepository;


    /**
     * 주문 상세 생성
     */
    public List<OrdersDetail> createOrderDetails(List<CheckoutRequest.OrderItem> orderItems, Orders orders) {
        List<OrdersDetail> orderDetails = new ArrayList<>();

        // 할인 전 총액 계산
        int totalBeforeDiscount = orderItems.stream()
                .mapToInt(item -> item.getPrice() * item.getQuantity())
                .sum();

        // 할인 금액 가져오기
        int totalDiscount =orders.getDiscountAmount() != null ? orders.getDiscountAmount() : 0;

        // 할인율 계산
        double discountRate = totalBeforeDiscount > 0 ? (double) totalDiscount/totalBeforeDiscount : 0;

        int accumulateDiscount = 0;

        for (int i = 0; i<orderItems.size(); i++) {
            CheckoutRequest.OrderItem item = orderItems.get(i);

            Product product = productRepository.findById(item.getProductId())
                    .orElseThrow(() -> new RuntimeException("Product not found"));

            int itemOriginalPrice = item.getPrice() * item.getQuantity();

            int itemDiscount;
            if(i==orderItems.size()-1) {
                itemDiscount = totalDiscount - accumulateDiscount;
            }else {
                itemDiscount = (int)Math.round(itemOriginalPrice * discountRate);
                accumulateDiscount = accumulateDiscount + itemDiscount;
            }

            // 할인 적용된 가격
            int discountedPrice = itemOriginalPrice - itemDiscount;

            // 주문 상세 생성
            OrdersDetail ordersDetail = OrdersDetail.builder()
                    .orders(orders)
                    .product(product)
                    .price(discountedPrice)
                    .quantity(item.getQuantity())
                    .build();

            if(item.getOptionIds() != null && !item.getOptionIds().isEmpty()) {
                List<OrdersItemOptions> options = createOrderItemOptions(item.getOptionIds(), ordersDetail);
                ordersDetail.setOptions(options);
            }

            orderDetails.add(ordersDetail);
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