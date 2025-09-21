<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메뉴 상세</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/productDetailCss.css">
</head>
<body>
<!-- 팝업 오버레이 -->
<div id="menuPopupOverlay" class="popup-overlay">
    <div class="popup-container">
        <!-- 헤더 -->
        <div class="popup-header">
            <h2 id="menuTitle">허니아메리카노</h2>
            <button class="close-btn" onclick="closeMenuPopup()">&times;</button>
        </div>

        <!-- 메뉴 이미지 -->
        <div class="menu-image-section">
            <img id="menuImage" src="images/honey-americano.jpg" alt="허니아메리카노" class="menu-image">
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
            <p id="menuDescription">진한 아메리카노에 진짜 꿀을 더했다. 속쓰이속엔 GOOD! 바나푸테스 스타디셰리~</p>
            <div class="menu-origin">
                <strong>원산지정보</strong>
                <span class="info-icon">ℹ</span>
            </div>
        </div>

        <!-- 카테고리 태그 -->
        <div class="category-tags">
            <span class="tag">카고노만</span>
            <span class="tag">부드러</span>
            <span class="tag">빨순짤</span>
            <span class="tag">콘스프레소</span>
            <span class="tag">캔가락</span>
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

<script src="${pageContext.request.contextPath}/js/productDetail.js"></script>

<!-- 메뉴 페이지와의 연동을 위한 스크립트 -->
<script>
    // 전역 변수로 현재 선택된 메뉴 정보 저장
    window.currentMenuData = {
        id: null,
        name: '',
        price: 0,
        photo: '',
        description: ''
    };

    // 메뉴 클릭 시 상세 팝업 열기
    window.openMenuDetail = function(menuData) {
        // 현재 메뉴 데이터 저장
        window.currentMenuData = menuData;

        // 팝업 내용 업데이트
        document.getElementById('menuTitle').textContent = menuData.name;
        document.getElementById('menuImage').src = menuData.photo || 'images/default-menu.jpg';
        document.getElementById('menuImage').alt = menuData.name;
        document.getElementById('menuDescription').textContent = menuData.description || '맛있는 ' + menuData.name + '입니다.';

        // 좋아요 수 랜덤 생성 (실제로는 서버에서 받아와야 함)
        const randomLikes = Math.floor(Math.random() * 5000) + 100;
        const likesText = randomLikes >= 1000 ? Math.floor(randomLikes/1000) + '천' : randomLikes.toString();
        document.getElementById('menuLikes').textContent = likesText;

        // 팝업 열기
        openMenuPopup();
    };

    // 담기 버튼 클릭 시 메인 페이지의 장바구니에 추가
    window.addToCartFromPopup = function() {
        if (window.currentMenuData && window.currentMenuData.name) {
            // 메인 페이지의 addToCart 함수 호출
            if (typeof addToCart === 'function') {
                addToCart(window.currentMenuData.name, window.currentMenuData.price);
            }

            // 성공 메시지 표시
            showSuccessMessage('장바구니에 담았습니다.');

            // 팝업 닫기
            setTimeout(() => {
                closeMenuPopup();
            }, 1000);
        }
    };
</script>
</body>
</html>