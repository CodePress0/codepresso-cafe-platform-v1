package com.codepresso.codepresso.controller.order;

import com.codepresso.codepresso.dto.order.OrderDetailResponse;
import com.codepresso.codepresso.dto.order.OrderListResponse;
import com.codepresso.codepresso.security.LoginUser;
import com.codepresso.codepresso.service.order.OrderService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/orders")
public class OrderViewPageController {

    private final OrderService orderService;

    public OrderViewPageController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping
    public String orderListPage(
            @RequestParam(defaultValue = "1개월") String period,
            @AuthenticationPrincipal LoginUser loginUser,
            Model model
            ) {
        try{
            // 주문 목록 조회
            OrderListResponse orderList = orderService.getOrderList(loginUser.getMemberId(), period);

            // Model에 데이터 추가
            model.addAttribute("orderList", orderList);
            model.addAttribute("selectedPeriod", period);
            model.addAttribute("totalCount",orderList.getTotalCount());
            model.addAttribute("filteredCount",orderList.getFilteredCount());
            model.addAttribute("hasOrders",!orderList.getOrders().isEmpty());

            // 기간 옵션
            List<String> periodOptions = Arrays.asList("1개월","3개월","전체");
            model.addAttribute("periodOptions",periodOptions);
        }catch(Exception e){
            model.addAttribute("error","주문 내역을 불러올 수 없습니다:" + e.getMessage());
            model.addAttribute("hasOrders",false);
        }
        return "order/order-list";
    }

    @GetMapping("/{orderId}")
    public String orderDetailPage(@PathVariable Long orderId, Model model) {
        // OrderService에서 주문 상세 정보 조회
        OrderDetailResponse orderDetail = orderService.getOrderDetail(orderId);

        // Model에 할인 정보를 포함해 정보 전달
        model.addAttribute("orderId", orderId);
        model.addAttribute("orderDetail", orderDetail);
        model.addAttribute("paymentInfo",orderDetail.getPayment());

        return "order/orderDetail";
    }
}

