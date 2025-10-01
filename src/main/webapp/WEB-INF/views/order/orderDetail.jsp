<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<style>
    @import url('${pageContext.request.contextPath}/css/orderDetail.css');
</style>
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
                    <div class="order-number">주문번호(${orderDetail.orderNumber})</div>
                    <span class="status-badge status-${orderDetail.productionStatus == '주문접수' ? 'received' : orderDetail.productionStatus == '제조중' ? 'making' :orderDetail.productionStatus == '제조완료' ? 'complete' : 'pickup'}" ">
                        ${orderDetail.productionStatus}
                    </span>
                </div>

                <div class="status-progress">
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: ${orderDetail.productionStatus == '주문접수' ? '25' : orderDetail.productionStatus == '제조중' ? '50' : orderDetail.productionStatus == '제조완료' ? '75' : '100'}%;"></div>
                    </div>
                    <div class="progress-steps">
                        <div class="step">주문접수</div>
                        <div class="step">제조중</div>
                        <div class="step">제조완료</div>
                        <div class="step">픽업완료</div>
                    </div>
                </div>

                <div class="order-meta">
                    <div class="meta-row">
                        <span class="meta-label">주문일시</span>
                        <span class="meta-value">${orderDetail.orderDate.toString().substring(0,16).replace('T', ' ')}</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">픽업예정</span>
                        <span class="meta-value">${orderDetail.pickupTime.toString().substring(0,16).replace('T', ' ')}</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">주문형태</span>
                        <span class="meta-value">${orderDetail.isTakeout ? '테이크아웃' : '매장'}</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">요청사항</span>
                        <span class="meta-value">${not empty orderDetail.requestNote ? orderDetail.requestNote : '요청사항 없음'}</span>
                    </div>
                </div>
            </div>

            <!-- 주문 상품 목록 -->
            <div class="order-items-section">
                <h2 class="section-title">주문상품</h2>

                <div class="order-items">
                    <c:forEach var="item" items="${orderDetail.orderItems}" varStatus="status">
                        <div class="order-item">
                            <div class="item-number">${status.count}</div>
                            <div class="item-details">
                                <div class="item-name">${item.productName}</div>

                                <!-- 옵션 표시 -->
                                <c:if test="${not empty item.options}">
                                    <div class="item-options">
                                        <ul class="order-option-list">
                                            <c:forEach var="option" items="${item.options}">
                                                <li>
                                                    <span>${option.optionStyle}</span>
                                                    <c:if test="${option.extraPrice > 0}">
                                                        <em>+<fmt:formatNumber value="${option.extraPrice}" type="number"/>원</em>
                                                    </c:if>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </c:if>

                                <div class="item-quantity">수량: ${item.quantity}개 </div>
                            </div>
                            <div class="item-pricing">
                                <div class="unit-price">단가: <fmt:formatNumber value="${item.price}" type="currency" currencySymbol=""/></div>
                                <div class="total-price"><fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol=""/></div>
                                <div class="item-actions">
                                    <button class="btn btn-outline btn-sm" onclick="writeReview(${item.orderDetailId})">리뷰 작성</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- 지점 정보 -->
            <div class="store-section">
                <h2 class="section-title">픽업 매장</h2>
                <div class="store-info">
                    <c:choose>
                        <c:when test="${not empty orderDetail.branch}">
                            <!-- 백엔드 데이터 사용 -->
                            <div class="store-name">${orderDetail.branch.branchName}</div>
                            <div class="store-address">${orderDetail.branch.address}</div>
                            <div class="store-phone">${orderDetail.branch.branchNumber}</div>
                        </c:when>
                        <c:otherwise>
                            <!-- JavaScript로 로드-->
                            <div class="store-name" id="storeName">매장 정보 로딩중...</div>
                            <div class="store-address" id="storeAddress">-</div>
                            <div class="store-phone" id="storePhone">-</div>
                            <script>
                                document.addEventListener('DOMContentLoaded',function (){
                                    if(window.branchSelection && typeof window.branchSelection.load()=='function'){
                                        const branch = window.branchSelection.load();
                                        if(branch){
                                            document.getElementById('storeName').textContent = branch.name;
                                            document.getElementById('storeAddress').textContent = branch.address;
                                            document.getElementById('storePhone').textContent = branch.phone;
                                        }
                                    }
                                });
                            </script>
                        </c:otherwise>
                    </c:choose>
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
                        <span class="method-value">
                            <c:choose>
                                <c:when test="${not empty orderDetail.payment.paymentMethod}">
                                    ${orderDetail.payment.paymentMethod}
                                </c:when>
                                <c:otherwise>신용카드</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="payment-date">
                        <span class="date-label">결제일시</span>
                        <span class="date-value">
                            <c:choose>
                                <c:when test="${not empty orderDetail.payment.paymentDate}">
                                    ${orderDetail.payment.paymentDate.toString().substring(0,16).replace('T', ' ')}
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>

                <div class="payment-summary">
                    <div class="summary-row">
                        <span>주문금액</span>
                        <span class="order-amount">
                            <c:choose>
                                <c:when test="${not empty orderDetail.payment.totalAmount}">
                                    <fmt:formatNumber value="${orderDetail.payment.totalAmount}" type="currency" currencySymbol="₩"/>
                                </c:when>
                                <c:otherwise>0원</c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                    <!-- 할인 행 - 할인이 있을 때만 표시 -->
                    <c:if test="${not empty orderDetail.payment.discount && orderDetail.payment.discount >0}">
                        <div class="summary-row coupon-discount">
                            <span> 쿠폰 할인 </span>
                            <span class="discount-amount">-<fmt:formatNumber value="${orderDetail.payment.discount}" type="currency" currencySymbol=""/>원</span>
                        </div>
                    </c:if>

                    <div class="summary-row">
                        <span>총 수량</span>
                        <span class="total-qty">${orderDetail.orderItems.size()}개</span>
                    </div>

                    <div class="summary-divider"></div>

                    <div class="summary-row total">
                        <span>총 결제금액</span>
                        <span class="total-amount">
                            <fmt:formatNumber value="${orderDetail.payment.finalAmount != null ? orderDetail.payment.finalAmount : orderDetail.payment.totalAmount}" type="currency" currencySymbol=""/>원
                        </span>
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

    // 리뷰 작성 함수
    function writeReview(orderDetailId){
        // POST 폼으로 리뷰 작성 페이지 이동
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/users/reviews';

        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'orderDetailId';
        input.value = orderDetailId;
        form.appendChild(input);

        document.body.appendChild(form);
        form.submit();
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
