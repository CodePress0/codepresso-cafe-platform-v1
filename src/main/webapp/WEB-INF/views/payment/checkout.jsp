<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<style>
    @import url('${pageContext.request.contextPath}/css/checkout.css');
</style>
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
                        <c:choose>
                            <c:when test="${not empty directItems}">
                                (<span id="itemCount">${directItemsCount}</span>개)
                            </c:when>
                            <c:when test="${not empty cartData.items}">
                                (<span id="itemCount">${cartData.items.size()}</span>개)
                            </c:when>
                            <c:otherwise>
                                (0개)
                            </c:otherwise>
                        </c:choose>
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
                    
                    <!-- 직접주문 데이터가 있는 경우 -->
                    <c:if test="${not empty directItems}">
                        <c:forEach var="d" items="${directItems}">
                            <div class="order-item">
                                <img src="${not empty d.productPhoto ? d.productPhoto : ''}"
                                     alt="${d.productName}" class="item-image">
                                <div class="item-details">
                                    <div class="item-name">${d.productName}</div>
                                    <div class="item-price">
                                        <fmt:formatNumber value="${d.unitPrice}" type="currency" currencySymbol="₩"/>
                                    </div>
                                    <div class="item-quantity">총 ${d.quantity}개</div>
                                    <c:if test="${not empty d.optionNames}">
                                        <div class="item-options" style="margin-top: 4px;">
                                            <ul class="order-option-list">
                                                <c:forEach var="on" items="${d.optionNames}">
                                                    <c:if test="${on != '기본'}">
                                                        <li><span>${on}</span></li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="item-total">
                                    <fmt:formatNumber value="${d.lineTotal}" type="currency" currencySymbol="₩"/>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>

                    <!-- 카트 데이터가 있는 경우 -->
                    <c:if test="${not empty cartData and not empty cartData.items}">
                        <c:forEach var="item" items="${orderItems}" varStatus="status">
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
                                    <c:if test="${not empty item.optionNames}">
                                        <div class="item-options" style="margin-top: 4px;">
                                            <ul class="order-option-list">
                                                <c:forEach var="optionName" items="${item.optionNames}">
                                                    <c:if test="${optionName != '기본'}">
                                                        <li><span>${optionName}</span></li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="item-total">
                                    <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₩"/>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    
                    <!-- 아무 데이터가 없는 경우 -->
                    <c:if test="${(empty directItems) and (empty cartData or empty cartData.items)}">
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
                    <span id="checkoutStoreName">매장을 선택해주세요</span>
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
                                    <span class="coupon-name">할인 쿠폰 사용
                                        <c:if test="${not empty validCouponCount}">
                                            (보유 ${validCouponCount}장)
                                            <c:if test="${not empty stampCount}">
                                                | (보유 스탬프 수 : ${stampCount}개)
                                            </c:if>
                                        </c:if>
                                    </span>
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
                        <span>매장</span>
                        <span id="checkoutBranchName">-</span>
                    </div>
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
                    <button class="btn-payment" id="paymentBtn" onclick="redirectToTossPayment()">
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

<script>
    const __serverCartId = ${not empty cartData and not empty cartData.cartId ? cartData.cartId : 'null'};
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
        fetchCurrentUser();
        });

    // 로컬 타임존 기준 ISO 문자열(yyyy-MM-ddTHH:mm:ss) 생성 util (Z/오프셋 제거)
    function toLocalISOStringNoZ(date) {
        const t = new Date(date.getTime() - date.getTimezoneOffset() * 60000);
        return t.toISOString().slice(0, 19);
    }

</script>

<!-- 결제 페이지: 선택 매장명 하이드레이션 (컨트롤러 비의존) -->
<script>
  (function(){
    var nameTarget = document.getElementById('checkoutBranchName');
    var storeTitleTarget = document.getElementById('checkoutStoreName');

    function setName(name){
      var display = name && String(name).trim() ? String(name).trim() : '-';
      if (nameTarget) nameTarget.textContent = display;
      if (storeTitleTarget) storeTitleTarget.textContent = display === '-' ? '매장을 선택해주세요' : display;
    }

    function hydrate(){
      try {
        var sel = window.branchSelection && typeof window.branchSelection.load === 'function'
            ? window.branchSelection.load()
            : null;
        setName(sel && sel.name ? sel.name : '매장을 선택해주세요');
      } catch(e) {
        setName('매장을 선택해주세요');
      }
    }

    document.addEventListener('DOMContentLoaded', hydrate);
  })();
