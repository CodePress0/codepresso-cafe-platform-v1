package com.codepresso.codepresso.dto.product;

import com.codepresso.codepresso.entity.product.NutritionInfo;
import lombok.Getter;

@Getter
public class NutritionInfoDTO {
    private double calories;

    private double protein;

    private double fat;

    private double carbohydrate;

    private double saturatedFat;

    private double transFat;

    private double sodium;

    private double sugar;
    private double caffeine;

    private int cholesterol;

    public NutritionInfoDTO(NutritionInfo nutritionInfo) {
        this.calories = nutritionInfo.getCalories();
        protein = nutritionInfo.getProtein();
        fat = nutritionInfo.getFat();
        carbohydrate = nutritionInfo.getCarbohydrate();
        saturatedFat= nutritionInfo.getSaturatedFat();
        transFat = nutritionInfo.getTransFat();
        sodium = nutritionInfo.getSodium();
        sugar = nutritionInfo.getSugar();
        caffeine = nutritionInfo.getCaffeine();
        cholesterol = nutritionInfo.getCholesterol();
    }
}