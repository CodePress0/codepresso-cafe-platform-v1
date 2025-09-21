<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>바나프레소</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css">
    <!-- 메뉴 상세 팝업 CSS 추가 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/productDetailCss.css">
</head>
<body>
<header class="header">
    <div class="header-content">
        <div class="logo-section">
            <a href="${pageContext.request.contextPath}/" class="logo">banapresso</a>
            <div class="order-location">
                주문하기 ▼
                <span style="margin-left: 20px;"> 매장을 선택하세요. 선택 ▶</span>
            </div>
        </div>
        <div class="header-actions">
            <button class="search-btn" onclick="showSearchModal()">🔍</button>
            <button class="cart-btn" onclick="toggleCart()">
                🛒
                <span class="cart-count" id="cartCount">0</span>
            </button>
        </div>
    </div>
</header>

<nav class="nav">
    <div class="nav-content">
        <a href="${pageContext.request.contextPath}/products?category=COFFEE" class="nav-item ${currentCategory == 'COFFEE' ? 'active' : ''}">커피</a>
        <a href="${pageContext.request.contextPath}/products?category=LATTE" class="nav-item ${currentCategory == 'LATTE' ? 'active' : ''}">라떼</a>
        <a href="${pageContext.request.contextPath}/products?category=JUICE" class="nav-item ${currentCategory == 'JUICE' ? 'active' : ''}">주스 & 드링크</a>
        <a href="${pageContext.request.contextPath}/products?category=SMOOTHIE" class="nav-item ${currentCategory == 'SMOOTHIE' ? 'active' : ''}">바나치노 & 스무디</a>
        <a href="${pageContext.request.contextPath}/products?category=TEA" class="nav-item ${currentCategory == 'TEA' ? 'active' : ''}">티 & 에이드</a>
        <a href="${pageContext.request.contextPath}/products?category=FOOD" class="nav-item ${currentCategory == 'FOOD' ? 'active' : ''}">디저트</a>
        <a href="${pageContext.request.contextPath}/products?category=SET" class="nav-item ${currentCategory == 'SET' ? 'active' : ''}">세트메뉴</a>
        <a href="${pageContext.request.contextPath}/products?category=MD_GOODS" class="nav-item ${currentCategory == 'MD_GOODS' ? 'active' : ''}">MD</a>
    </div>
</nav>

<div class="container">
    <div class="page-header">
        <h1 class="page-title">메뉴 보기</h1>
        <div class="filter-section">
            <button class="filter-btn">
                🏷️ 필터 <span class="cart-count">${fn:length(products)}</span>
            </button>
        </div>
    </div>

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
                    <!-- 메뉴 클릭 시 상세 팝업 열기로 변경 -->
                    <div class="menu-item" onclick="openMenuDetailPopup(${product.productId}, '${fn:escapeXml(product.productName)}', ${product.price}, '${product.productPhoto}', '${fn:escapeXml(product.productContent)}')">
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
                                    <div style="width: 100%; height: 100%; border-radius: 10px;
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
                                    <c:when test="${fn:containsIgnoreCase(product.productName, '시그니처') ||
                                                   fn:containsIgnoreCase(product.productName, 'NEW')}">
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
                            <button class="add-to-cart"
                                    onclick="event.stopPropagation(); addToCart('${fn:escapeXml(product.productName)}', ${product.price})">🛒</button>
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

