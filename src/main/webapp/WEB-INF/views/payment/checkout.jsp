<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<body>
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="hero checkout-page">
    <div class="container">
        <!-- 페이지 헤더 -->
        <div class="page-header">
            <button class="back-btn" onclick="history.back()">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                    <path d="M15 18L9 12L15 6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </button>
            <h1 class="page-title">결제하기</h1>
        </div>

        <!-- 메인 컨텐츠 -->
        <div class="checkout-content">
        <!-- 좌측: 주문 정보 -->
        <div class="left-section">
            <!-- 주문내역 -->
            <div class="order-section">
                <div class="section-header">
                    <h2 class="section-title">주문내역 
                        <c:if test="${not empty cartData and not empty cartData.items}">
                            (<span id="itemCount">${cartData.items.size()}</span>개)
                        </c:if>
                        <c:if test="${empty cartData or empty cartData.items}">
                            (0개)
                        </c:if>
                    </h2>
                    <button class="collapse-btn" id="collapseBtn">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                            <path d="M18 15L12 9L6 15" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </button>
                </div>

                <div class="order-items" id="orderItems">
                    <!-- 에러 메시지 표시 -->
                    <c:if test="${not empty error}">
                        <div class="error-message" style="background: #f8d7da; color: #721c24; padding: 12px 16px; border-radius: 8px; margin-bottom: 16px;">
                             ${error}
                        </div>
                    </c:if>
                    
                    <!-- 카트 데이터가 있는 경우 -->
                    <c:if test="${not empty cartData and not empty cartData.items}">
                        <c:forEach var="item" items="${cartData.items}" varStatus="status">
                            <div class="order-item">
                                <img src="${not empty item.productPhoto ? item.productPhoto : ''}"
                                     alt="${item.productName}" class="item-image">
                                <div class="item-details">
                                    <div class="item-name">${item.productName}</div>
                                    <div class="item-price">
                                        <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₩"/>
                                    </div>
                                    <div class="item-quantity">총 ${item.quantity}개</div>
                                    <!-- 옵션 표시 -->
                                    <c:if test="${not empty item.options}">
                                        <div class="item-options" style="font-size: 12px; color: #666; margin-top: 4px;">
                                            <c:forEach var="option" items="${item.options}" varStatus="optStatus">
                                                ${option.optionName}<c:if test="${!optStatus.last}">, </c:if>
                                            </c:forEach>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="item-total">
                                    <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₩"/>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    
                    <!-- 카트가 비어있는 경우 -->
                    <c:if test="${empty cartData or empty cartData.items}">
                        <div class="empty-cart" style="text-align: center; padding: 40px; color: var(--text-2);">
                            <h3>🛒 장바구니가 비어있습니다</h3>
                            <p>상품을 담고 결제를 진행해주세요.</p>
                            <a href="/branch/list" class="btn btn-primary" style="margin-top: 16px;">상품 보러가기</a>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- 매장 정보 -->
            <div class="store-section">
                <h2 class="section-title">
                    <c:if test="${not empty branch}">
                        ${branch.branchName}
                    </c:if>
                    <c:if test="${empty branch}">
                        매장 정보 없음
                    </c:if>
                </h2>
                <div class="store-info">
                    <div class="info-item">
                        <span class="info-label">요청사항</span>
                        <textarea class="request-input" id="requestNote" placeholder="요청사항을 입력해주세요" rows="2"></textarea>
                    </div>
                    <div class="info-item">
                        <span class="info-label">픽업 방법</span>
                        <div class="order-type-options">
                            <label class="order-type-option">
                                <input type="radio" name="orderType" value="takeout" checked>
                                <span>테이크아웃</span>
                            </label>
                            <label class="order-type-option">
                                <input type="radio" name="orderType" value="store">
                                <span>매장</span>
                            </label>
                        </div>
                    </div>
                    <div class="info-item">
                        <span class="info-label">포장방법</span>
                        <div class="package-options">
                            <label class="package-option">
                                <input type="radio" name="package" value="none" checked>
                                <span>포장안함</span>
                            </label>
                            <label class="package-option">
                                <input type="radio" name="package" value="carrier">
                                <span>전체포장(케리어)</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 픽업 예정시간 -->
            <div class="pickup-section">
                <h2 class="section-title">픽업 예정시간</h2>
                <div class="pickup-time">
                    <div class="time-options">
                        <label class="time-option">
                            <input type="radio" name="pickupTime" value="5" checked>
                            <span>5분 후</span>
                        </label>
                        <label class="time-option">
                            <input type="radio" name="pickupTime" value="10">
                            <span>10분 후</span>
                        </label>
                        <label class="time-option">
                            <input type="radio" name="pickupTime" value="15">
                            <span>15분 후</span>
                        </label>
                        <label class="time-option">
                            <input type="radio" name="pickupTime" value="20">
                            <span>20분 후</span>
                        </label>
                    </div>
                </div>
            </div>

            <!-- 결제수단 -->
            <div class="payment-section">
                <h2 class="section-title">결제수단</h2>
                <div class="payment-methods">
                    <label class="payment-method selected">
                        <input type="radio" name="payment" value="card" checked>
                        <div class="method-content">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <rect x="2" y="6" width="20" height="12" rx="2" stroke="currentColor" stroke-width="2"/>
                                <path d="M2 10H22" stroke="currentColor" stroke-width="2"/>
                            </svg>
                            <span>신용카드</span>
                        </div>
                    </label>
                </div>
            </div>

            <!-- 할인 및 혜택 -->
            <div class="discount-section">
                <h2 class="section-title">할인 및 혜택</h2>
                <div class="discount-options">
                    <label class="coupon-option">
                        <input type="checkbox" id="useCoupon" name="useCoupon">
                        <div class="coupon-content">
                            <div class="coupon-info">
                                <div class="coupon-icon">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                        <path d="M21 12C21 16.418 16.418 21 12 21C7.582 21 3 16.418 3 12C3 7.582 7.582 3 12 3C16.418 3 21 7.582 21 12Z" stroke="currentColor" stroke-width="2"/>
                                        <path d="M9 12L11 14L15 10" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                </div>
                                <div class="coupon-details">
                                    <span class="coupon-name">할인 쿠폰 사용</span>
                                    <span class="coupon-discount">2,000원 할인</span>
                                </div>
                            </div>
                            <div class="coupon-checkbox">
                                <div class="checkbox-custom"></div>
                            </div>
                        </div>
                    </label>
                </div>
            </div>
        </div>

        <!-- 우측: 결제 정보 -->
        <div class="right-section">
            <!-- 결제 요약 -->
            <div class="payment-summary">
                <h2 class="section-title">결제정보</h2>
                <div class="summary-content">
                    <div class="summary-row">
                        <span>주문 금액</span>
                        <span id="orderAmount">
                            <c:if test="${not empty totalAmount}">
                                <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₩"/>
                            </c:if>
                            <c:if test="${empty totalAmount}">
                                0원
                            </c:if>
                        </span>
                    </div>
                    <div class="summary-row">
                        <span>총 수량</span>
                        <span>
                            <c:if test="${not empty totalQuantity}">
                                ${totalQuantity}개
                            </c:if>
                            <c:if test="${empty totalQuantity}">
                                0개
                            </c:if>
                        </span>
                    </div>
                    <div class="summary-row coupon-discount" id="couponRow" style="display: none;">
                        <span>쿠폰 할인</span>
                        <span class="discount-amount">-2,000원</span>
                    </div>
                    <div class="summary-divider"></div>
                    <div class="summary-row total">
                        <span>총 결제금액</span>
                        <span class="total-amount" id="totalAmount">
                            <c:if test="${not empty totalAmount}">
                                <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₩"/>
                            </c:if>
                            <c:if test="${empty totalAmount}">
                                0원
                            </c:if>
                        </span>
                    </div>
                </div>

                <!-- 결제 버튼 -->
                <div class="payment-actions">
                    <button class="btn-cancel" onclick="history.back()">취소</button>
                    <button class="btn-payment" id="paymentBtn" onclick="processPayment()">
                        <c:if test="${not empty totalAmount}">
                            <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₩"/> 결제하기
                        </c:if>
                        <c:if test="${empty totalAmount}">
                            0원 결제하기
                        </c:if>
                    </button>
                </div>
            </div>
        </div>
    </div>
    </div>
