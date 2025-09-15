package com.codepresso.codepresso.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@RequiredArgsConstructor
@Table(name="cart_option")
@Entity
public class CartOption {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="cart_option_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "product_option_id", nullable = false)
    private ProductOption productoption;

    @ManyToOne(fetch=FetchType.LAZY, optional = false)
    @JoinColumn(name = "cart_item_id", nullable = false)
    private CartItem cartItem;
}
