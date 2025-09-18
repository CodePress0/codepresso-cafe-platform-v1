<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문상세조회 - 바나프레소</title>
</head>

<body>
<div class="order-detail-container">
    <!-- 상단 헤더 -->
    <div class="order-header">
        <div class="header-content">
            <button class="back-btn" onclick="history.back()">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                    <path d="M15 18L9 12L15 6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </button>
            <h1 class="page-title">주문상세조회</h1>
        </div>
    </div>

    <!-- 메인 컨텐츠 -->
    <div class="main-content">
        <!-- 좌측: 주문 정보 -->
        <div class="left-section">
            <!-- 주문 상태 -->
            <div class="order-status-section">
                <div class="status-header">
                    <div class="order-number">주문번호(9035-2)</div>
                    <span class="status-badge status-making">제조중</span>
                </div>

                <div class="status-progress">
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 50%;"></div>
                    </div>
                    <div class="progress-steps">
                        <div class="step completed">주문접수</div>
                        <div class="step active">제조중</div>
                        <div class="step">제조완료</div>
                        <div class="step">픽업완료</div>
                    </div>
                </div>

                <div class="order-meta">
                    <div class="meta-row">
                        <span class="meta-label">주문일시</span>
                        <span class="meta-value">2025-09-06 14:30</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">픽업예정</span>
                        <span class="meta-value">2025-09-06 14:45 (15분 후)</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">주문형태</span>
                        <span class="meta-value">테이크아웃</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">포장방법</span>
                        <span class="meta-value">전체포장(케리어)</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">요청사항</span>
                        <span class="meta-value">얼음 적게 해주세요</span>
                    </div>
                </div>
            </div>

            <!-- 주문 상품 목록 -->
            <div class="order-items-section">
                <h2 class="section-title">주문상품</h2>

                <div class="order-items">
                    <div class="order-item">
                        <div class="item-number">1</div>
                        <img src="https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483411048.jpg"
                             alt="시그니처아메리카노" class="item-image">
                        <div class="item-details">
                            <div class="item-name">시그니처아메리카노</div>
                            <div class="item-options">ICE, 샷 추가</div>
                            <div class="item-quantity">수량: 2개</div>
                        </div>
                        <div class="item-pricing">
                            <div class="unit-price">단가: 2,900원</div>
                            <div class="total-price">5,800원</div>
                        </div>
                    </div>

                    <div class="order-item">
                        <div class="item-number">2</div>
                        <img src="https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487121681.jpg"
                             alt="망고주스" class="item-image">
                        <div class="item-details">
                            <div class="item-name">망고주스</div>
                            <div class="item-options">ICE</div>
                            <div class="item-quantity">수량: 1개</div>
                        </div>
                        <div class="item-pricing">
                            <div class="unit-price">단가: 4,000원</div>
                            <div class="total-price">4,000원</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 지점 정보 -->
            <div class="store-section">
                <h2 class="section-title">픽업 매장</h2>
                <div class="store-info">
                    <div class="store-header">
                        <div class="store-name">강남대로점</div>
                        <button class="call-btn" onclick="callStore('070-4512-0297')">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                                <path d="M22 16.92V19.92C22 20.52 21.52 21 20.92 21C10.93 21 3 13.07 3 3.08C3 2.48 3.48 2 4.08 2H7.08C7.68 2 8.16 2.48 8.16 3.08V6.08C8.16 6.68 7.68 7.16 7.08 7.16H5.12C6.57 11.25 9.75 14.43 13.84 15.88V13.92C13.84 13.32 14.32 12.84 14.92 12.84H17.92C18.52 12.84 19 13.32 19 13.92V16.92C19 17.52 18.52 18 17.92 18H16.92" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            070-4512-0297
                        </button>
                    </div>
                    <div class="store-address">서울시 강남구 강남대로 123길 45</div>
                    <div class="store-hours">영업시간: 07:00 - 22:00</div>
                </div>
            </div>
        </div>

        <!-- 우측: 결제 정보 -->
        <div class="right-section">
            <!-- 결제 정보 -->
            <div class="payment-info-section">
                <h2 class="section-title">결제정보</h2>
                <div class="payment-details">
                    <div class="payment-method">
                        <span class="method-label">결제수단</span>
                        <span class="method-value">신용카드</span>
                    </div>
                    <div class="payment-date">
                        <span class="date-label">결제일시</span>
                        <span class="date-value">2025-09-06 14:30</span>
                    </div>
                </div>

                <div class="payment-summary">
                    <div class="summary-row">
                        <span>주문금액</span>
                        <span>9,800원</span>
                    </div>
                    <div class="summary-row">
                        <span>총 수량</span>
                        <span>3개</span>
                    </div>
                    <div class="summary-divider"></div>
                    <div class="summary-row total">
                        <span>총 결제금액</span>
                        <span class="total-amount">9,800원</span>
                    </div>
                </div>
            </div>

            <!-- 주문 액션 -->
            <div class="order-actions">
                <button class="btn-secondary" onclick="goToOrderList()">주문목록</button>
                <button class="btn-primary" onclick="reorder()">재주문</button>
            </div>
        </div>
    </div>
