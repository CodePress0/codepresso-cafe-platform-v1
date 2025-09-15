package com.codepresso.codepresso.entity.order;

import com.codepresso.codepresso.entity.Branch;
import com.codepresso.codepresso.entity.Member;
import com.codepresso.codepresso.entity.payment.Payment;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor @Builder
@Table(name="order_master")
@Entity
public class Orders {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name = "order_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "branch_id", nullable = false)
    private Branch branch;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id", nullable = false)
    private Member member;

    @Column(name = "production_status", length = 50)
    private String productionStatus;

    @Column(name = "takeout")
    private Boolean isTakeout;

    @Column(name = "pickup_time")
    private LocalDateTime pickupTime;

    @Column(name = "order_date")
    private LocalDateTime orderDate;

    @Column(name = "request_note",length = 100)
    private String requestNote;

    @Column(name = "pickup")
    private Boolean isPickup;

    // 주문 마스터 <-> 주문상세 (1:N)
    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrdersDetail> ordersDetails;

    // 주문 <-> 결제 마스터 (1:1)
    @OneToOne(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private Payment payment;
}