</script>

<!-- 토스페이먼츠 결제 페이지로 리다이렉트 -->
<script>
    function redirectToTossPayment() {
        // 화면에 표시된 최종 결제금액 가져오기
        const finalAmountElement = document.getElementById('totalAmount');
        let finalAmount = 0;

        if (finalAmountElement) {
            const amountText = finalAmountElement.textContent || finalAmountElement.innerText;
            const amountMatch = amountText.match(/[\d,]+/);
            if (amountMatch) {
                finalAmount = parseInt(amountMatch[0].replace(/,/g, ''));
            }
        }

        // 만약 금액을 가져오지 못했다면 서버 금액에서 쿠폰 할인 계산
        if (finalAmount === 0) {
            const useCouponCheckbox = document.getElementById('useCoupon');
            const originalAmount = ${totalAmount != null ? totalAmount : 0};
            const discountAmount = useCouponCheckbox && useCouponCheckbox.checked ? 2000 : 0;
            finalAmount = originalAmount - discountAmount;
        }

        // sessionStorage에 사용자 선택 정보 저장
        const selectedOrderType = document.querySelector('input[name="orderType"]:checked');
        const selectedPackage = document.querySelector('input[name="package"]:checked');
        const selectedPickupTime = document.querySelector('input[name="pickupTime"]:checked');
        const useCouponCheckbox = document.getElementById('useCoupon');
        const requestNote = document.getElementById('requestNote').value;

        const checkoutOptions = {
            orderType: selectedOrderType ? selectedOrderType.value : 'takeout',
            packageType: selectedPackage ? selectedPackage.value : 'none',
            pickupMinutes: selectedPickupTime ? parseInt(selectedPickupTime.value) : 5,
            requestNote: requestNote || '',
            useCoupon: useCouponCheckbox ? useCouponCheckbox.checked : false,
            discountAmount: (useCouponCheckbox && useCouponCheckbox.checked) ? 2000 : 0
        };

        sessionStorage.setItem('checkoutOptions', JSON.stringify(checkoutOptions));
        console.log('주문 옵션 저장:', checkoutOptions);

        // POST 폼 생성 및 제출 (최소 파라미터만)
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/payments/toss-checkout';

        // amount 파라미터
        const amountInput = document.createElement('input');
        amountInput.type = 'hidden';
        amountInput.name = 'amount';
        amountInput.value = finalAmount;
        form.appendChild(amountInput);

        // 직접결제인 경우 추가 파라미터 전달
        <c:if test="${not empty directItems}">
        <c:forEach var="item" items="${directItems}" varStatus="status">
        <c:if test="${status.first}">
        // productId
        const productIdInput = document.createElement('input');
        productIdInput.type = 'hidden';
        productIdInput.name = 'productId';
        productIdInput.value = '${item.productId}';
        form.appendChild(productIdInput);

        // quantity
        const quantityInput = document.createElement('input');
        quantityInput.type = 'hidden';
        quantityInput.name = 'quantity';
        quantityInput.value = '${item.quantity}';
        form.appendChild(quantityInput);

        // optionIds
        <c:if test="${not empty item.optionIds}">
        <c:forEach var="optId" items="${item.optionIds}">
        const optionInput = document.createElement('input');
        optionInput.type = 'hidden';
        optionInput.name = 'optionIds';
        optionInput.value = '${optId}';
        form.appendChild(optionInput);
        </c:forEach>
        </c:if>
        </c:if>
        </c:forEach>
        </c:if>

        // CSRF 토큰 추가
        const csrfTokenMeta = document.querySelector('meta[name="_csrf"]');
        if (csrfTokenMeta) {
            const csrfInput = document.createElement('input');
            csrfInput.type = 'hidden';
            csrfInput.name = '_csrf';
            csrfInput.value = csrfTokenMeta.getAttribute('content') || '';
            form.appendChild(csrfInput);
        }

        document.body.appendChild(form);
        form.submit();
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>