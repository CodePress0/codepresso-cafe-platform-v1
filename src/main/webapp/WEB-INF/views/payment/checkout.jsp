<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<script src="https://js.tosspayments.com/v1/payment"></script>
<style>
    @import url('${pageContext.request.contextPath}/css/checkout.css');  ;
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

        <!-- 선택된 매장 정보 전달용 (컨트롤러 비의존) -->
        <input type="hidden" id="selectedBranchIdInput" value="${branchId != null ? branchId : ''}" />
        <input type="hidden" id="selectedBranchNameInput" value="${branchName != null ? branchName : ''}" />

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
                            <c:when test="${not empty cartData and not empty cartData.items}">
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
                                        <div class="item-options" style="margin-top: 4px;">
                                            <ul class="order-option-list">
                                                <c:forEach var="option" items="${item.options}">
                                                    <c:if test="${option.optionStyle != '기본'}">
                                                        <li>
                                                            <span>${option.optionStyle}</span>
                                                            <c:if test="${option.extraPrice ne null && option.extraPrice ne 0}">
                                                                <em>+<fmt:formatNumber value="${option.extraPrice}" type="number" />원</em>
                                                            </c:if>
                                                        </li>
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
                    <span id="checkoutStoreName">
                        <c:choose>
                            <c:when test="${not empty branch}">${branch.branchName}</c:when>
                            <c:when test="${not empty branchName}">${branchName}</c:when>
                            <c:otherwise>매장 정보 없음</c:otherwise>
                        </c:choose>
                    </span>
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
                    <c:choose>
                        <c:when test="${validCouponCount > 0}">
                            <!-- 쿠폰이 있을 때 - 활성화 버튼 -->
                            <label class="coupon-option">
                                <input type="checkbox" id="useCoupon" name="useCoupon">
                                <div class="coupon-content">
                                    <div class="coupon-info">
                                        <div class="coupon-icon">
                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                                <circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="2"/>
                                                <path d="M9 12L11 14L15 10" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                            </svg>
                                        </div>
                                        <div class="coupon-details">
                                            <span class="coupon-name">할인 쿠폰 사용 (보유 ${validCouponCount}장)</span>
                                            <span class="coupon-discount">2,000원 할인</span>
                                        </div>
                                    </div>
                                    <div class="coupon-checkbox">
                                        <div class="checkbox-custom"></div>
                                    </div>
                                </div>
                            </label>
                        </c:when>
                        <c:otherwise>
                            <!-- 쿠폰이 없을 때 - 비활성화된 버튼 -->
                            <label class="coupon-option disabled">
                                <input type="checkbox" id="useCoupon" name="useCoupon" disabled>
                                <div class="coupon-content">
                                    <div class="coupon-info">
                                        <div class="coupon-icon">
                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                                <circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="2" opacity="0.5"/>
                                                <path d="M12 8V12M12 16H12.01" stroke="currentColor" stroke-width="2" stroke-linecap="round" opacity="0.5"/>
                                            </svg>
                                        </div>
                                        <div class="coupon-details">
                                            <span class="coupon-name"> 사용 가능한 쿠폰이 없습니다</span>
                                            <span class="coupon-discount">2,000원 할인 </span>
                                        </div>
                                    </div>
                                </div>
                            </label>
                        </c:otherwise>
                    </c:choose>
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
                    <button class="btn-payment" id="paymentBtn" onclick="processTossPayment()">
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
    // 서버 장바구니 cartId 힌트 (없으면 null 렌더)
    const __serverCartId = ${not empty cartData ? cartData.cartId : 'null'};
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

    // 로컬 타임존 기준 ISO 문자열(yyyy-MM-ddTHH:mm:ss) 생성 util (Z/오프셋 제거)
    function toLocalISOStringNoZ(date) {
        const t = new Date(date.getTime() - date.getTimezoneOffset() * 60000);
        return t.toISOString().slice(0, 19);
    }

    // 토스 페이먼츠 결제처리
    async function processTossPayment(){
        // 사용자 정보 확인
        if (!currentMemberId) {
            await fetchCurrentUser();
        }
        if (!currentMemberId) {
            alert('로그인이 필요합니다. 로그인 후 다시 시도해주세요.');
            window.location.href='/login';
            return;
        }

        // 매장 선택 확인 (기존 코드와 동일한 방식 사용)
        const branchId = (function() {
            try {
                const selected = window.branchSelection && window.branchSelection.load
                    ? window.branchSelection.load()
                    : null;
                return selected && selected.id ? parseInt(selected.id) : null;
            } catch(e) { return null; }
        })();

        if (!branchId) {
            alert('매장을 먼저 선택해주세요.');
            return;
        }

        // finalAmount 계산 (쿠폰 적용 포함)
        const useCouponCheckbox = document.getElementById('useCoupon');
        let finalAmount = ${totalAmount != null ? totalAmount : 0};

        if (useCouponCheckbox && useCouponCheckbox.checked) {
            finalAmount = finalAmount - 2000;
        }

        // 주문 데이터 구성 (기존 processPayment 함수와 동일한 방식)
        const selectedOrderType = document.querySelector('input[name="orderType"]:checked');
        const selectedPickupTime = document.querySelector('input[name="pickupTime"]:checked');
        const requestNote = document.getElementById('requestNote').value;

        // 픽업 시간 계산
        const now = new Date();
        const pickupTime = new Date(now.getTime() + (parseInt(selectedPickupTime.value) * 60 * 1000));
        const pickupTimeLocal = toLocalISOStringNoZ(pickupTime);

        // 주문 아이템 구성 (기존 로직 그대로 사용)
        let orderItems = [];
        if (${not empty directItems}) {
            <c:forEach var="d" items="${directItems}">
            orderItems.push({
                productId: ${d.productId},
                quantity: ${d.quantity},
                price: ${d.unitPrice},
                optionIds: [<c:forEach var="oid" items="${d.optionIds}" varStatus="s">${oid}<c:if test="${!s.last}">,</c:if></c:forEach>]
            });
            </c:forEach>
        } else if (${not empty cartData and not empty cartData.items}) {
            <c:forEach var="item" items="${cartData.items}">
            orderItems.push({
                productId: ${item.productId},
                quantity: ${item.quantity},
                price: Math.round(${item.price} / ${item.quantity}),
                optionIds: [<c:forEach var="option" items="${item.options}" varStatus="status">${option.optionId}<c:if test="${!status.last}">,</c:if></c:forEach>]
            });
            </c:forEach>
        }

        const orderData = {
            memberId: currentMemberId,
            branchId: branchId,  // ← 수정된 부분
            isTakeout: selectedOrderType.value === 'takeout',
            pickupTime: pickupTimeLocal,
            requestNote: requestNote,
            isFromCart: ${isFromCart == true ? 'true' : 'false'},
            orderItems: orderItems,
            // 쿠폰 정보도 추가
            usedCouponId: selectedCoupon ? selectedCoupon.couponId : null,
            couponDiscountAmount: selectedCoupon ? selectedCoupon.discountAmount : null
        };


        // 1. 주문 생성
        const orderResponse = await fetch('/api/payments/checkout', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(orderData)
        });

        const orderResult = await orderResponse.json();

        console.log('TossPayments:', typeof TossPayments);
        console.log('clientKey', '${clientKey}')

        // SDK 로드 확인
        if (typeof TossPayments === 'undefined') {
            alert('토스페이먼츠 SDK가 로드되지 않았습니다.');
            return;
        }

        try {
            // 2. 토스 결제창으로 이동 (v1 방식)
            const tossPayments = TossPayments('${clientKey}');
            console.log('TossPayments v1 initialized:', tossPayments);

            // Toss 규격에 맞춰 orderId 보정 (영/숫자/_- 만, 6~64자)
            const rawOrderId = orderResult.orderId;
            let tossOrderId = String(rawOrderId).replace(/[^A-Za-z0-9_-]/g, '');
            if (tossOrderId.length < 6) tossOrderId = tossOrderId.padStart(6, '0');
            if (tossOrderId.length > 64) tossOrderId = tossOrderId.slice(0, 64);

            // v1 방식으로 결제 요청
            tossPayments.requestPayment('카드', {
                amount: finalAmount,
                orderId: tossOrderId,
                orderName: 'CodePresso 주문',
                successUrl: 'http://localhost:8080/payments/success',
                failUrl: 'http://localhost:8080/payments/fail',
                customerEmail: 'customer@example.com',
                customerName: '고객명'
            });
            
        } catch (error) {
            console.error('토스 결제 오류:', error);
            alert('결제 처리 중 오류가 발생했습니다: ' + error.message);
        }

    }

    // 사용가능한 쿠폰 목록 조회
    async function fetchAvailableCoupons(memberId){
        try{
            const response = await fetch(`/api/coupons/me`);
            if(!response.ok) throw new Error('쿠폰 조회 실패');
            return await response.json();
        }catch (error){
            console.error('쿠폰 조회 오류:',error);
            return [];
        }
    }

    // 현재 쿠폰 선택 상태를 저장할 변수
    let selectedCoupon = null;

    const useCouponCheckbox = document.getElementById('useCoupon');
    if(useCouponCheckbox){
        useCouponCheckbox.addEventListener('change',async function (){
            if(this.checked){
                // 실제 쿠폰 목록 조회
                const coupons = await fetchAvailableCoupons();
                if(coupons.length > 0) {
                    selectedCoupon = {
                        couponId: coupons[0].couponId,
                        discountAmount: coupons[0].discountAmount
                    };
                }
            }else {
                selectedCoupon = null;
            }
            updatePaymentSummary();
            });
    }
</script>

<!-- 결제 페이지: 선택 매장명 하이드레이션 (컨트롤러 비의존) -->
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
