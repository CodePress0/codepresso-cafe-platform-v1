<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
  @import url('${pageContext.request.contextPath}/css/orderList.css');
</style>
<body>
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="order-list-main">
  <div class="rcontainer">
    <div class="section-header">
      <div class="badge">CodePress · 마이페이지</div>
      <h1 style="margin-top: 12px;">마이페이지</h1>
    </div>

    <!-- 탭 메뉴 -->
    <style>
        .tab-menu {
            display: flex;
            gap: 8px;
            border-bottom: 2px solid rgba(255,122,162,0.2);
            margin: 24px 0 32px;
            overflow-x: auto;
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
        .tab-menu::-webkit-scrollbar {
            display: none;
        }
        .tab-item {
            padding: 14px 24px;
            background: transparent;
            border: none;
            color: var(--text-2);
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            position: relative;
            transition: all 0.2s ease;
            white-space: nowrap;
            text-decoration: none;
            display: inline-block;
        }
        .tab-item:hover {
            color: var(--pink-1);
            background: rgba(255,122,162,0.05);
        }
        .tab-item.active {
            color: var(--pink-1);
            font-weight: 700;
        }
        .tab-item.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            right: 0;
            height: 3px;
            background: var(--pink-1);
            border-radius: 3px 3px 0 0;
        }
    </style>

    <div class="tab-menu">
        <a href="/member/mypage" class="tab-item">👤 내 정보</a>
        <a href="/favorites" class="tab-item">⭐ 즐겨찾기</a>
        <a href="/users/myReviews" class="tab-item">✍️ 내 리뷰</a>
        <a href="/orders" class="tab-item active">📋 주문목록</a>
    </div>

    <!-- 필터 옵션 -->
    <div class="filter-section">
      <form method="GET" action="/orders" id="filterForm">
        <input type="hidden" name="page" value="0">
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
                    ${order.orderDate.toString().substring(0,16).replace('T',' ')}
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

        <!-- 페이징 UI -->
        <c:if test="${totalPages > 1}">
          <div class="pagination-container">
            <!-- 페이지 정보 -->
            <div class="pagination-info">
              <span>전체 ${filteredCount}건</span>
              <span>|</span>
              <span>${currentPage + 1} / ${totalPages} 페이지</span>
            </div>

            <!-- 페이지네이션 -->
            <div class="pagination">
              <!-- 이전 버튼 -->
              <c:if test="${hasPrevious}">
                <a href="/orders?period=${selectedPeriod}&page=${currentPage - 1}" class="pagination-btn">
                  ← 이전
                </a>
              </c:if>
              <c:if test="${!hasPrevious}">
                <span class="pagination-btn disabled">← 이전</span>
              </c:if>

              <!-- 페이지 번호 -->
              <div class="pagination-numbers">
                <c:forEach var="pageNum" items="${pageNumbers}">
                  <c:choose>
                    <c:when test="${pageNum == currentPage}">
                      <span class="pagination-number active">${pageNum + 1}</span>
                    </c:when>
                    <c:otherwise>
                      <a href="/orders?period=${selectedPeriod}&page=${pageNum}" class="pagination-number">
                        ${pageNum + 1}
                      </a>
                    </c:otherwise>
                  </c:choose>
                </c:forEach>
              </div>

              <!-- 다음 버튼 -->
              <c:if test="${hasNext}">
                <a href="/orders?period=${selectedPeriod}&page=${currentPage + 1}" class="pagination-btn">
                  다음 →
                </a>
              </c:if>
              <c:if test="${!hasNext}">
                <span class="pagination-btn disabled">다음 →</span>
              </c:if>
            </div>
          </div>
        </c:if>
      </c:when>
      <c:otherwise>
        <!-- 빈 상태 -->
        <div style="text-align: center; padding: 40px 16px; color: var(--text-2);">
          <h3 style="color: var(--text-2);">📋 주문 내역이 없습니다</h3>
          <p>첫 주문을 시작해보세요!</p>
        </div>
      </c:otherwise>
    </c:choose>

    <!-- 주문하러 가기 버튼 -->
    <div style="text-align: center; margin: 32px 0 20px;">
      <a href="/branch/list" class="btn btn-primary" style="padding: 16px 48px; font-size: 18px; font-weight: 700;">주문하러 가기</a>
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
