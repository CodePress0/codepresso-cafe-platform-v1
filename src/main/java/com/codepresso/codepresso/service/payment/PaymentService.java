package com.codepresso.codepresso.service.payment;

import com.codepresso.codepresso.config.TossPaymentsConfig;
import com.codepresso.codepresso.dto.cart.CartItemResponse;
import com.codepresso.codepresso.dto.cart.CartResponse;
import com.codepresso.codepresso.dto.payment.CheckoutRequest;
import com.codepresso.codepresso.dto.payment.CheckoutResponse;
import com.codepresso.codepresso.dto.payment.TossPaymentConfirmResponse;
import com.codepresso.codepresso.dto.payment.TossPaymentRequest;
import com.codepresso.codepresso.dto.product.ProductDetailResponse;
import com.codepresso.codepresso.dto.product.ProductOptionDTO;
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
import com.codepresso.codepresso.service.cart.CartService;
import com.codepresso.codepresso.service.coupon.CouponService;
import com.codepresso.codepresso.service.coupon.StampService;
import com.codepresso.codepresso.service.product.ProductService;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 결제 서비스
 */

@Service
@RequiredArgsConstructor
public class PaymentService {

    private final MemberRepository memberRepository;
    private final OrdersRepository ordersRepository;
    private final BranchRepository branchRepository;
    private final CartService cartService;
    private final ProductService productService;

    private final PaymentConverter paymentConverter;
    private final PaymentCalculationService paymentCalculationService;
    private final OrderCreationService orderCreationService;
    private final StampService stampService;
    private final CouponService couponService;
    private final TossPaymentsConfig tossPaymentsConfig;

    /**
     * 통합 결제 준비 메서드 (Cart + Direct 통합)
     */
    public CheckoutResponse prepareCheckout(Long memberId,
                                          Long productId,
                                          Integer quantity,
                                          List<Long> optionIds) {
        if (productId != null) {
            // 직접구매 로직
            return prepareDirectCheckoutInternal(productId, quantity, optionIds);
        } else {
            // 장바구니 로직
            return prepareCartCheckoutInternal(memberId);
        }
    }

    /**
     * 장바구니 결제 준비 (내부용)
     */
    private CheckoutResponse prepareCartCheckoutInternal(Long memberId) {
        CartResponse cartData = cartService.getCartByMemberId(memberId);

        List<CheckoutResponse.OrderItem> orderItems = cartData.getItems().stream()
            .map(paymentConverter::convertCartItemToOrderItem)
            .collect(Collectors.toList());

        int totalAmount = cartData.getItems().stream().mapToInt(CartItemResponse::getPrice).sum();
        int totalQuantity = cartData.getItems().stream().mapToInt(CartItemResponse::getQuantity).sum();

        return CheckoutResponse.builder()
            .orderItems(orderItems)
            .totalAmount(totalAmount)
            .totalQuantity(totalQuantity)
            .isFromCart(true)
            .build();
    }

    /**
     * 직접구매 결제 준비 (내부용)
     */
    private CheckoutResponse prepareDirectCheckoutInternal(Long productId, Integer quantity, List<Long> optionIds) {
        // 1. 수량 검증
        if (quantity == null || quantity <= 0) {
            throw new IllegalArgumentException("수량은 1 이상이어야 합니다.");
        }

        // 2. 상품 상세 정보 조회
        ProductDetailResponse productDetail = productService.findByProductId(productId);

        // 3. 선택된 옵션들과 총 가격 계산
        List<ProductOptionDTO> selectedOptions = new ArrayList<>();
        int totalAmount = paymentCalculationService.calculateTotalAmount(productDetail, optionIds, quantity, selectedOptions);

        // 4. OrderItem 생성
        CheckoutResponse.OrderItem orderItem = paymentConverter.convertDirectToOrderItem(
            productDetail, quantity, totalAmount, selectedOptions, productId, optionIds);

        return CheckoutResponse.builder()
            .orderItems(Arrays.asList(orderItem))
            .totalAmount(totalAmount)
            .totalQuantity(quantity)
            .isFromCart(false)
            .build();
    }

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

