package com.codepresso.codepresso.repository.coupon;

import com.codepresso.codepresso.entity.coupon.Stamp;
import com.codepresso.codepresso.entity.member.Member;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StampRepository extends CrudRepository<Stamp, Long> {
    /**
     * memberId로 그 member의 모든 스탬프 조회
     * 스탬프 적립 목록 보여줄 때 사용
     * */
//    List<Stamp> findByMemberOrderByEarnedDateDesc(Member member);

    /**
     * memberId로 member의 스탬프 총 수량 합계 조회
     * */
//    Long sumQuantityByMember(Member member);


}