</main>

<style>
    /* Checkout Page Specific Styles */
    .checkout-page {
        padding-top: 40px;
        padding-bottom: 40px;
    }

    .page-header {
        display: flex;
        align-items: center;
        margin-bottom: 32px;
        gap: 16px;
    }

    .back-btn {
        background: var(--white);
        border: 1px solid rgba(0,0,0,0.08);
        color: var(--text-2);
        cursor: pointer;
        padding: 12px;
        border-radius: 12px;
        transition: all 0.2s;
        box-shadow: var(--shadow);
    }

    .back-btn:hover {
        background-color: var(--pink-4);
        border-color: var(--pink-2);
        color: var(--pink-1);
    }

    .page-title {
        font-size: 32px;
        font-weight: 800;
        color: var(--text-1);
        margin: 0;
    }

    .checkout-content {
        display: grid;
        grid-template-columns: 1fr 400px;
        gap: 32px;
    }

    .left-section, .right-section {
        display: flex;
        flex-direction: column;
        gap: 24px;
    }

    .order-section, .store-section, .pickup-section, .payment-section, .discount-section, .payment-summary {
        background: var(--white);
        border-radius: 18px;
        padding: 24px;
        box-shadow: var(--shadow);
        border: 1px solid rgba(0,0,0,0.05);
    }

    .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .section-title {
        font-size: 20px;
        font-weight: 700;
        color: var(--text-1);
        margin-bottom: 16px;
    }

    .collapse-btn {
        background: none;
        border: none;
        color: #666;
        cursor: pointer;
        padding: 4px;
        transition: transform 0.2s;
    }

    .collapse-btn.collapsed {
        transform: rotate(180deg);
    }

    .order-items {
        display: flex;
        flex-direction: column;
        gap: 16px;
    }

    .order-items.collapsed {
        display: none;
    }

    .order-item {
        display: flex;
        align-items: center;
        gap: 16px;
        padding: 20px;
        background: linear-gradient(135deg, var(--pink-4), rgba(255,255,255,0.8));
        border-radius: 14px;
        border: 1px solid rgba(255,122,162,0.1);
    }

    .item-image {
        width: 80px;
        height: 80px;
        border-radius: 8px;
        object-fit: cover;
    }

    .item-details {
        flex: 1;
    }

    .item-name {
        font-size: 16px;
        font-weight: 500;
        color: #333;
        margin-bottom: 4px;
    }

    .item-price {
        font-size: 14px;
        color: var(--pink-1);
        font-weight: 600;
        margin-bottom: 4px;
    }

    .item-quantity {
        font-size: 14px;
        color: #666;
    }

    .item-total {
        font-size: 18px;
        font-weight: 700;
        color: var(--pink-1);
    }

    .store-info {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    .info-item {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .info-label {
        font-size: 14px;
        font-weight: 500;
        color: #333;
    }

    .request-input {
        padding: 12px;
        border: 1px solid #e9ecef;
        border-radius: 6px;
        font-size: 14px;
        font-family: inherit;
        resize: vertical;
        min-height: 60px;
    }

    .request-input:focus {
        outline: none;
        border-color: #dc3545;
    }

    .order-type-options, .package-options {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 12px;
    }
    
    .time-options {
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
    }

    .order-type-option, .package-option, .time-option {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 12px 16px;
        border: 1px solid #e9ecef;
        border-radius: 6px;
        cursor: pointer;
        transition: all 0.2s;
        min-width: 100px;
        justify-content: center;
    }

    .order-type-option:has(input:checked),
    .package-option:has(input:checked),
    .time-option:has(input:checked) {
        border-color: var(--pink-1);
        background: linear-gradient(135deg, var(--pink-4), var(--white));
    }

    .order-type-option input,
    .package-option input,
    .time-option input {
        display: none;
    }

    .time-options {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 12px;
    }

    .payment-methods {
        display: flex;
        flex-direction: column;
        gap: 12px;
    }

    .payment-method {
        display: flex;
        align-items: center;
        padding: 16px;
        border: 1px solid #e9ecef;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.2s;
    }

    .payment-method.selected {
        border-color: var(--pink-1);
        background: linear-gradient(135deg, var(--pink-4), var(--white));
    }

    .payment-method input {
        display: none;
    }

    .method-content {
        display: flex;
        align-items: center;
        gap: 12px;
        color: #333;
    }

    /* 할인 섹션 스타일 */
    .discount-options {
        display: flex;
        flex-direction: column;
        gap: 12px;
    }

    .coupon-option {
        display: flex;
        align-items: center;
        padding: 16px;
        border: 1px solid #e9ecef;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.2s;
        background: var(--white);
    }

    .coupon-option:hover {
        border-color: var(--pink-2);
        background: linear-gradient(135deg, var(--pink-4), var(--white));
    }

    .coupon-option:has(input:checked) {
        border-color: var(--pink-1);
        background: linear-gradient(135deg, var(--pink-4), var(--white));
    }

    .coupon-option input {
        display: none;
    }

    .coupon-content {
        display: flex;
        align-items: center;
        justify-content: space-between;
        width: 100%;
    }

    .coupon-info {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .coupon-icon {
        color: var(--pink-1);
    }

    .coupon-details {
        display: flex;
        flex-direction: column;
        gap: 2px;
    }

    .coupon-name {
        font-size: 14px;
        font-weight: 500;
        color: #333;
    }

    .coupon-discount {
        font-size: 13px;
        color: #28a745;
        font-weight: 600;
    }

    .coupon-checkbox {
        position: relative;
    }

    .checkbox-custom {
        width: 20px;
        height: 20px;
        border: 2px solid #ddd;
        border-radius: 4px;
        position: relative;
        transition: all 0.2s;
    }

    .coupon-option:has(input:checked) .checkbox-custom {
        background-color: var(--pink-1);
        border-color: var(--pink-1);
    }

    .coupon-option:has(input:checked) .checkbox-custom::after {
        content: '✓';
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        color: white;
        font-size: 12px;
        font-weight: bold;
    }

    .summary-content {
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
        color: var(--pink-1);
        font-weight: 800;
    }

    .discount-amount {
        color: #28a745;
        font-weight: 600;
    }

    .coupon-discount {
        color: #28a745;
    }

    .payment-actions {
        display: flex;
        gap: 12px;
    }

    .btn-cancel, .btn-payment {
        padding: 14px 24px;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s;
    }

    .btn-cancel {
        flex: 1;
        background-color: #f8f9fa;
        color: #666;
    }

    .btn-cancel:hover {
        background-color: #e9ecef;
    }

    .btn-payment {
        flex: 3;
        background: linear-gradient(135deg, var(--pink-1), var(--pink-2));
        color: var(--white);
        box-shadow: 0 8px 16px rgba(255, 122, 162, 0.35);
    }

    .btn-payment:hover {
        filter: brightness(1.02);
        transform: translateY(-1px);
    }

    .btn-payment:disabled {
        background-color: #6c757d;
        cursor: not-allowed;
    }

    /* 태블릿 반응형 */
    @media (max-width: 1024px) {
        .checkout-content {
            grid-template-columns: 1fr;
            gap: 24px;
            padding: 24px 16px;
        }

        .right-section {
            position: sticky;
            bottom: 0;
            background-color: #fff;
            border-top: 1px solid #e9ecef;
            padding-top: 16px;
            margin: 0 -16px -24px;
            padding-left: 16px;
            padding-right: 16px;
        }
    }

    /* 모바일 반응형 */
    @media (max-width: 768px) {
        .main-content {
            padding: 16px;
            gap: 16px;
        }

        .order-section, .store-section, .pickup-section, .payment-section, .discount-section, .payment-summary {
            padding: 16px;
        }

        .order-item {
            padding: 12px;
            gap: 12px;
        }

        .item-image {
            width: 60px;
            height: 60px;
        }

        .package-options {
            flex-direction: column;
        }

        .payment-actions {
            flex-direction: column;
        }
    }
</style>

<script>
    // 주문내역 접기/펼치기
    document.getElementById('collapseBtn').addEventListener('click', function() {
        const orderItems = document.getElementById('orderItems');
        const btn = this;

        if (orderItems.classList.contains('collapsed')) {
            orderItems.classList.remove('collapsed');
            btn.classList.remove('collapsed');
        } else {
            orderItems.classList.add('collapsed');
            btn.classList.add('collapsed');
        }
    });

    // 결제수단 선택
    document.querySelectorAll('.payment-method').forEach(method => {
        method.addEventListener('click', function() {
            document.querySelectorAll('.payment-method').forEach(m => m.classList.remove('selected'));
            this.classList.add('selected');
            this.querySelector('input').checked = true;
        });
    });



    // 쿠폰 체크박스 직접 클릭 시 이벤트 버블링 방지
    document.querySelector('#useCoupon').addEventListener('click', function(e) {
        e.stopPropagation();
        updatePaymentSummary();
    });

    // 결제 요약 업데이트
    function updatePaymentSummary() {
        const useCouponCheckbox = document.getElementById('useCoupon');
        const couponRow = document.getElementById('couponRow');
        const totalAmount = document.getElementById('totalAmount');
        const paymentBtn = document.getElementById('paymentBtn');
        
        // 원래 금액을 JSP에서 가져오거나 기본값 사용
        const originalAmount = ${totalAmount != null ? totalAmount : 8300};
        const discountAmount = 2000;
        
        if (useCouponCheckbox && useCouponCheckbox.checked) {
            // 쿠폰 사용 시
            couponRow.style.display = 'flex';
            const finalAmount = originalAmount - discountAmount;
            totalAmount.textContent = finalAmount.toLocaleString() + '원';
            paymentBtn.textContent = finalAmount.toLocaleString() + '원 결제하기';
        } else {
            // 쿠폰 사용 안함
            couponRow.style.display = 'none';
            totalAmount.textContent = originalAmount.toLocaleString() + '원';
            paymentBtn.textContent = originalAmount.toLocaleString() + '원 결제하기';
        }
    }

    // 현재 로그인한 사용자 ID 저장 변수
    let currentMemberId = null;

    // 현재 로그인 사용자 정보 조회
    async function fetchCurrentUser() {
        try {
            const res = await fetch('/api/users/me', { credentials: 'same-origin' });
            if (!res.ok) return null;
            const data = await res.json();
            if (data && data.memberId) {
                currentMemberId = data.memberId;
                return currentMemberId;
            }
            return null;
        } catch (e) {
            console.log('사용자 정보 조회 실패:', e);
            return null;
        }
    }

    document.addEventListener('DOMContentLoaded', () => {
        // 페이지 로드 시 사용자 정보 미리 조회
        fetchCurrentUser();
    });

    // 결제 처리
    async function processPayment() {
        // 사용자 정보가 없으면 한번 더 시도
        if (!currentMemberId) {
            await fetchCurrentUser();
        }
        if (!currentMemberId) {
            alert('로그인이 필요합니다. 로그인 후 다시 시도해주세요.');
            try { window.location.href = '/login'; } catch (e) {}
            return;
        }
        const selectedPayment = document.querySelector('input[name="payment"]:checked');
        const selectedOrderType = document.querySelector('input[name="orderType"]:checked');
        const selectedPackage = document.querySelector('input[name="package"]:checked');
        const selectedPickupTime = document.querySelector('input[name="pickupTime"]:checked');
        const useCouponCheckbox = document.getElementById('useCoupon');
        const requestNote = document.getElementById('requestNote').value;

        if (!selectedPayment) {
            alert('결제수단을 선택해주세요.');
            return;
        }

        // 현재 시간에 선택된 분 추가
        const now = new Date();
        const pickupTime = new Date(now.getTime() + (parseInt(selectedPickupTime.value) * 60 * 1000));

        // 쿠폰 사용 여부에 따른 최종 금액 계산
        const originalAmount = ${totalAmount != null ? totalAmount : 0};
        const discountAmount = useCouponCheckbox && useCouponCheckbox.checked ? 2000 : 0;
        const finalAmount = originalAmount - discountAmount;

        // 장바구니 아이템을 주문 아이템으로 변환
        const orderItems = [];
        <c:if test="${not empty cartData and not empty cartData.items}">
            <c:forEach var="item" items="${cartData.items}">
                orderItems.push({
                    productId: ${item.productId},
                    quantity: ${item.quantity},
                    price: Math.round(${item.price} / ${item.quantity})
                });
            </c:forEach>
        </c:if>

        const paymentData = {
            memberId: currentMemberId,
            branchId: ${not empty branch ? branch.id : 1},
            isTakeout: selectedOrderType.value === 'takeout',
            pickupTime: pickupTime.toISOString(),
            requestNote: requestNote,
            pickupMethod: selectedPackage.value === 'carrier' ? '전체포장(케리어)' : '포장안함',
            isFromCart: true, // 장바구니에서 온 결제임을 명시
            useCoupon: useCouponCheckbox ? useCouponCheckbox.checked : false,
            discountAmount: discountAmount,
            finalAmount: finalAmount,
            orderItems: orderItems
        };

        const payButton = document.querySelector('.btn-payment');
        payButton.textContent = '결제 처리 중...';
        payButton.disabled = true;

        fetch('/payments/checkout', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(paymentData)
        })
            .then(response => response.json())
            .then(data => {
                if (data.orderId) {
                    alert('결제가 완료되었습니다!');
                    
                    // 현재 페이지의 정보 수집
                    const selectedOrderType = document.querySelector('input[name="orderType"]:checked');
                    const selectedPackage = document.querySelector('input[name="package"]:checked');
                    const selectedPayment = document.querySelector('input[name="payment"]:checked');
                    const requestNote = document.getElementById('requestNote').value;
                    // 선택된 분 수를 기반으로 픽업 예정 시각(ISO) 계산
                    const pickupTimeIso = (() => {
                        try {
                            const rt = document.querySelector('input[name="pickupTime"]:checked');
                            const mins = parseInt(rt ? rt.value : '5', 10);
                            const now2 = new Date();
                            return new Date(now2.getTime() + (mins * 60 * 1000)).toISOString();
                        } catch (e) { return null; }
                    })();
                    
                    // 카트 아이템 정보 수집 (JSP에서 렌더링된 데이터 활용)
                    const orderItems = [];
                    <c:if test="${not empty cartData and not empty cartData.items}">
                        <c:forEach var="item" items="${cartData.items}">
                            orderItems.push({
                                name: '${item.productName}',
                                image: '${item.productPhoto}',
                                price: Math.round(${item.price} / ${item.quantity}),
                                quantity: ${item.quantity},
                                total: ${item.price}
                            });
                        </c:forEach>
                    </c:if>
                    
                    // 주문 데이터를 세션스토리지에 저장
                    const orderData = {
                        orderId: data.orderId,
                        orderItems: orderItems,
                        orderType: selectedOrderType ? (selectedOrderType.value === 'takeout' ? '테이크아웃' : '매장') : '테이크아웃',
                        pickupMethod: selectedPackage ? (selectedPackage.value === 'carrier' ? '전체포장(케리어)' : '포장안함') : '포장안함',
                        pickupTime: pickupTimeIso || '',
                        requestNote: requestNote || '',
                        paymentMethod: '신용카드',
                        useCoupon: useCouponCheckbox ? useCouponCheckbox.checked : false,
                        totalAmount: finalAmount,
                        orderAmount: originalAmount,
                        discountAmount: discountAmount,
                        storeName: '${not empty branch ? branch.branchName : "매장 정보 없음"}'
                    };
                    
                    sessionStorage.setItem('orderData', JSON.stringify(orderData));
                    window.location.href = '/orders/' + data.orderId;
                } else {
                    throw new Error('결제 응답 오류');
                }
            })
            .catch(error => {
                console.error('결제 오류:', error);
                alert('결제 중 오류가 발생했습니다. 다시 시도해주세요.');
                
                // 쿠폰 사용 여부에 따라 버튼 텍스트 복원
                const isUsingCoupon = useCouponCheckbox && useCouponCheckbox.checked;
                const amount = isUsingCoupon ? (originalAmount - 2000) : originalAmount;
                payButton.textContent = amount.toLocaleString() + '원 결제하기';
                payButton.disabled = false;
            });
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