        // (+) 쿠폰 사용 처리
        if(request.getUsedCouponId() != null) {
            // 쿠폰 할인 금액 검증
            int calculatedDiscount = couponService.calculateCouponDiscount(
                    request.getUsedCouponId(), request.getTotalAmount());

            // 프론트에서 보낸 할인금액과 일치하는지 확인
            if(!request.getCouponDiscountAmount().equals(calculatedDiscount)) {
                throw new IllegalArgumentException("쿠폰 할인금액이 올바르지 않습니다.");
            }

            couponService.useCoupon(request.getUsedCouponId());
        }

        // 2. 주문생성 ( 장바구니, 단일상품 동일하게 처리 )
        Orders orders = orderCreationService.createOrder(request, member, branch);

        // 3. 주문 상세 생성
        List<OrdersDetail> ordersDetails = orderCreationService.createOrderDetails(request.getOrderItems(), orders);
        orders.setOrdersDetails(ordersDetails);

        // 4. 주문 저장
        Orders savedOrder = ordersRepository.save(orders);

        // 스탬프 적립
        stampService.earnStampsFromOrder(member.getId(),ordersDetails);

        // 5. 장바구니에서 온 주문인 경우 장바구니 비우기
        if (Boolean.TRUE.equals(request.getIsFromCart())) {
            System.out.println("장바구니 결제 감지 - 장바구니 비우기 실행 시작 (memberId: " + member.getId() + ")");
            try {
                CartResponse cartData = cartService.getCartByMemberId(member.getId());
                cartService.clearCart(member.getId(), cartData.getCartId());
                System.out.println("✅ 장바구니 비우기 성공 - memberId: " + member.getId() + ", cartId: " + cartData.getCartId());
            } catch (Exception e) {
                // 장바구니 비우기 실패해도 주문은 유지 (로그 남기고 계속 진행)
                System.err.println("❌ 장바구니 비우기 실패 - memberId: " + member.getId() + ", 오류: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            System.out.println("단일 상품 결제 - 장바구니 비우기 건너뛰기 (isFromCart: " + request.getIsFromCart() + ")");
        }

        // 6. 응답 데이터 생성
        return paymentConverter.buildCheckoutResponse(savedOrder);
    }


    public TossPaymentConfirmResponse confirmTossPayment(String paymentKey, String orderId, String amount) {
        try {
            RestTemplate restTemplate = new RestTemplate();

            // 요청 데이터 (간단하게)
            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("paymentKey", paymentKey);
            requestBody.put("orderId", orderId);
            requestBody.put("amount", Integer.parseInt(amount));

            // 헤더 설정 (토스 Basic Auth)
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            String secretKey = tossPaymentsConfig.getSecretKey() + ":";
            String auth = Base64.getEncoder().encodeToString(secretKey.getBytes());
            headers.set("Authorization", "Basic " + auth);

            // API 호출
            HttpEntity<Map<String, Object>> request = new HttpEntity<>(requestBody, headers);
            String url = tossPaymentsConfig.getBaseUrl() + "/v1/payments/confirm";

            ResponseEntity<TossPaymentConfirmResponse> response =
                    restTemplate.postForEntity(url, request, TossPaymentConfirmResponse.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                TossPaymentConfirmResponse result = response.getBody();

                // 간단 검증만
                if (!"DONE".equals(result.getStatus())) {
                    throw new RuntimeException("결제 승인 실패: " + result.getStatus());
                }

                return result;
            } else {
                throw new RuntimeException("토스 API 호출 실패");
            }

        } catch (Exception e) {
            throw new RuntimeException("토스 결제 승인 실패: " + e.getMessage());
        }
    }
}
