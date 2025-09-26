<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<body>
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<main class="hero order-detail-page">
    <div class="container">
        <!-- 페이지 헤더 -->
        <div class="page-header">
            <button class="back-btn" onclick="history.back()">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                    <path d="M15 18L9 12L15 6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </button>
            <h1 class="page-title">주문상세조회</h1>
        </div>

        <!-- 메인 컨텐츠 -->
        <div class="order-detail-content">
        <!-- 선택된 매장 정보 전달용 (checkout과 동일 패턴) -->
        <input type="hidden" id="selectedBranchIdInput" value="${branchId != null ? branchId : ''}" />
        <input type="hidden" id="selectedBranchNameInput" value="${branchName != null ? branchName : ''}" />
        <!-- 좌측: 주문 정보 -->
        <div class="left-section">
            <!-- 주문 상태 -->
            <div class="order-status-section">
                <div class="status-header">
                    <div class="order-number">주문번호(로딩 중)</div>
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
                        <span class="meta-value order-date-value">-</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">픽업예정</span>
                        <span class="meta-value pickup-time-value">-</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">주문형태</span>
                        <span class="meta-value order-type-value">-</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">포장방법</span>
                        <span class="meta-value pickup-method-value">-</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">요청사항</span>
                        <span class="meta-value request-note-value">-</span>
                    </div>
                </div>
            </div>

            <!-- 주문 상품 목록 -->
            <div class="order-items-section">
                <h2 class="section-title">주문상품</h2>

                <div class="order-items"></div>
            </div>

            <!-- 지점 정보 -->
            <div class="store-section">
                <h2 class="section-title">픽업 매장</h2>
                <span id="checkoutStoreName">
                        <c:choose>
                            <c:when test="${not empty branch}">${branch.branchName}</c:when>
                            <c:when test="${not empty branchName}">${branchName}</c:when>
                            <c:otherwise>매장 정보 없음</c:otherwise>
                        </c:choose>
                    </span>
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
                        <span class="method-value">-</span>
                    </div>
                    <div class="payment-date">
                        <span class="date-label">결제일시</span>
                        <span class="date-value">-</span>
                    </div>
                </div>

                <div class="payment-summary">
                    <div class="summary-row">
                        <span>주문금액</span>
                        <span class="order-amount">0원</span>
                    </div>
                    <div class="summary-row">
                        <span>총 수량</span>
                        <span class="total-qty">0개</span>
                    </div>
                    <div class="summary-divider"></div>
                    <div class="summary-row total">
                        <span>총 결제금액</span>
                        <span class="total-amount">0원</span>
                    </div>
                </div>
            </div>

            <!-- 주문 액션 -->
            <div class="order-actions">
                <button class="btn-secondary" onclick="goToOrderList()">주문목록</button>
            </div>
        </div>
    </div>
    </div>
</main>

