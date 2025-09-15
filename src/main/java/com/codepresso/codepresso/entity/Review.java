package com.codepresso.codepresso.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "review")
@Entity
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "review_id")
    private Long id;

    private double rating;

    private String content;

    @Column(name = "photo_url")
    private String photoUrl;

//    @ManyToOne
//    @JoinColumn(name = "order_detail_id", nullable = false)
//    private OrdersDetail ordersDetail;

//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "member_id", nullable = false)
//    private Member member;

}
