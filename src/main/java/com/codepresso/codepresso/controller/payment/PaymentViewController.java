package com.codepresso.codepresso.controller.payment;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 결제 페이지 뷰 컨트롤러
 */
@Controller
@RequestMapping("/payments")
public class PaymentViewController {
    
    @GetMapping("")
    public String paymentsPage() {
        return "payment/checkout";
    }
}

@Controller
class OrderViewController {
    
    @GetMapping("/orderDetail")
    public String orderDetailPage() {
        return "order/orderDetail";
    }
}