<style>
    /* Order Detail Page Specific Styles */
    .order-detail-page {
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

    .order-detail-content {
        display: grid;
        grid-template-columns: 1fr 400px;
        gap: 32px;
    }

    .left-section, .right-section {
        display: flex;
        flex-direction: column;
        gap: 24px;
    }

    .order-status-section, .order-items-section, .store-section, .payment-info-section {
        background: var(--white);
        border-radius: 18px;
        padding: 24px;
        box-shadow: var(--shadow);
        border: 1px solid rgba(0,0,0,0.05);
    }

    .section-title {
        font-size: 20px;
        font-weight: 700;
        color: var(--text-1);
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
        background: linear-gradient(135deg, #ffc107, #ffb700);
        color: var(--white);
    }

    .status-complete {
        background: linear-gradient(135deg, #28a745, #20c997);
        color: var(--white);
    }

    .status-pickup {
        background: linear-gradient(135deg, var(--pink-1), var(--pink-2));
        color: var(--white);
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
        background: linear-gradient(135deg, var(--pink-1), var(--pink-2));
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
        color: var(--pink-1);
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
        background: linear-gradient(135deg, var(--pink-4), rgba(255,255,255,0.8));
        border-radius: 14px;
        border: 1px solid rgba(255,122,162,0.1);
    }

    .item-number {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 32px;
        height: 32px;
        background: linear-gradient(135deg, var(--pink-1), var(--pink-2));
        color: var(--white);
        border-radius: 50%;
        font-weight: 600;
        font-size: 14px;
        box-shadow: 0 4px 8px rgba(255,122,162,0.3);
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
        font-weight: 700;
        color: var(--pink-1);
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
        padding: 10px 16px;
        background: linear-gradient(135deg, #28a745, #20c997);
        color: var(--white);
        border: none;
        border-radius: 12px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s;
        box-shadow: 0 4px 8px rgba(40,167,69,0.3);
    }

    .call-btn:hover {
        transform: translateY(-1px);
        box-shadow: 0 6px 12px rgba(40,167,69,0.4);
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
        color: var(--pink-1);
        font-weight: 800;
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
        background-color: #F8F9FAFF;
        color: #666;
        border: 1px solid #e9ecef;
    }

    .btn-secondary:hover {
        background-color: #e9ecef;
    }

    .btn-primary {
        background: linear-gradient(135deg, var(--pink-1), var(--pink-2));
        color: var(--white);
        box-shadow: 0 8px 16px rgba(255, 122, 162, 0.35);
    }

    .btn-primary:hover {
        filter: brightness(1.02);
        transform: translateY(-1px);
    }

    .btn-sm {
        background-color: #ff8db1;
        color: #ffffff;
        padding: 6px 15px;
        border-radius: 8px;
        font-size: 15px;
        margin-top: 8px;
        margin-left: 5px;
    }

    /* 태블릿 반응형 */
    @media (max-width: 1024px) {
        .order-detail-content {
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

    /* 옵션 배지 스타일 (cart.jsp와 동일) */
    .order-option-list { 
        display: flex; 
        flex-wrap: wrap; 
        gap: 8px; 
        list-style: none; 
        margin: 4px 0 0 0; 
        padding: 0; 
    }
    .order-option-list li { 
        background: rgba(255,122,162,0.12); 
        padding: 6px 12px; 
        border-radius: 999px; 
        font-size: 13px; 
        color: var(--text-1);
    }
    .order-option-list em { 
        margin-left: 6px; 
        color: var(--pink-1); 
        font-style: normal; 
        font-weight: 600; 
    }
</style>

<script>
    // 주문목록으로 이동
    function goToOrderList() {
        window.location.href = '/orders';
    }

    // 로컬 저장된 선택 매장 이름 보조 함수
    function getSelectedBranchName() {
        try {
            var sel = (window.branchSelection && typeof window.branchSelection.load === 'function') ? window.branchSelection.load() : null;
            return (sel && sel.name) ? sel.name : '';
        } catch (e) { return ''; }
    }
    function setStoreNameIfEmpty(name) {
        var el = document.querySelector('.store-name');
        var target = name && String(name).trim() ? String(name).trim() : '';
        if (!el) return false;
        if (!el.textContent || el.textContent === '-') {
            if (target) { el.textContent = target; return true; }
        }
        return false;
    }

    function setStoreInfoFallbackFromLocal() {
        try {
            var sel = (window.branchSelection && typeof window.branchSelection.load === 'function') ? window.branchSelection.load() : null;
            if (!sel) return;
            var nameSet = setStoreNameIfEmpty(sel.name);
            var addrEl = document.querySelector('.store-address');
            if (addrEl && (!addrEl.textContent || addrEl.textContent === '-')) {
                if (sel.address) addrEl.textContent = sel.address;
            }
        } catch (e) { /* noop */ }
    }

    // 페이지 로드 시: 먼저 로컬 선택 매장 표시 후 상세 정보 로드
    document.addEventListener('DOMContentLoaded', function() {
        hydrateStoreNameFromHiddenOrLocal();
        loadOrderDetailFromSessionOrFetch();
    });

    // checkout.jsp와 동일 패턴의 매장명 하이드레이션
    function hydrateStoreNameFromHiddenOrLocal() {
        var idInput = document.getElementById('selectedBranchIdInput');
        var nameInput = document.getElementById('selectedBranchNameInput');
        var storeNameEl = document.querySelector('.store-name');

        function setName(name) {
            var display = name && String(name).trim() ? String(name).trim() : '';
            if (storeNameEl && (!storeNameEl.textContent || storeNameEl.textContent === '-' || storeNameEl.textContent === '매장 정보 없음')) {
                storeNameEl.textContent = display || '매장 정보 없음';
            }
            if (nameInput) nameInput.value = display;
        }

        var id = idInput && idInput.value ? String(idInput.value).trim() : '';
        var nm = nameInput && nameInput.value ? String(nameInput.value).trim() : '';
        if (nm) { setName(nm); return; }
        if (id) {
            setName('매장 정보를 불러오는 중...');
            fetch('/branch/info/' + encodeURIComponent(id))
                .then(function(r){ if(!r.ok) throw 0; return r.json(); })
                .then(function(d){ setName(d && (d.name || d.branchName) ? (d.name || d.branchName) : ('ID ' + id)); })
                .catch(function(){ setName('매장 정보를 불러오지 못했습니다'); });
            return;
        }
        try {
            var sel = (window.branchSelection && typeof window.branchSelection.load === 'function') ? window.branchSelection.load() : null;
            setName(sel && sel.name ? sel.name : '');
        } catch (e) { setName(''); }
    }

    // 주문 상세 정보는 서버에서만 조회하여 렌더 (세션스토리지 의존 제거)
    function loadOrderDetailFromSessionOrFetch() {
        const path = window.location.pathname;
        const m = path.match(/\/orders\/(\d+)/);
        if (!m) {
            alert('주문 정보를 찾을 수 없습니다.');
            window.location.href = '/orders';
            return;
        }
        const orderId = m[1];

        // 서버에서 상세 조회하여 정확한 매장/결제 정보로 렌더
        fetch(`/users/orders/${orderId}`)
            .then(res => {
                if (!res.ok) throw new Error('주문 정보를 불러오지 못했습니다');
                return res.json();
            })
            .then(data => updateOrderDetailFromApi(data))
            .catch(err => {
                console.error(err);
                alert('주문 정보를 불러오지 못했습니다.');
            });
    }

    // 주문 상세 정보 업데이트 (API 응답 구조 사용)
    function updateOrderDetailFromApi(data) {
        const orderNumber = data.orderNumber || String(data.orderId || '');
        document.querySelector('.order-number').textContent = '주문번호(' + orderNumber + ')';

        const status = '픽업완료';
        const statusBadge = document.querySelector('.status-badge');
        statusBadge.textContent = status;
        statusBadge.className = 'status-badge ' + getStatusClass(status);

        const progressFill = document.querySelector('.progress-fill');
        progressFill.style.width = getProgressWidth(status) + '%';
        updateProgressSteps(status);

        // 주문 메타 정보
        const fmt = d => d ? new Date(d).toLocaleString() : '-';
        const orderDateEl = document.querySelector('.order-date-value');
        const pickupTimeEl = document.querySelector('.pickup-time-value');
        const orderTypeEl = document.querySelector('.order-type-value');
        const pickupMethodEl = document.querySelector('.pickup-method-value');
        const requestNoteEl = document.querySelector('.request-note-value');
        if (orderDateEl) orderDateEl.textContent = fmt(data.orderDate);
        if (pickupTimeEl) pickupTimeEl.textContent = fmt(data.pickupTime);
        if (orderTypeEl) orderTypeEl.textContent = data.isTakeout ? '테이크아웃' : '매장';
        if (pickupMethodEl) pickupMethodEl.textContent = data.isTakeout ? '포장' : '매장';
        if (requestNoteEl) requestNoteEl.textContent = data.requestNote || '요청사항 없음';

        // 주문 상품 목록
        const listContainer = document.querySelector('.order-items');
        if (listContainer) {
            listContainer.innerHTML = '';
            if (Array.isArray(data.orderItems)) {
                data.orderItems.forEach((item, idx) => {
                    const unit = Number(item.price || 0);
                    const qty = Number(item.quantity || 1);
                    const total = item.totalPrice != null ? Number(item.totalPrice) : (unit * qty);
                    const optionsHtml = (item.options && item.options.length > 0) ? 
                        '<ul class="order-option-list">' + 
                        item.options.map(opt => {
                            const priceText = (opt.extraPrice && opt.extraPrice > 0) ? 
                                '<em>+' + opt.extraPrice.toLocaleString() + '원</em>' : '';
                            return '<li><span>' + opt.optionStyle + '</span>' + priceText + '</li>';
                        }).join('') + 
                        '</ul>' : '';
                    const html = '<div class="order-item">'
                        + '<div class="item-number">' + (idx + 1) + '</div>'
                        + '<div class="item-details">'
                        +   '<div class="item-name">' + (item.productName || '') + '</div>'
                        +   '<div class="item-options">' + optionsHtml + '</div>'
                        +   '<div class="item-quantity">수량: ' + qty + '개</div>'
                        + '</div>'
                        + '<div class="item-pricing">'
                        +   '<div class="unit-price">단가: ' + unit.toLocaleString() + '원</div>'
                        +   '<div class="total-price">' + total.toLocaleString() + '원</div>'
                        +   '<div class="item-actions"><button class="btn btn-outline btn-sm" data-review-id="' + (item.orderDetailId || '') + '">리뷰 작성</button></div>'
                        + '</div>'
                        + '</div>';
                    listContainer.insertAdjacentHTML('beforeend', html);
                });
                listContainer.addEventListener('click', function(e){
                    const btn = e.target.closest('[data-review-id]');
                    if (!btn) return;
                    const odId = btn.getAttribute('data-review-id');
                    if (!odId) return;

                    // POST 폼을 동적으로 생성하여 리뷰 작성 페이지로 이동
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '/users/reviews';

                    const orderDetailIdInput = document.createElement('input');
                    orderDetailIdInput.type = 'hidden';
                    orderDetailIdInput.name = 'orderDetailId';
                    orderDetailIdInput.value = odId;
                    form.appendChild(orderDetailIdInput);

                    // CSRF 토큰 추가
                    const csrfToken = document.querySelector('meta[name="_csrf"]');
                    const csrfHeader = document.querySelector('meta[name="_csrf_header"]');
                    if (csrfToken && csrfHeader) {
                        const csrfInput = document.createElement('input');
                        csrfInput.type = 'hidden';
                        csrfInput.name = '_csrf';
                        csrfInput.value = csrfToken.getAttribute('content');
                        form.appendChild(csrfInput);
                    }

                    document.body.appendChild(form);
                    form.submit();
                });
            }
        }

        // 지점 정보
        if (data.branch) {
            const b = data.branch;
            const storeNameEl = document.querySelector('.store-name');
            const storeAddressEl = document.querySelector('.store-address');
            const storePhoneEl = document.querySelector('.store-phone');
            if (storeNameEl) storeNameEl.textContent = b.branchName || '';
            if (storeAddressEl) storeAddressEl.textContent = b.address || '';
            if (storePhoneEl) storePhoneEl.textContent = b.branchNumber || '';
        } else {
            // API에 지점 정보가 없으면 로컬 선택값으로 보정
            setStoreInfoFallbackFromLocal();
        }

        // 여전히 비어있다면 마지막으로 로컬 선택값으로 보정
        setStoreInfoFallbackFromLocal();

        // 결제/요약 정보
        const paymentMethodVal = document.querySelector('.payment-method .method-value');
        const paymentDateVal = document.querySelector('.payment-date .date-value');
        const orderAmountVal = document.querySelector('.payment-summary .order-amount');
        const totalQtyVal = document.querySelector('.payment-summary .total-qty');
        const totalAmountEl = document.querySelector('.total-amount');

        // 주문금액/총수량 계산
        let orderAmountCalc = 0;
        let qtyCalc = 0;
        if (Array.isArray(data.orderItems)) {
            data.orderItems.forEach(it => {
                const unit = Number(it.price || 0);
                const qty = Number(it.quantity || 1);
                const line = it.totalPrice != null ? Number(it.totalPrice) : unit * qty;
                orderAmountCalc += line;
                qtyCalc += qty;
            });
        }
        if (orderAmountVal) orderAmountVal.textContent = orderAmountCalc.toLocaleString() + '원';
        if (totalQtyVal) totalQtyVal.textContent = qtyCalc + '개';

        if (data.payment) {
            const p = data.payment;
            if (paymentMethodVal) paymentMethodVal.textContent = p.paymentMethod || '';
            if (paymentDateVal) paymentDateVal.textContent = (p.paymentDate ? new Date(p.paymentDate).toLocaleString() : (data.orderDate ? new Date(data.orderDate).toLocaleString() : '-'));
            if (totalAmountEl) totalAmountEl.textContent = (p.totalAmount || orderAmountCalc).toLocaleString() + '원';
        } else {
            if (totalAmountEl) totalAmountEl.textContent = (data.totalAmount != null ? data.totalAmount : orderAmountCalc).toLocaleString() + '원';
            if (paymentMethodVal) paymentMethodVal.textContent = '-';
            if (paymentDateVal) paymentDateVal.textContent = (data.orderDate ? new Date(data.orderDate).toLocaleString() : '-');
        }
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
    
    // 주문 상품 정보 업데이트 (체크아웃에서 세션으로 온 구조)
    function updateOrderItems(orderItems) {
        const container = document.querySelector('.order-items');
        if (!container) return;
        container.innerHTML = '';
        orderItems.forEach((item, idx) => {
            const name = item.name || '';
            const qty = Number(item.quantity || 0);
            const unit = Number(item.price || 0);
            const total = Number(item.total || unit * qty);
            const html = '<div class="order-item">'
                + '<div class="item-number">' + (idx + 1) + '</div>'
                + '<div class="item-details">'
                +   '<div class="item-name">' + name + '</div>'
                +   '<div class="item-quantity">수량: ' + qty + '개</div>'
                +   '<div class="item-actions"><button class="btn btn-outline btn-sm" disabled>리뷰 달기</button></div>'
                + '</div>'
                + '<div class="item-pricing">'
                +   '<div class="unit-price">단가: ' + unit.toLocaleString() + '원</div>'
                +   '<div class="total-price">' + total.toLocaleString() + '원</div>'
                + '</div>'
                + '</div>';
            container.insertAdjacentHTML('beforeend', html);
        });
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

<script>
    (function(){
        var nameTarget = document.getElementById('checkoutBranchName');
        var storeTitleTarget = document.getElementById('checkoutStoreName');
        var idInput = document.getElementById('selectedBranchIdInput');
        var nameInput = document.getElementById('selectedBranchNameInput');

        function setName(name){
            var display = name && String(name).trim() ? String(name).trim() : '-';
            if (nameTarget) nameTarget.textContent = display;
            if (storeTitleTarget) storeTitleTarget.textContent = display === '-' ? '매장 정보 없음' : display;
            if (nameInput) nameInput.value = name ? String(name).trim() : '';
        }

        function hydrate(){
            var id = idInput && idInput.value ? String(idInput.value).trim() : '';
            var nm = nameInput && nameInput.value ? String(nameInput.value).trim() : '';
            if (nm) { setName(nm); return; }
            if (id) {
                setName('매장 정보를 불러오는 중...');
                fetch('/branch/info/' + encodeURIComponent(id))
                    .then(function(r){ if(!r.ok) throw 0; return r.json(); })
                    .then(function(d){ setName(d && (d.name || d.branchName) ? (d.name || d.branchName) : ('ID ' + id)); })
                    .catch(function(){ setName('매장 정보를 불러오지 못했습니다'); });
                return;
            }
            try {
                var sel = (window.branchSelection && typeof window.branchSelection.load === 'function') ? window.branchSelection.load() : null;
                setName(sel && sel.name ? sel.name : '');
            } catch(e) {
                setName('');
            }
        }

        document.addEventListener('DOMContentLoaded', hydrate);
    })();
</script>
<%@ include file="/WEB-INF/views/common/footer.jspf" %>
