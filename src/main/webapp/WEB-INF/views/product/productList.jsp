<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<style>
    @import url('${pageContext.request.contextPath}/css/menu.css');
    @import url('${pageContext.request.contextPath}/css/productDetailCss.css');
</style>
<body class="product-list-page">
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="product-page-main product-list-main">
<%@ include file="/WEB-INF/views/product/product-category-nav.jspf" %>

<div class="container">
<%--    <div class="page-header">--%>
<%--        <h1 class="page-title">메뉴 보기</h1>--%>
<%--    </div>--%>

    <div class="section-header">
        <h2 class="section-title">
            <c:choose>
                <c:when test="${currentCategory == 'COFFEE'}">
                    커피
                    <span class="section-subtitle">COFFEE</span>
                </c:when>
                <c:when test="${currentCategory == 'LATTE'}">
                    라떼
                    <span class="section-subtitle">LATTE</span>
                </c:when>
                <c:when test="${currentCategory == 'JUICE'}">
                    주스 & 드링크
                    <span class="section-subtitle">JUICE & DRINKS</span>
                </c:when>
                <c:when test="${currentCategory == 'SMOOTHIE'}">
                    바나치노 & 스무디
                    <span class="section-subtitle">BANACCINO & SMOOTHIE</span>
                </c:when>
                <c:when test="${currentCategory == 'TEA'}">
                    티 & 에이드
                    <span class="section-subtitle">TEA & ADE</span>
                </c:when>
                <c:when test="${currentCategory == 'FOOD'}">
                    디저트
                    <span class="section-subtitle">DESSERT</span>
                </c:when>
                <c:when test="${currentCategory == 'SET'}">
                    세트메뉴
                    <span class="section-subtitle">SET MENU</span>
                </c:when>
                <c:when test="${currentCategory == 'MD_GOODS'}">
                    MD상품
                    <span class="section-subtitle">MD PRODUCTS</span>
                </c:when>
                <c:otherwise>
                    전체 메뉴
                    <span class="section-subtitle">ALL MENU</span>
                </c:otherwise>
            </c:choose>
        </h2>
    </div>

    <!-- 에러 메시지 표시 -->
    <c:if test="${not empty errorMessage}">
        <div class="error-message" style="background: #ffe6e6; padding: 15px; border-radius: 8px; margin-bottom: 20px; color: #d00;">
            <strong>오류:</strong> <c:out value="${errorMessage}" />
        </div>
    </c:if>

    <!-- 검색 결과 메시지 -->
    <c:if test="${currentCategory == 'search'}">
        <div class="search-info" style="background: #e6f3ff; padding: 15px; border-radius: 8px; margin-bottom: 20px;">
            <strong>"${searchKeyword}"</strong> 검색 결과: <strong>${fn:length(products)}개</strong>의 상품이 찾아졌습니다.
        </div>
    </c:if>

    <!-- 상품 리스트 -->
    <c:choose>
        <c:when test="${not empty products}">
            <div class="menu-grid">
                <c:forEach var="product" items="${products}" varStatus="status">
                    <!-- 메뉴 클릭 시 상세 페이지로 이동 -->
                    <div class="menu-item" onclick="location.href='${pageContext.request.contextPath}/products/${product.productId}'">
                        <div class="menu-image-container">
                            <!-- 동적 이미지 클래스 설정 -->
                            <c:set var="imageClass" value="menu-image" />
                            <c:if test="${fn:containsIgnoreCase(product.productName, '핑크') || fn:containsIgnoreCase(product.productName, '딸기')}">
                                <c:set var="imageClass" value="menu-image pink" />
                            </c:if>
                            <c:if test="${fn:containsIgnoreCase(product.productName, '바나나')}">
                                <c:set var="imageClass" value="menu-image yellow" />
                            </c:if>

                            <div class="${imageClass}">
                                <!-- 실제 상품 이미지 표시 -->
                                <c:if test="${not empty product.productPhoto}">
                                    <div style="width: 100%; height: 100%; border-radius: 0;
                                            background-image: url('${product.productPhoto}');
                                            background-size: contain;
                                            background-position: center;
                                            background-repeat: no-repeat;">
                                    </div>
                                </c:if>

                                <!-- 동적 태그 생성 -->
                                <c:choose>
                                    <c:when test="${fn:containsIgnoreCase(product.productName, '시그니처')}">
                                        <div class="menu-tag tag-signature">시그니처</div>
                                    </c:when>
                                    <c:when test="${fn:containsIgnoreCase(product.productName, '디카페인')}">
                                        <div class="menu-tag tag-decaf">디카페인</div>
                                    </c:when>
                                    <c:when test="${fn:containsIgnoreCase(product.productName, '아메리카노') &&
                                                   !fn:containsIgnoreCase(product.productName, '시그니처') &&
                                                   !fn:containsIgnoreCase(product.productName, '디카페인')}">
                                        <div class="menu-tag tag-premium">고소함</div>
                                    </c:when>
                                    <c:when test="${fn:containsIgnoreCase(product.productName, '시그니처')}">
                                        <div class="menu-tag tag-new">산미</div>
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>

                        <div class="menu-info">
                            <div class="menu-name" title="${product.productContent}">
                                <c:out value="${product.productName}" />
                            </div>
                            <div class="menu-price">
                                <fmt:formatNumber value="${product.price}" pattern="#,###"/>원
                            </div>
                            <!-- 장바구니 버튼은 이벤트 전파 중단 -->
