<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<body>
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="hero">
  <div class="container">
    <div class="hero-card" style="grid-template-columns: 1fr;">
      <div>
        <div class="badge">CodePress · 즐겨찾기</div>
        <h1>내 즐겨찾기</h1>

        <c:if test="${not empty success}">
          <div class="success-message">✅ ${success}</div>
        </c:if>
        <c:if test="${not empty error}">
          <div class="error-message">❌ ${error}</div>
        </c:if>

    <c:choose>
        <c:when test="${not empty favoriteList.favorites and favoriteList.totalCount > 0}">
            <!-- 즐겨찾기 통계 -->
            <div class="favorite-stats" style="background: var(--pink-4); padding: 12px 16px; border-radius: 12px; text-align:center;">
              <strong style="color: var(--pink-1);">총 ${favoriteList.totalCount}개 즐겨찾기</strong>
            </div>

            <!-- 즐겨찾기 목록 -->
            <div class="favorite-grid" style="display:grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap:16px; margin-top:16px;">
                <c:forEach var="favorite" items="${favoriteList.favorites}" varStatus="status">
                    <div class="favorite-item" style="background: var(--white); border-radius: 16px; box-shadow: var(--shadow); padding: 14px;">
                        <div class="orderby-info" style="font-size:12px;color:var(--text-2);">순서: ${favorite.orderby}</div>
                        
                        <c:if test="${not empty favorite.productPhoto}">
                            <img src="${favorite.productPhoto}" alt="${favorite.productName}" class="product-image"
                                 onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwIiBoZWlnaHQ9IjIwMCIgdmlld0JveD0iMCAwIDMwMCAyMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIzMDAiIGhlaWdodD0iMjAwIiBmaWxsPSIjRjVGNUY1Ii8+Cjx0ZXh0IHg9IjE1MCIgeT0iMTAwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSIjOTk5IiBmb250LWZhbWlseT0iQXJpYWwiIGZvbnQtc2l6ZT0iMTQiPkltYWdlPC90ZXh0Pgo8L3N2Zz4='; this.onerror=null;">
                        </c:if>
                        <c:if test="${empty favorite.productPhoto}">
                            <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwIiBoZWlnaHQ9IjIwMCIgdmlld0JveD0iMCAwIDMwMCAyMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIzMDAiIGhlaWdodD0iMjAwIiBmaWxsPSIjRjVGNUY1Ii8+Cjx0ZXh0IHg9IjE1MCIgeT0iMTAwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSIjOTk5IiBmb250LWZhbWlseT0iQXJpYWwiIGZvbnQtc2l6ZT0iMTQiPk5vIEltYWdlPC90ZXh0Pgo8L3N2Zz4=" alt="No Image" class="product-image">
                        </c:if>
                        
                        <div class="product-name" style="font-weight:800; font-size:18px; margin:6px 0;">${favorite.productName}</div>
                        <div class="product-content" style="color:var(--text-2); font-size:14px; margin-bottom:6px; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical; overflow:hidden;">${favorite.productContent}</div>
                        <div class="product-price" style="font-weight:800; color: var(--pink-1);">
                          <fmt:formatNumber value="${favorite.price}" type="currency" currencySymbol="₩"/>
                        </div>
                        
                        <div class="favorite-actions" style="display:flex; gap:8px; justify-content:space-between;">
                          <a href="#" class="btn btn-ghost" onclick="alert('상품 상세 페이지는 준비 중입니다!'); return false;">상품 보기</a>
                          <button class="btn btn-primary" onclick="removeFavorite('${favorite.productId}')">즐겨찾기 삭제</button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <!-- 즐겨찾기가 없는 경우 -->
            <div class="empty-state" style="text-align:center; padding:40px 16px; color:var(--text-2);">
              <h3 style="color:var(--text-2);">😔 즐겨찾기가 비어있습니다</h3>
              <p>마음에 드는 상품을 즐겨찾기에 추가해보세요!</p>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- 하단 액션 버튼 -->
    <div class="cta" style="justify-content:center; margin-top: 20px;">
        <a href="/branch/list" class="btn btn-primary">주문하러 가기</a>
        <a href="/member/mypage" class="btn btn-ghost">마이페이지로 돌아가기</a>
    </div>
      </div>
    </div>
  </div>
</main>

<script>
    // 즐겨찾기 삭제 함수
    function removeFavorite(productId) {
        if (confirm('정말로 이 상품을 즐겨찾기에서 삭제하시겠습니까?')) {
            fetch('/users/favorites/' + productId, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message);
                    location.reload(); // 페이지 새로고침
                } else {
                    alert('삭제 실패: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('삭제 중 오류가 발생했습니다.');
            });
        }
    }
</script>
<%@ include file="/WEB-INF/views/common/footer.jspf" %>
