<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
  @import url('${pageContext.request.contextPath}/css/orderList.css');
</style>
<body>
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="hero">
  <div class="container">
    <div class="hero-card" style="grid-template-columns: 1fr;">
      <div>
        <div class="badge">CodePress · 주문 내역</div>
        <h1>내 주문 내역</h1>

        <!-- 필터 옵션 -->
        <div class="filter-section">
          <form method="GET" action="/orders">
            <select name="period" onchange="this.form.submit()">
              <c:forEach var="option" items="${periodOptions}">
                <option value="${option}" ${option == selectedPeriod ? 'selected' : ''}>${option}</option>
              </c:forEach>
            </select>
          </form>
        </div>

        <!-- 에러 메시지 -->
        <c:if test="${not empty error}">
          <div class="error-message">
            ${error}
          </div>
        </c:if>

        <!-- 주문 통계 -->
        <c:if test="${hasOrders}">
          <div class="order-stats">
            <strong>총 ${totalCount}개 주문 (기간 ${filteredCount}개)</strong>
          </div>
        </c:if>

        <!-- 주문 목록 -->
        <c:choose>
          <c:when test="${hasOrders}">
            <div class="orders-container">
              <c:forEach var="order" items="${orderList.orders}">
                <div class="order-card" onclick="location.href='/orders/${order.orderId}'">
                  <!-- 주문 헤더 -->
                  <div class="order-header">
                    <div class="order-info">
                      <div class="order-date">
                        ${order.orderDate.toString().substring(o,16).replace('T',' ')}
                      </div>
                      <div class="order-number">${order.orderNumber}</div>
                    </div>
                    <div class="order-status status-${order.productionStatus == '주문접수' ?  'received' : order.productionStatus == '제조중' ? 'making' : order.productionStatus == '제조완료' ? 'complete' : 'pickup'}">
                      ${order.productionStatus}
                  </div>
                </div>

                  <!-- 주문 내용 -->
                  <div class="order-content">
                    <div class="order-items">
                      <span class="representative-item">${order.representativeName}</span>
                    </div>
                    <div class="order-details">
                      <span class="branch-name">${order.branchName}</span>
                      <span class="order-type">${order.isTakeout ? '포장' : '매장'}</span>
                    </div>
                  </div>

                  <!-- 주문 금액 -->
                  <div class="order-footer">
                    <div class="order-total">
                      <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₩"/>
                    </div>
                    <div class="pickup-time">
                      픽업: ${order.pickupTime.toString().substring(11,16)}
                    </div>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:when>
        </c:choose>

        <!-- 빈 상태 -->
        <div id="empty-state" style="display: none; text-align: center; padding: 40px 16px; color: var(--text-2);">
          <h3 style="color: var(--text-2);">📋 주문 내역이 없습니다</h3>
          <p>첫 주문을 시작해보세요!</p>
        </div>

        <!-- 하단 액션 버튼 -->
        <div class="cta" style="justify-content: center; margin-top: 20px;">
          <a href="/branch/list" class="btn btn-primary">주문하러 가기</a>
          <a href="/member/mypage" class="btn btn-ghost">마이페이지로 돌아가기</a>
        </div>
      </div>
    </div>
  </div>
</main>

<script>
  // 주문 상세보기: 세션 브릿지 없이 바로 이동
function viewOrderDetail(orderId) {
    window.location.href = '/orders/' + orderId;
}

// 리뷰 작성
function writeReview(orderId) {
    alert('리뷰 작성 기능은 준비 중입니다.');
}

</script>


<%@ include file="/WEB-INF/views/common/footer.jspf" %>
