package com.codepresso.codepresso.dto.coupon;

import com.codepresso.codepresso.entity.coupon.Stamp;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Builder
@Data
public class StampResponse {
    private List<Stamp> stamps; // 스탬프 목록
    private Long totalStamps;   // 총 스탬프 개수
    private Long stampsNeededForCoupon; // 쿠폰까지 필요한 스탬프 개수
}
