package com.codepresso.codepresso.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "allergen")
@Entity
public class Allergen {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "allegen_id")
    private Long id;

    @Column(name = "allegen_name", nullable = false)
    private String allegenName;

    @Column(name = "allegen_code")
    private String allegenCode;

    // 1:N - AllergenProduct
    @OneToMany(mappedBy = "allergen", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<AllergenProduct> allergenProducts = new ArrayList<>();
}
