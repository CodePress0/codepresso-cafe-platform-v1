package com.codepresso.codepresso.service.payment;

import com.codepresso.codepresso.dto.payment.CheckoutRequest;
import com.codepresso.codepresso.dto.payment.CheckoutResponse;
import com.codepresso.codepresso.entity.branch.Branch;
import com.codepresso.codepresso.entity.member.Member;
import com.codepresso.codepresso.entity.order.Orders;
import com.codepresso.codepresso.entity.order.OrdersDetail;
import com.codepresso.codepresso.entity.order.OrdersItemOptions;
import com.codepresso.codepresso.entity.product.Product;
import com.codepresso.codepresso.entity.product.ProductOption;
import com.codepresso.codepresso.repository.branch.BranchRepository;
import com.codepresso.codepresso.repository.member.MemberRepository;
import com.codepresso.codepresso.repository.order.OrdersRepository;
import com.codepresso.codepresso.repository.product.ProductOptionRepository;
import com.codepresso.codepresso.repository.product.ProductRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 결제 서비스
 */

@Service
@RequiredArgsConstructor
public class PaymentService {

    private final MemberRepository memberRepository;
    private final OrdersRepository ordersRepository;
    private final BranchRepository branchRepository;
    private final ProductRepository productRepository;
    private final ProductOptionRepository productOptionRepository;

    /**
     * 주문 및 결제 처리 ( 결제없이 주문만 생성 )
     */
    @Transactional
    public CheckoutResponse processCheckout(CheckoutRequest request) {
        // 1. 회원 및 지점 정보 조회
        Member member = memberRepository.findById(request.getMemberId())
                .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 회원입니다."));

        // 지점정보조회
        Branch branch = branchRepository.findById(request.getBranchId())
                .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 지점입니다."));

        // 2. 주문생성
        Orders orders = createOrder(request, member, branch);

        // 3. 주문 상세 생성
        List<OrdersDetail> ordersDetails = createOrderDetails(request.getOrderItems(), orders);
        orders.setOrdersDetails(ordersDetails);

        // 4. 주문 저장 - orderRepository 만든 후 주석 해제
        Orders savedOrder = ordersRepository.save(orders);

        // 5. 응답 데이터 생성
        return buildCheckoutResponse(savedOrder);
    }

    private Orders createOrder(CheckoutRequest request, Member member, Branch branch) {
        return Orders.builder()
                .member(member)
                .branch(branch)
                .productionStatus("주문접수")
                .isTakeout(request.getIsTakeout())
                .pickupTime(request.getPickupTime())
                .orderDate(LocalDateTime.now())
                .requestNote(request.getRequestNote())
                .isPickup(false) // 초기값: 픽업 전
                .build();
    }

    private List<OrdersDetail> createOrderDetails(List<CheckoutRequest.OrderItem> orderItems, Orders orders) {
        List<OrdersDetail> orderDetails = new ArrayList<>();

        for (CheckoutRequest.OrderItem item : orderItems) {

            Product product = productRepository.findById(item.getProductId())
                    .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 상품입니다: " + item.getProductId()));


            OrdersDetail orderDetail = OrdersDetail.builder()
                    .orders(orders)
                    .product(product)
                    .price(item.getPrice() * item.getQuantity())
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

    private List<OrdersItemOptions> createOrderItemOptions(List<Long> optionIds, OrdersDetail orderDetail) {
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

    private CheckoutResponse buildCheckoutResponse(Orders orders) {
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
                    .quantity(1) // OrdersDetail에 quantity 필드가 없어서 일단 1로 설정
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