<!-- 메뉴 상세 팝업 추가 -->
<div id="menuPopupOverlay" class="popup-overlay">
    <div class="popup-container">
        <!-- 헤더 -->
        <div class="popup-header">
            <h2 id="menuTitle">메뉴명</h2>
            <button class="close-btn" onclick="closeMenuPopup()">&times;</button>
        </div>

        <!-- 메뉴 이미지 -->
        <div class="menu-image-section">
            <img id="menuImage" src="" alt="메뉴 이미지" class="menu-image">
            <div class="menu-info">
                <div class="likes">
                    <span class="heart">♡</span>
                    <span id="menuLikes" class="like-count">1천</span>
                </div>
                <div class="review-badge">리뷰픽</div>
            </div>
        </div>

        <!-- 메뉴 설명 -->
        <div class="menu-description">
            <p id="menuDescription">맛있는 메뉴입니다.</p>
            <div class="menu-origin">
                <strong>원산지정보</strong>
                <span class="info-icon">ℹ</span>
            </div>
        </div>

        <!-- 카테고리 태그 -->
        <div class="category-tags" id="categoryTags">
            <!-- 동적으로 생성될 태그들 -->
        </div>

        <!-- 온도 선택 -->
        <div class="temperature-section">
            <button class="temp-btn" data-temp="hot">HOT</button>
            <button class="temp-btn active" data-temp="ice">ICE</button>

            <div class="temp-detail">
                <div class="temp-option">
                    <span class="temp-label">HOT</span>
                </div>
                <div class="temp-option active">
                    <span class="temp-icon">❄</span>
                    <span class="temp-label">ICE</span>
                </div>
            </div>
        </div>

        <!-- 영양정보 -->
        <div class="nutrition-section">
            <h3>영양정보 <span class="serving-info">1회 제공량 기준</span></h3>

            <table class="nutrition-table">
                <tr>
                    <td>열량(kcal)</td>
                    <td>98</td>
                    <td>나트륨 mg</td>
                    <td>10.65</td>
                </tr>
                <tr>
                    <td>단백질 g</td>
                    <td>0.26</td>
                    <td>당류 g</td>
                    <td>22.70</td>
                </tr>
                <tr>
                    <td>지방 g</td>
                    <td>0.01</td>
                    <td>카페인 mg</td>
                    <td>203.4</td>
                </tr>
                <tr>
                    <td>콜레스테롤 mg</td>
                    <td>0</td>
                    <td>당수화물 g</td>
                    <td>26.36</td>
                </tr>
                <tr>
                    <td>트랜스지방 g</td>
                    <td>0</td>
                    <td>포화지방 g</td>
                    <td>0</td>
                </tr>
            </table>
        </div>

        <!-- 수량 선택 -->
        <div class="quantity-section">
            <button class="quantity-btn minus" onclick="decreaseQuantity()">−</button>
            <span class="quantity-display">1</span>
            <button class="quantity-btn plus" onclick="increaseQuantity()">+</button>
        </div>

        <!-- 액션 버튼 -->
        <div class="action-buttons">
            <button class="order-btn immediate" onclick="orderImmediately()">바로 주문하기</button>
            <button class="order-btn cart" onclick="addToCartFromPopup()">담기</button>
        </div>
    </div>
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

    // 전역 변수로 현재 선택된 메뉴 정보 저장
    window.currentMenuData = {
        id: null,
        name: '',
        price: 0,
        photo: '',
        description: ''
    };

    // 메뉴 클릭 시 상세 팝업 열기 (ProductDetailResponse 사용)
    window.openMenuDetailPopup = function(id, name, price, photo, description) {
        console.log('팝업 함수 호출됨:', id, name, price);

        // 로딩 상태 표시
        showLoadingState();

        // 서버에서 ProductDetailResponse 데이터 가져오기
        fetch('${pageContext.request.contextPath}/products/' + id + '/detail')
            .then(response => {
                if (!response.ok) {
                    throw new Error('HTTP ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                console.log('서버에서 받은 데이터:', data);

                // ProductDetailResponse 데이터로 팝업 업데이트
                window.currentMenuData = {
                    id: data.productId,
                    name: data.productName,
                    price: data.price,
                    photo: data.productPhoto,
                    description: data.productContent,
                    nutritionInfo: data.nutritionInfo,
                    allergens: data.allergens,
                    productOptions: data.productOptions
                };

                // 팝업 내용 업데이트
                updatePopupContent(window.currentMenuData);

                // 팝업 열기
                openMenuPopup();
            })
            .catch(error => {
                console.error('상품 상세 정보 로딩 실패:', error);
                alert('상품 정보를 불러올 수 없습니다: ' + error.message);

                // 오류 시 기본 데이터로 팝업 열기
                window.currentMenuData = {
                    id: id,
                    name: name,
                    price: price,
                    photo: photo,
                    description: description
                };
                updatePopupContent(window.currentMenuData);
                openMenuPopup();
            });
    };

    // 팝업 내용 업데이트 함수
    function updatePopupContent(menuData) {
        document.getElementById('menuTitle').textContent = menuData.name;
        document.getElementById('menuImage').src = menuData.photo || '${pageContext.request.contextPath}/images/default-menu.jpg';
        document.getElementById('menuImage').alt = menuData.name;
        document.getElementById('menuDescription').textContent = menuData.description || '맛있는 ' + menuData.name + '입니다.';

        // 좋아요 수 랜덤 생성 (실제로는 서버에서 받아와야 함)
        const randomLikes = Math.floor(Math.random() * 5000) + 100;
        const likesText = randomLikes >= 1000 ? Math.floor(randomLikes/1000) + '천' : randomLikes.toString();
        document.getElementById('menuLikes').textContent = likesText;

        // 영양정보 업데이트
        if (menuData.nutritionInfo) {
            updateNutritionInfo(menuData.nutritionInfo);
        }

        // 카테고리 태그 생성
        generateCategoryTags(menuData.name);
    }

    // 영양정보 업데이트 함수
    function updateNutritionInfo(nutrition) {
        const nutritionTable = document.querySelector('.nutrition-table');
        if (nutritionTable && nutrition) {
            nutritionTable.innerHTML =
                '<tr>' +
                    '<td>열량(kcal)</td>' +
                    '<td>' + (nutrition.calories || '정보없음') + '</td>' +
                    '<td>나트륨 mg</td>' +
                    '<td>' + (nutrition.sodium || '정보없음') + '</td>' +
                '</tr>' +
                '<tr>' +
                    '<td>단백질 g</td>' +
                    '<td>' + (nutrition.protein || '정보없음') + '</td>' +
                    '<td>당류 g</td>' +
                    '<td>' + (nutrition.sugar || '정보없음') + '</td>' +
                '</tr>' +
                '<tr>' +
                    '<td>지방 g</td>' +
                    '<td>' + (nutrition.fat || '정보없음') + '</td>' +
                    '<td>카페인 mg</td>' +
                    '<td>' + (nutrition.caffeine || '정보없음') + '</td>' +
                '</tr>' +
                '<tr>' +
                    '<td>콜레스테롤 mg</td>' +
                    '<td>' + (nutrition.cholesterol || '정보없음') + '</td>' +
                    '<td>탄수화물 g</td>' +
                    '<td>' + (nutrition.carbohydrate || '정보없음') + '</td>' +
                '</tr>' +
                '<tr>' +
                    '<td>트랜스지방 g</td>' +
                    '<td>' + (nutrition.transFat || '정보없음') + '</td>' +
                    '<td>포화지방 g</td>' +
                    '<td>' + (nutrition.saturatedFat || '정보없음') + '</td>' +
                '</tr>';
        }
    }

    // 로딩 상태 표시 함수
    function showLoadingState() {
        // 간단한 로딩 상태 표시
        const popup = document.getElementById('menuPopupOverlay');
        popup.style.display = 'flex';
        document.getElementById('menuTitle').textContent = '로딩중...';
    }

    // 팝업 열기 함수
    window.openMenuPopup = function() {
        const popup = document.getElementById('menuPopupOverlay');
        popup.style.display = 'flex';
        document.body.style.overflow = 'hidden';

        // 애니메이션 효과
        setTimeout(() => {
            popup.querySelector('.popup-container').style.transform = 'scale(1)';
            popup.querySelector('.popup-container').style.opacity = '1';
        }, 10);
    };

    // 팝업 닫기 함수
    window.closeMenuPopup = function() {
        const popup = document.getElementById('menuPopupOverlay');
        popup.querySelector('.popup-container').style.transform = 'scale(0.9)';
        popup.querySelector('.popup-container').style.opacity = '0';

        setTimeout(() => {
            popup.style.display = 'none';
            document.body.style.overflow = 'auto';
        }, 200);
    };

    // 수량 조절 함수들
    window.decreaseQuantity = function() {
        const quantityDisplay = document.querySelector('.quantity-display');
        let quantity = parseInt(quantityDisplay.textContent);
        if (quantity > 1) {
            quantityDisplay.textContent = quantity - 1;
        }
    };

    window.increaseQuantity = function() {
        const quantityDisplay = document.querySelector('.quantity-display');
        let quantity = parseInt(quantityDisplay.textContent);
        quantityDisplay.textContent = quantity + 1;
    };

    // 온도 선택 함수
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.temp-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.temp-btn').forEach(b => b.classList.remove('active'));
                document.querySelectorAll('.temp-option').forEach(o => o.classList.remove('active'));

                this.classList.add('active');
                const temp = this.dataset.temp;
                if (temp === 'hot') {
                    document.querySelector('.temp-option:first-child').classList.add('active');
                } else {
                    document.querySelector('.temp-option:last-child').classList.add('active');
                }
            });
        });

        // 팝업 외부 클릭시 닫기
        document.getElementById('menuPopupOverlay').addEventListener('click', function(e) {
            if (e.target === this) {
                closeMenuPopup();
            }
        });
    });

    // 카테고리 태그 동적 생성
    function generateCategoryTags(menuName) {
        const tagsContainer = document.getElementById('categoryTags');
        tagsContainer.innerHTML = '';

        const tags = [];
        if (menuName.includes('아메리카노')) tags.push('카고노만');
        if (menuName.includes('라떼')) tags.push('부드러');
        if (menuName.includes('달콤') || menuName.includes('시럽')) tags.push('빨순짤');
        if (menuName.includes('에스프레소')) tags.push('콘스프레소');
        if (menuName.includes('카라멜') || menuName.includes('바닐라')) tags.push('캔가락');

        // 기본 태그 추가
        if (tags.length === 0) {
            tags.push('추천', '인기');
        }

        tags.forEach(tag => {
            const tagElement = document.createElement('span');
            tagElement.className = 'tag';
            tagElement.textContent = tag;
            tagsContainer.appendChild(tagElement);
        });
    }

    // 담기 버튼 클릭 시 메인 페이지의 장바구니에 추가
    window.addToCartFromPopup = function() {
        if (window.currentMenuData && window.currentMenuData.name) {
            // 메인 페이지의 addToCart 함수 호출
            if (typeof addToCart === 'function') {
                addToCart(window.currentMenuData.name, window.currentMenuData.price);
            }

            // 성공 메시지 표시
            alert('장바구니에 담았습니다.');

            // 팝업 닫기
            setTimeout(() => {
                closeMenuPopup();
            }, 500);
        }
    };

    // 바로 주문하기
    window.orderImmediately = function() {
        if (window.currentMenuData && window.currentMenuData.name) {
            alert('바로 주문 기능은 준비 중입니다.');
        }
    };

    var categoryInfo = {
        name: '${product.categoryName}',
        code: '${product.categoryCode}',
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
        카테고리: ${categoryName} (${categoryCode})<br>
        현재: ${currentCategory}<br>
        <c:if test="${not empty searchKeyword}">검색어: ${searchKeyword}<br></c:if>
        <c:if test="${not empty errorMessage}">오류: ${errorMessage}<br></c:if>
    </div>
</c:if>

</body>
</html>