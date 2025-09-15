package com.codepresso.codepresso.entity.coupon;

import com.codepresso.codepresso.entity.order.OrdersDetail;
import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;




@NoArgsConstructor @AllArgsConstructor @Builder
@Getter @Setter
@Table(name = "stamp")
@Entity
public class Stamp {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "stamp_id")
    private Long id;

    // FK → Member
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id", nullable = false)
    private Member member;

    // FK → OrderSlave (주문 상세)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_detail_id", nullable = false)
    private OrdersDetail ordersDetail;

    @Column(name = "earned_date")
    private LocalDateTime earnedDate;

    @Column(name = "quantity")
    private Integer quantity;

    @Column(name = "stamp_status", length = 50)
    private String stampStatus;   // 쿠폰 발급 여부 확인 컬럼
}

