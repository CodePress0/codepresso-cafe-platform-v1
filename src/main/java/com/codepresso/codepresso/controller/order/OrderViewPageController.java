package com.codepresso.codepresso.controller.order;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/orders")
public class OrderViewPageController {

    @GetMapping("")
    public String orderListPage() {
        return "order/order-list";
    }

    @GetMapping("/{orderId}")
    public String orderDetailPage(@PathVariable Long orderId, Model model) {
        model.addAttribute("orderId", orderId);
        return "order/orderDetail";
    }
}