</div>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Malgun Gothic', sans-serif;
        background-color: #f8f9fa;
        color: #333;
        line-height: 1.6;
    }

    .order-detail-container {
        max-width: 1200px;
        margin: 0 auto;
        background-color: #fff;
        min-height: 100vh;
    }

    .order-header {
        background-color: #fff;
        border-bottom: 1px solid #e9ecef;
        position: sticky;
        top: 0;
        z-index: 100;
        padding: 0 24px;
    }

    .header-content {
        display: flex;
        align-items: center;
        height: 64px;
        max-width: 1200px;
        margin: 0 auto;
    }

    .back-btn {
        background: none;
        border: none;
        color: #666;
        cursor: pointer;
        padding: 8px;
        margin-right: 16px;
        border-radius: 4px;
        transition: background-color 0.2s;
    }

    .back-btn:hover {
        background-color: #f8f9fa;
    }

    .page-title {
        font-size: 20px;
        font-weight: 600;
        color: #333;
    }

    .main-content {
        display: grid;
        grid-template-columns: 1fr 400px;
        gap: 32px;
        padding: 32px 24px;
        max-width: 1200px;
        margin: 0 auto;
    }

    .left-section, .right-section {
        display: flex;
        flex-direction: column;
        gap: 24px;
    }

    .order-status-section, .order-items-section, .store-section, .payment-info-section {
        background-color: #fff;
        border: 1px solid #e9ecef;
        border-radius: 12px;
        padding: 24px;
    }

    .section-title {
        font-size: 18px;
        font-weight: 600;
        color: #333;
        margin-bottom: 20px;
    }

    .status-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 24px;
    }

    .order-number {
        font-size: 20px;
        font-weight: 600;
        color: #333;
    }

    .status-badge {
        padding: 8px 16px;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 600;
    }

    .status-making {
        background-color: #ffc107;
        color: #fff;
    }

    .status-complete {
        background-color: #28a745;
        color: #fff;
    }

    .status-pickup {
        background-color: #007bff;
        color: #fff;
    }

    .status-progress {
        margin-bottom: 24px;
    }

    .progress-bar {
        width: 100%;
        height: 4px;
        background-color: #e9ecef;
        border-radius: 2px;
        margin-bottom: 12px;
        overflow: hidden;
    }

    .progress-fill {
        height: 100%;
        background-color: #dc3545;
        border-radius: 2px;
        transition: width 0.3s ease;
    }

    .progress-steps {
        display: flex;
        justify-content: space-between;
    }

    .step {
        font-size: 12px;
        color: #999;
        font-weight: 500;
    }

    .step.completed, .step.active {
        color: #dc3545;
        font-weight: 600;
    }

    .order-meta {
        display: flex;
        flex-direction: column;
        gap: 12px;
    }

    .meta-row {
        display: flex;
        justify-content: space-between;
    }

    .meta-label {
        font-size: 14px;
        color: #666;
        font-weight: 500;
    }

    .meta-value {
        font-size: 14px;
        color: #333;
    }

    .order-items {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    .order-item {
        display: flex;
        align-items: center;
        gap: 16px;
        padding: 20px;
        background-color: #f8f9fa;
        border-radius: 12px;
    }

    .item-number {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 32px;
        height: 32px;
        background-color: #dc3545;
        color: #fff;
        border-radius: 50%;
        font-weight: 600;
        font-size: 14px;
    }

    .item-image {
        width: 80px;
        height: 80px;
        border-radius: 12px;
        object-fit: cover;
    }

    .item-details {
        flex: 1;
    }

    .item-name {
        font-size: 16px;
        font-weight: 600;
        color: #333;
        margin-bottom: 4px;
    }

    .item-options {
        font-size: 14px;
        color: #666;
        margin-bottom: 4px;
    }

    .item-quantity {
        font-size: 14px;
        color: #666;
    }

    .item-pricing {
        text-align: right;
    }

    .unit-price {
        font-size: 14px;
        color: #666;
        margin-bottom: 4px;
    }

    .total-price {
        font-size: 18px;
        font-weight: 600;
        color: #dc3545;
    }

    .store-info {
        margin-top: 16px;
    }

    .store-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 12px;
    }

    .store-name {
        font-size: 18px;
        font-weight: 600;
        color: #333;
    }

    .call-btn {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 8px 16px;
        background-color: #28a745;
        color: #fff;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .call-btn:hover {
        background-color: #218838;
    }

    .store-address, .store-hours {
        font-size: 14px;
        color: #666;
        margin-bottom: 4px;
    }

    .payment-details {
        display: flex;
        flex-direction: column;
        gap: 12px;
        margin-bottom: 24px;
    }

    .payment-method, .payment-date {
        display: flex;
        justify-content: space-between;
    }

    .method-label, .date-label {
        font-size: 14px;
        color: #666;
        font-weight: 500;
    }

    .method-value, .date-value {
        font-size: 14px;
        color: #333;
    }

    .payment-summary {
        margin-bottom: 24px;
    }

    .summary-row {
        display: flex;
        justify-content: space-between;
        padding: 8px 0;
        font-size: 14px;
    }

    .summary-row.total {
        font-size: 16px;
        font-weight: 600;
        color: #333;
    }

    .summary-divider {
        height: 1px;
        background-color: #e9ecef;
        margin: 16px 0;
    }

    .total-amount {
        color: #dc3545;
        font-weight: 700;
    }

    .order-actions {
        display: flex;
        gap: 12px;
    }

    .btn-secondary, .btn-primary {
        flex: 1;
        padding: 14px 20px;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s;
    }

    .btn-secondary {
        background-color: #f8f9fa;
        color: #666;
        border: 1px solid #e9ecef;
    }

    .btn-secondary:hover {
        background-color: #e9ecef;
    }

    .btn-primary {
        background-color: #dc3545;
        color: #fff;
    }

    .btn-primary:hover {
        background-color: #c82333;
    }

    /* 태블릿 반응형 */
    @media (max-width: 1024px) {
        .main-content {
            grid-template-columns: 1fr;
            gap: 24px;
            padding: 24px 16px;
        }

        .right-section {
            order: -1;
        }
    }

    /* 모바일 반응형 */
    @media (max-width: 768px) {
        .main-content {
            padding: 16px;
            gap: 16px;
        }

        .order-status-section, .order-items-section, .store-section, .payment-info-section {
            padding: 16px;
        }

        .order-item {
            padding: 16px;
            gap: 12px;
        }

        .item-image {
            width: 60px;
            height: 60px;
        }

        .order-actions {
            flex-direction: column;
        }

        .store-header {
            flex-direction: column;
            align-items: flex-start;
            gap: 8px;
        }
    }
