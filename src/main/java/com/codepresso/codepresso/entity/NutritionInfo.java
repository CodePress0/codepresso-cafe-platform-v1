package com.codepresso.codepresso.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "nutrition_info")
@Entity
public class NutritionInfo {

    @Id
    @Column(name = "product_id")
    private Long productId; // PK = FK

    @OneToOne
    @MapsId // PK = FK
    @JoinColumn(name = "product_id")
    private Product product;

    private double calories;

    private double protein;

    private double fat;

    private double carbohydrate;

    private double saturatedFat;

    private double transFat;

    private double sodium;

    private double sugar;

    private int cholesterol;

}
