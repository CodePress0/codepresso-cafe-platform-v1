package com.codepresso.codepresso.dto.product;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class HashtagDTO {
    private String hashtagName;
    private String hashtagId;
    private String productId;
}