<%--                            <button class="add-to-cart"--%>
<%--                                    onclick="event.stopPropagation(); addToCart('${fn:escapeXml(product.productName)}', ${product.price})">🛒</button>--%>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="no-products" style="text-align: center; padding: 100px 20px; color: #666;">
                <h3>해당 카테고리에 상품이 없습니다.</h3>
                <p>다른 카테고리를 선택해보세요.</p>
                <c:if test="${not empty currentCategory && currentCategory != 'all'}">
                    <a href="?category=all" style="color: #ff6b9d; text-decoration: none;">→ 전체 상품 보기</a>
                </c:if>
            </div>
        </c:otherwise>
    </c:choose>
</div>


<!-- 검색 모달 -->
<div id="searchModal" class="modal" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5);">
    <div class="modal-content" style="background-color: white; margin: 15% auto; padding: 20px; border-radius: 10px; width: 80%; max-width: 500px;">
        <span class="close" onclick="hideSearchModal()" style="color: #aaa; float: right; font-size: 28px; font-weight: bold; cursor: pointer;">&times;</span>
        <h2>메뉴 검색</h2>
        <form action="${pageContext.request.contextPath}/search" method="get" style="margin-top: 20px;">
            <input type="text" name="keyword" placeholder="검색할 메뉴명을 입력하세요..."
                   style="width: 80%; padding: 10px; border: 1px solid #ddd; border-radius: 5px;" required>
            <button type="submit"
                    style="width: 15%; padding: 10px; background: #ff6b9d; color: white; border: none; border-radius: 5px; cursor: pointer;">검색</button>
        </form>
    </div>
</div>

<!-- 장바구니 오버레이 -->
<div class="cart-overlay" id="cartOverlay" onclick="toggleCart()"></div>

<!-- 장바구니 패널 -->
<div class="cart-panel" id="cartPanel">
    <div class="cart-header">
        <h3 class="cart-title">장바구니</h3>
        <button class="close-cart" onclick="toggleCart()">✕</button>
    </div>

    <div class="cart-items" id="cartItems">
        <div style="text-align: center; color: #666; padding: 40px 20px;">
            장바구니가 비어있습니다
        </div>
    </div>

    <div class="cart-total">
        <div class="total-amount">총 금액: <span id="totalAmount">0</span>원</div>
        <button class="order-btn" id="orderBtn" disabled onclick="placeOrder()">주문하기</button>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/menu.js"></script>
<!-- 메뉴 상세 팝업 스크립트 추가 -->
<script src="${pageContext.request.contextPath}/js/menuDetail.js"></script>

<!-- JSP에서 JavaScript로 데이터 전달 -->
<script type="text/javascript">
    // 서버에서 전달받은 데이터를 JavaScript 변수로 설정
    var products = [
        <c:forEach var="product" items="${products}" varStatus="status">
        {
            id: ${product.productId},
            name: '${fn:escapeXml(product.productName)}',
            price: ${product.price},
            photo: '${product.productPhoto}',
            categoryName: '${product.categoryName}',
            description: '${fn:escapeXml(product.productContent)}'
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];




    var categoryInfo = {
        current: '${currentCategory}',
        totalCount: ${fn:length(products)}
    };

    console.log('로드된 상품 수:', products.length);
    console.log('현재 카테고리:', categoryInfo.current);

    // 페이지 로드 시 상품 정보 확인
    document.addEventListener('DOMContentLoaded', function() {
        console.log('상품 데이터:', products);
        console.log('카테고리 정보:', categoryInfo);

        // 상품이 없을 때 메시지 표시
        if (products.length === 0) {
            console.warn('표시할 상품이 없습니다.');
        }
    });

    // 검색 모달 관련 함수
    function showSearchModal() {
        document.getElementById('searchModal').style.display = 'block';
    }

    function hideSearchModal() {
        document.getElementById('searchModal').style.display = 'none';
    }

    // 모달 외부 클릭시 닫기
    window.onclick = function(event) {
        const modal = document.getElementById('searchModal');
        if (event.target == modal) {
            modal.style.display = 'none';
        }
    }

    // 장바구니 관련 함수들 (기존 menu.js에서 사용)
    function addToCart(productName, price) {
        console.log('장바구니 추가:', productName, price);
        // 실제 장바구니 로직은 menu.js에서 처리
        if (typeof window.addToCartHandler === 'function') {
            window.addToCartHandler(productName, price);
        }
    }

    function toggleCart() {
        console.log('장바구니 토글');
        if (typeof window.toggleCartHandler === 'function') {
            window.toggleCartHandler();
        }
    }

    function placeOrder() {
        console.log('주문하기');
        if (typeof window.placeOrderHandler === 'function') {
            window.placeOrderHandler();
        }
    }
</script>

<!-- 디버깅 정보 (개발 시에만 사용) -->
<c:if test="${param.debug == 'true'}">
    <div style="position: fixed; bottom: 10px; right: 10px; background: rgba(0,0,0,0.8); color: white; padding: 10px; border-radius: 5px; font-size: 12px; z-index: 9999;">
        <strong>디버그 정보:</strong><br>
        상품 수: ${fn:length(products)}<br>
        현재: ${currentCategory}<br>
        <c:if test="${not empty errorMessage}">오류: ${errorMessage}<br></c:if>
    </div>
</c:if>

</main>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
