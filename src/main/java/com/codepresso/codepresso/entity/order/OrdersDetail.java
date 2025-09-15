package com.codepresso.codepresso.entity.order;

import com.codepresso.codepresso.entity.Product;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@NoArgsConstructor @AllArgsConstructor @Builder
@Getter @Setter
@Table(name = "order_detail")
@Entity
public class OrdersDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_detail_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", nullable = false)
    private Orders orders;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @Column(name = "price")
    private Integer price;

    @OneToMany(mappedBy = "orderDetail", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrdersItemOptions> options;
}
