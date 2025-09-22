package com.codepresso.codepresso.scheduler;

import com.codepresso.codepresso.entity.order.Orders;
import com.codepresso.codepresso.repository.order.OrdersRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 주문 상태 자동 업데이트 스케줄러
 * 20초마다 주문 상태를 다음 단계로 진행
 */
@Component
@RequiredArgsConstructor
@Slf4j
public class OrderStatusScheduler {

    private final OrdersRepository ordersRepository;

    /**
     * 20초마다 주문 상태 업데이트
     * 주문접수 → 제조중 → 제조완료 → 픽업완료
     */
    @Scheduled(fixedRate = 20000) // 20초마다 실행
    @Transactional
    public void updateOrderStatus() {
        try {
            // 1. 주문접수 → 제조중
            updateStatusFromTo("주문접수", "제조중");

            // 2. 제조중 → 제조완료
            updateStatusFromTo("제조중", "제조완료");

            // 3. 제조완료 → 픽업완료
            updateStatusFromTo("제조완료", "픽업완료");

            log.info("주문 상태 자동 업데이트 완료: {}", LocalDateTime.now());

        } catch (Exception e) {
            log.error("주문 상태 업데이트 중 오류 발생: {}", e.getMessage());
        }
    }

    /**
     * 특정 상태에서 다음 상태로 업데이트
     */
    private void updateStatusFromTo(String fromStatus, String toStatus) {
        // 현재 상태인 주문들 조회 (20초 이상 된 것만)
        LocalDateTime cutoffTime = LocalDateTime.now().minusSeconds(20);

        // 실제 구현 (OrdersRepository가 준비되면 주석 해제)
        // List<Orders> ordersToUpdate = ordersRepository.findByProductionStatusAndOrderDateBefore(
        //         fromStatus, cutoffTime);

        // 하드코딩 버전 - 실제로는 위 코드 사용
        List<Orders> ordersToUpdate = findDummyOrdersToUpdate(fromStatus, cutoffTime);

        if (!ordersToUpdate.isEmpty()) {
            for (Orders order : ordersToUpdate) {
                order.setProductionStatus(toStatus);

                // 픽업완료 시 픽업 상태도 업데이트
                if ("픽업완료".equals(toStatus)) {
                    order.setIsPickup(true);
                }

                // 실제 저장 (OrdersRepository가 준비되면 주석 해제)
                // ordersRepository.save(order);

                log.info("주문 {} 상태 변경: {} → {}",
                        order.getId(), fromStatus, toStatus);
            }

            log.info("{} → {} 상태 변경 완료: {}건", fromStatus, toStatus, ordersToUpdate.size());
        }
    }

    /**
     * 하드코딩 버전 - 상태 업데이트할 주문 찾기
     * 실제로는 OrdersRepository 메서드 사용
     */
    private List<Orders> findDummyOrdersToUpdate(String fromStatus, LocalDateTime cutoffTime) {
        // 실제 구현에서는 이 메서드 삭제하고 Repository 메서드 사용
        return List.of(); // 빈 리스트 반환 (하드코딩이므로)
    }
}