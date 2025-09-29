package com.codepresso.codepresso.service.order;

import com.codepresso.codepresso.converter.order.OrderConverter;
import com.codepresso.codepresso.dto.review.OrdersDetailResponse;
import com.codepresso.codepresso.dto.order.OrderDetailResponse;
import com.codepresso.codepresso.dto.order.OrderListResponse;
import com.codepresso.codepresso.entity.order.Orders;
import com.codepresso.codepresso.entity.order.OrdersDetail;
import com.codepresso.codepresso.entity.order.OrdersItemOptions;
import com.codepresso.codepresso.repository.order.OrdersDetailRepository;
import com.codepresso.codepresso.repository.order.OrdersRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class OrderService {

    private final OrdersRepository ordersRepository;
    private final OrdersDetailRepository ordersDetailRepository;
    private final OrderConverter orderConverter;

    /**
     * 주문 목록 조회
     * */
    public OrderListResponse getOrderList(Long memberId, String period){
        // 기간 계산
        LocalDateTime startDate = calculateStartDate(period);

        // 전체 건수 (기간 무관)
        long totalCount = ordersRepository.countByMemberId(memberId);

        // 기간 필터 적용된 목록 조회
        List<Orders> orders;
        if ("전체".equals(period)) {
            orders = ordersRepository.findByMemberIdOrderByOrderDateDesc(memberId);
        } else {
            orders = ordersRepository.findByMemberIdAndOrderDateAfterOrderByOrderDateDesc(memberId, startDate);
        }
        List<OrderListResponse.OrderSummary> orderSummaries = new ArrayList<>();
        for (Orders order : orders) {
            OrderListResponse.OrderSummary orderSummary = convertToOrderSummary(order);
            orderSummaries.add(orderSummary);
        }

        return OrderListResponse.builder()
                .orders(orderSummaries)
                .totalCount(totalCount)
                .filteredCount(orderSummaries.size())
                .build();
    }

    /**
     * 주문 상세 조회
     * */
    public OrderDetailResponse getOrderDetail(Long orderId){
        //실제구현 나중에 주석 해제
        Orders orders = ordersRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 주문입니다."));
        return convertToOrderDetail(orders);


    }

    private OrderListResponse.OrderSummary convertToOrderSummary(Orders orders) {
        // 대표 상품명 계산
        String representativeItem = calculateRepresentativeItem(orders.getOrdersDetails());

        // 총 금액 계산
        int totalAmount = 0;
        for (OrdersDetail detail : orders.getOrdersDetails()) {
            totalAmount += detail.getPrice();
        }

        return OrderListResponse.OrderSummary.builder()
                .orderId(orders.getId())
                .orderNumber(generateOrderNumber(orders))
                .orderDate(orders.getOrderDate())
                .productionStatus(orders.getProductionStatus())
                .branchName(orders.getBranch().getBranchName())
                .isTakeout(orders.getIsTakeout())
                .pickupTime(orders.getPickupTime())
                .totalAmount(totalAmount)
                .representativeName(representativeItem)
                .build();
    }

    private OrderDetailResponse convertToOrderDetail(Orders orders) {
        // 주문 상품 목록 변환
        List<OrderDetailResponse.OrderItem> orderItems = new ArrayList<>();
        for (OrdersDetail detail : orders.getOrdersDetails()) {
            OrderDetailResponse.OrderItem orderItem = convertToOrderItem(detail);
            orderItems.add(orderItem);
        }

        // 지점 정보
        OrderDetailResponse.BranchInfo branch = OrderDetailResponse.BranchInfo.builder()
                .branchId(orders.getBranch().getId())
                .branchName(orders.getBranch().getBranchName())
                .address(orders.getBranch().getAddress())
                .branchNumber(orders.getBranch().getBranchNumber())
                .build();

        return OrderDetailResponse.builder()
                .orderId(orders.getId())
                .orderNumber(generateOrderNumber(orders))
                .orderDate(orders.getOrderDate())
                .productionStatus(orders.getProductionStatus())
                .pickupTime(orders.getPickupTime())
                .isTakeout(orders.getIsTakeout())
                .requestNote(orders.getRequestNote())
                .branch(branch)
                .orderItems(orderItems)
                .build();
    }

    private OrderDetailResponse.OrderItem convertToOrderItem(OrdersDetail detail) {
        // 옵션들 수집 (기본 옵션 제외)
        List<OrderDetailResponse.OrderOption> options = new ArrayList<>();
        if (detail.getOptions() != null) {
            for (OrdersItemOptions option : detail.getOptions()) {
                String optionStyle = option.getOption().getOptionStyle().getOptionStyle();
                Integer extraPrice = option.getOption().getOptionStyle().getExtraPrice();

                // "기본" 옵션 제외
                if (!"기본".equals(optionStyle)) {
                    options.add(OrderDetailResponse.OrderOption.builder()
                            .optionStyle(optionStyle)
                            .extraPrice(extraPrice)
                            .build());
                }
            }
        }

        return OrderDetailResponse.OrderItem.builder()
                .orderDetailId(detail.getId())
                .productName(detail.getProduct().getProductName())
                .quantity(detail.getQuantity() != null ? detail.getQuantity() : 1)
                .price(detail.getProduct().getPrice())
                .totalPrice(detail.getPrice())
                .options(options)
                .build();
    }

    private String calculateRepresentativeItem(List<OrdersDetail> orderDetails) {
        if (orderDetails.isEmpty()) {
            return "주문 상품 없음";
        }

        String firstProductName = orderDetails.get(0).getProduct().getProductName();
        int totalItems = orderDetails.size();

        if (totalItems == 1) {
            return firstProductName;
        } else {
            return firstProductName + " 외 " + (totalItems - 1) + "개";
        }
    }

    private String generateOrderNumber(Orders orders) {
        LocalDateTime orderDate = orders.getOrderDate();
        String phone = orders.getMember() != null ? orders.getMember().getPhone() : null;
        String last4 = "0000";
        if (phone != null) {
            String digits = phone.replaceAll("\\D", "");
            if (digits.length() >= 4) last4 = digits.substring(digits.length() - 4);
        }
        LocalDateTime startOfDay = orderDate.toLocalDate().atStartOfDay();
        LocalDateTime endOfDay = startOfDay.plusDays(1).minusNanos(1);
        long seq = ordersRepository.countByOrderDateBetweenAndOrderDateLessThanEqual(startOfDay, endOfDay, orderDate);
        if (seq < 1) seq = 1; // 안전장치
        return String.format("%s-%d", last4, seq);
    }

    /**
     * 기간별 시작일 계산
     */
    private LocalDateTime calculateStartDate(String period) {
        LocalDateTime now = LocalDateTime.now();

        switch (period) {
            case "1개월":
                return now.minusMonths(1);
            case "3개월":
                return now.minusMonths(3);
            case "전체":
                return LocalDateTime.of(2020, 1, 1, 0, 0);
            default:
                return now.minusMonths(1); // 기본값: 1개월
        }
    }

    /**
     * 특정 주문 상품
     */
    /**
     * 특정 주문 상품
     */
    public OrdersDetailResponse getOrdersDetail(Long orderDetailId) {
        OrdersDetail ordersDetail = ordersDetailRepository.findById(orderDetailId)
                .orElseThrow(() -> new RuntimeException("OrdersDetail not found: " + orderDetailId));

        return orderConverter.toDto(ordersDetail);
    }

}