</style>

<script>
    // 지점 전화걸기
    function callStore(phoneNumber) {
        if (confirm(`${phoneNumber}로 전화를 거시겠습니까?`)) {
            window.location.href = `tel:${phoneNumber}`;
        }
    }

    // 주문목록으로 이동
    function goToOrderList() {
        window.location.href = '/users/orders';
    }

    // 재주문
    function reorder() {
        if (confirm('동일한 상품으로 재주문하시겠습니까?')) {
            // 장바구니에 동일 상품 추가 후 결제 페이지로 이동
            window.location.href = '/checkout';
        }
    }

    // 페이지 로드 시 주문 상세 정보 로드
    document.addEventListener('DOMContentLoaded', function() {
        loadOrderDetailFromSession();
    });

    // 세션 스토리지에서 주문 상세 정보 로드
    function loadOrderDetailFromSession() {
        const orderDataStr = sessionStorage.getItem('orderData');
        if (orderDataStr) {
            const orderData = JSON.parse(orderDataStr);
            updateOrderDetail(orderData);
        } else {
            alert('주문 정보가 없습니다.');
            window.location.href = '/';
        }
    }

    // 주문 상세 정보 업데이트
    function updateOrderDetail(orderData) {
        // 주문번호 및 상태 업데이트 (checkout에서 온 데이터에는 orderNumber가 없으므로 orderId 사용)
        const orderNumber = orderData.orderNumber || `${orderData.orderId}`;
        document.querySelector('.order-number').textContent = `주문번호(${orderNumber})`;

        const statusBadge = document.querySelector('.status-badge');
        // checkout에서 온 데이터에는 productionStatus가 없으므로 기본값 설정
        const status = orderData.productionStatus || '주문접수';
        statusBadge.textContent = status;
        statusBadge.className = 'status-badge ' + getStatusClass(status);

        // 진행률 업데이트
        const progressFill = document.querySelector('.progress-fill');
        const progressWidth = getProgressWidth(status);
        progressFill.style.width = progressWidth + '%';

        // 진행 단계 업데이트
        updateProgressSteps(status);
        
        // 주문 상품 정보 업데이트
        updateOrderItems(orderData.orderItems);
        
        // 지점 정보 업데이트
        updateStoreInfo(orderData);
        
        // 결제 정보 업데이트
        updatePaymentInfo(orderData);
    }

    // 상태에 따른 CSS 클래스 반환
    function getStatusClass(status) {
        switch(status) {
            case '주문접수': return 'status-received';
            case '제조중': return 'status-making';
            case '제조완료': return 'status-complete';
            case '픽업완료': return 'status-pickup';
            default: return 'status-making';
        }
    }

    // 상태에 따른 진행률 반환
    function getProgressWidth(status) {
        switch(status) {
            case '주문접수': return 25;
            case '제조중': return 50;
            case '제조완료': return 75;
            case '픽업완료': return 100;
            default: return 25;
        }
    }

    // 진행 단계 업데이트
    function updateProgressSteps(status) {
        const steps = document.querySelectorAll('.step');
        const statusOrder = ['주문접수', '제조중', '제조완료', '픽업완료'];
        const currentIndex = statusOrder.indexOf(status);

        steps.forEach((step, index) => {
            step.classList.remove('completed', 'active');
            if (index < currentIndex) {
                step.classList.add('completed');
            } else if (index === currentIndex) {
                step.classList.add('active');
            }
        });
    }
    
    // 주문 상품 정보 업데이트
    function updateOrderItems(orderItems) {
        const container = document.querySelector('.order-items-list');
        if (!container) return;
        
        container.innerHTML = '';
        orderItems.forEach(item => {
            const itemHtml = `
                <div class="order-item">
                    <img src="${item.image}" alt="${item.name}" class="item-image">
                    <div class="item-details">
                        <div class="item-name">${item.name}</div>
                        <div class="item-price">${item.price.toLocaleString()}원</div>
                        <div class="item-quantity">수량: ${item.quantity}개</div>
                    </div>
                    <div class="item-total">${item.total.toLocaleString()}원</div>
                </div>
            `;
            container.insertAdjacentHTML('beforeend', itemHtml);
        });
    }
    
    // 지점 정보 업데이트
    function updateStoreInfo(orderData) {
        const storeNameEl = document.querySelector('.store-name');
        const orderTypeEl = document.querySelector('.order-type');
        const pickupMethodEl = document.querySelector('.pickup-method');
        const pickupTimeEl = document.querySelector('.pickup-time');
        const requestNoteEl = document.querySelector('.request-note');
        
        if (storeNameEl) storeNameEl.textContent = orderData.storeName;
        if (orderTypeEl) orderTypeEl.textContent = orderData.orderType;
        if (pickupMethodEl) pickupMethodEl.textContent = orderData.pickupMethod;
        if (pickupTimeEl && orderData.pickupTime) {
            const pickupTime = new Date(orderData.pickupTime);
            pickupTimeEl.textContent = pickupTime.toLocaleString();
        }
        if (requestNoteEl) requestNoteEl.textContent = orderData.requestNote || '요청사항 없음';
    }
    
    // 결제 정보 업데이트
    function updatePaymentInfo(orderData) {
        const paymentMethodEl = document.querySelector('.payment-method');
        const orderAmountEl = document.querySelector('.order-amount');
        const discountAmountEl = document.querySelector('.discount-amount');
        const totalAmountEl = document.querySelector('.total-amount');
        
        if (paymentMethodEl) paymentMethodEl.textContent = orderData.paymentMethod;
        if (orderAmountEl) orderAmountEl.textContent = orderData.orderAmount.toLocaleString() + '원';
        if (discountAmountEl) {
            if (orderData.discountAmount > 0) {
                discountAmountEl.textContent = '-' + orderData.discountAmount.toLocaleString() + '원';
                discountAmountEl.parentElement.style.display = 'flex';
            } else {
                discountAmountEl.parentElement.style.display = 'none';
            }
        }
        if (totalAmountEl) totalAmountEl.textContent = orderData.totalAmount.toLocaleString() + '원';
    }
</script>
</body>
</html>