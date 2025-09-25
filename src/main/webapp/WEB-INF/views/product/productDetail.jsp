<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="/WEB-INF/views/common/head.jspf" %>

<style>
    @import url('${pageContext.request.contextPath}/css/menu.css');

    /* 전체 페이지 레이아웃 조정 */
    body.product-detail-page {
        padding-top: 0; /* head.jspf의 기본 패딩 제거 */
        background-color: #f7f7f7;
    }

    .product-detail-main .pdcontainer {
        max-width: 1120px;
        margin: 0 auto;
        padding: 40px 24px 80px;
    }

    .product-detail-main .product-shell {
        background: #ffffff;
        border-radius: 24px;
        box-shadow: 0 18px 40px rgba(15, 23, 42, 0.08);
        padding: 32px 32px 48px;
        display: grid;
        gap: 28px;
    }

    .menu-detail-container {
        display: grid;
        grid-template-columns: minmax(0, 1.85fr) minmax(280px, 1fr);
        gap: 20px;
        max-width: 1100px;
        margin: 0 auto;
    }

    .detail-main-column {
        display: grid;
        gap: 18px;
    }

    .detail-side-column {
        align-self: start;
        max-width: 360px;
        display: grid;
        gap: 18px;
    }

    .detail-card {
        background: #ffffff;
        border-radius: 20px;
        box-shadow: 0 18px 40px rgba(15, 23, 42, 0.08);
        border: 1px solid rgba(15, 23, 42, 0.05);
        padding: 24px 26px;
    }

    .summary-card {
        min-width: 740px;
    }

    .detail-card.options-section,
    .detail-card.nutrition-section,
    .detail-card.allergen-section {
        padding: 24px 26px;
    }

    .options-section {
        /*margin-top: 20px;*/
    }

    .nutrition-section {
        /*margin-top: 20px;*/
    }

    .allergen-section {
        /*margin-top: 18px;*/
    }

    #dynamic-options-container {
        display: grid;
        gap: 14px;
    }

    .detail-card-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
    }

    .detail-card-header h3 {
        margin: 0;
        font-size: 18px;
        font-weight: 700;
        color: #1f2937;
    }

    .detail-card-header .serving-info {
        font-size: 12px;
        color: #6b7280;
        font-weight: 500;
    }

    .detail-card-header + * {
        margin-top: 12px;
    }

    /* 푸터 바닥 고정 스타일 */
    .footer {
        margin-top: auto; /* head.jspf의 flexbox 레이아웃에서 푸터를 하단에 고정 */
        background: rgba(255,255,255,0.9);
        border-top: 1px solid rgba(0,0,0,0.1);
    }


    /* 반응형 조정 */
    @media (max-width: 1024px) {
        .product-detail-main .product-shell {
            padding: 28px 24px 40px;
        }

        .menu-detail-container {
            grid-template-columns: 1fr;
        }

        .detail-main-column {
            order: 1;
        }

        .detail-side-column {
            order: 2;
            max-width: none;
        }

        .order-card {
            position: static;
        }
    }

    @media (max-width: 768px) {
        .product-detail-main .product-shell {
            padding: 24px 18px 32px;
        }

        .product-detail-main .pdcontainer {
            padding: 32px 20px 60px;
        }

        .menu-detail-container {
            flex-direction: column;
        }

        .detail-main-column,
        .detail-side-column {
            width: 100%;
        }

        .detail-side-column {
            order: 3;
            margin-top: 20px;
        }

        .detail-card {
            padding: 20px 18px;
        }

        .detail-card.options-section,
        .detail-card.nutrition-section,
        .detail-card.allergen-section {
            padding: 20px 18px;
        }

        .options-section {
            margin-top: 20px;
        }

        .nutrition-section {
            margin-top: 20px;
        }

        .allergen-section {
            margin-top: 16px;
        }
    }
</style>

<body class="product-detail-page">
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<c:set var="currentCategory" value="${not empty product ? fn:toUpperCase(product.categoryName) : 'ALL'}" />

<main class="product-page-main product-detail-main">
<%@ include file="/WEB-INF/views/product/product-category-nav.jspf" %>

<!-- 뒤로가기 버튼 -->

<div class="pdcontainer">
    <div class="page-header">
        <button class="back-btn" onclick="history.back()">←</button>
        <h1 class="page-title">메뉴 상세</h1>
    </div>

    <!-- 에러 메시지 표시 -->
    <c:if test="${not empty errorMessage}">
        <div class="error-message">
            <strong>오류:</strong> <c:out value="${errorMessage}" />
        </div>
    </c:if>

    <!-- 메뉴 상세 정보 -->
    <c:if test="${not empty product}">
        <div class="menu-detail-container">
            <div class="detail-main-column">
                <section class="detail-card summary-card">
                    <div class="summary-header">
                        <div class="menu-image-container">
                            <c:choose>
                                <c:when test="${not empty product.productPhoto}">
                                    <img src="${product.productPhoto}" alt="${product.productName}" class="menu-image">
                                </c:when>
                                <c:otherwise>
                                    <div class="menu-image no-image">이미지 없음</div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="menu-content">
                            <div class="menu-info-badge">
                                <div class="likes" onclick="toggleFavorite()">
                                    <span class="heart" id="favoriteHeart">♡</span>
                                    <span class="like-count">1천</span>
                                </div>
                                <div class="review-badge">리뷰 확인</div>
                            </div>
                            <div class="menu-header">
                                <h2 class="menu-title">${product.productName}</h2>
                                <div class="menu-price">
                                    <fmt:formatNumber value="${product.price}" pattern="#,###"/>원
                                </div>
                            </div>
                            <div class="menu-description">
                                <p><c:out value="${product.productContent}" /></p>
                            </div>

                            <c:if test="${not empty product.hashtags}">
                                <div class="category-tags">
                                    <c:forEach var="hashtag" items="${product.hashtags}">
                                        <span class="tag">${hashtag.hashtagName}</span>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </section>

                <c:if test="${not empty product.productOptions}">
                    <section class="detail-card options-section">
<%--                        <header class="detail-card-header">--%>
<%--                            <h3>옵션 선택</h3>--%>
<%--                        </header>--%>
                        <!-- JavaScript로 옵션 그룹핑 처리 -->
                        <script type="text/javascript">
                            // 서버에서 전달받은 옵션 데이터
                            var productOptionsData = [
                                <c:forEach var="option" items="${product.productOptions}" varStatus="status">
                                {
                                    productOptionId: ${option.optionId},
                                    optionStyleId: ${option.optionStyleId},
                                    optionName: '${fn:escapeXml(option.optionName)}',
                                    optionStyle: '${fn:escapeXml(option.optionStyleName)}',
                                    extraPrice: ${option.extraPrice}
                                }<c:if test="${!status.last}">,</c:if>
                                </c:forEach>
                            ];

                            // 옵션명별로 그룹화
                            var groupedOptions = {};
                            productOptionsData.forEach(function(option) {
                                if (!groupedOptions[option.optionName]) {
                                    groupedOptions[option.optionName] = [];
                                }
                                groupedOptions[option.optionName].push(option);
                            });

                            // DOM 로드 후 옵션 UI 생성
                            document.addEventListener('DOMContentLoaded', function() {
                                createOptionUI(groupedOptions);
                                initializeDefaultOptions();
                            });
                        </script>

                        <!-- 옵션 UI가 동적으로 생성될 컨테이너 -->
                        <div id="dynamic-options-container"></div>
                    </section>
                </c:if>

                <!-- 영양정보 섹션 -->
                <c:if test="${not empty product.nutritionInfo and product.categoryName != 'MD_GOODS'}">
                    <section class="detail-card nutrition-section">
                        <header class="detail-card-header">
                            <h3>영양정보</h3>
                            <span class="serving-info">1회 제공량 기준</span>
                        </header>
                        <div class="nutrition-grid">
                            <div class="nutrition-item">
                                <span class="nutrition-label">열량(kcal)</span>
                                <span class="nutrition-value">
                                    <fmt:formatNumber value="${product.nutritionInfo.calories}" pattern="#.#"/>
                                </span>
                            </div>
                            <div class="nutrition-item">
                                <span class="nutrition-label">나트륨 mg</span>
                                <span class="nutrition-value">
                                    <fmt:formatNumber value="${product.nutritionInfo.sodium}" pattern="#.##"/>
                                </span>
                            </div>
                            <div class="nutrition-item">
                                <span class="nutrition-label">단백질 g</span>
                                <span class="nutrition-value">
                                    <fmt:formatNumber value="${product.nutritionInfo.protein}" pattern="#.##"/>
                                </span>
                            </div>
                            <div class="nutrition-item">
                                <span class="nutrition-label">당류 g</span>
                                <span class="nutrition-value">
                                    <fmt:formatNumber value="${product.nutritionInfo.sugar}" pattern="#.#"/>
                                </span>
                            </div>
                            <div class="nutrition-item">
                                <span class="nutrition-label">지방 g</span>
                                <span class="nutrition-value">
                                    <fmt:formatNumber value="${product.nutritionInfo.fat}" pattern="#.#"/>
                                </span>
                            </div>
                            <div class="nutrition-item">
                                <span class="nutrition-label">카페인 mg</span>
                                <span class="nutrition-value">
                                    <fmt:formatNumber value="${product.nutritionInfo.caffeine}" pattern="#.#"/>
                                </span>
                            </div>
                            <div class="nutrition-item">
                                <span class="nutrition-label">콜레스테롤 mg</span>
                                <span class="nutrition-value">
                                    <fmt:formatNumber value="${product.nutritionInfo.cholesterol}" pattern="#"/>
                                </span>
                            </div>
                            <div class="nutrition-item">
                                <span class="nutrition-label">탄수화물 g</span>
                                <span class="nutrition-value">
                                    <fmt:formatNumber value="${product.nutritionInfo.carbohydrate}" pattern="#.##"/>
                                </span>
                            </div>
                            <div class="nutrition-item">
                                <span class="nutrition-label">트랜스지방 g</span>
                                <span class="nutrition-value">
                                    <fmt:formatNumber value="${product.nutritionInfo.transFat}" pattern="#.#"/>
                                </span>
                            </div>
                            <div class="nutrition-item">
                                <span class="nutrition-label">포화지방 g</span>
                                <span class="nutrition-value">
                                    <fmt:formatNumber value="${product.nutritionInfo.saturatedFat}" pattern="#.#"/>
                                </span>
                            </div>
                        </div>
                    </section>
                </c:if>

                <!-- 알레르기 유발 정보 섹션 -->
                <c:if test="${product.categoryName != 'MD_GOODS'}">
                    <section class="detail-card allergen-section">
                        <header class="detail-card-header">
                            <h3>알레르기 유발 정보</h3>
                        </header>
                        <c:choose>
                            <c:when test="${not empty product.allergens}">
                                <div class="allergen-grid">
                                    <c:forEach var="allergen" items="${product.allergens}">
                                        <div class="allergen-item">
                                            <span class="allergen-name">${allergen.allergenName}</span>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="no-allergen-message">
                                    <span class="no-allergen-text">알레르기 유발 성분이 없습니다</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </section>
                </c:if>
            </div>

            <!-- 수량 선택 및 주문 버튼 -->
            <aside class="detail-side-column">
                <section class="detail-card order-card">
                    <header class="detail-card-header">
                        <h3>총 가격</h3>
                    </header>
                    <div class="quantity-section">
<%--                        <div class="quantity-price-display">--%>
<%--                            <span class="price-label">총 가격:</span>--%>
                            <span class="total-price" id="totalPrice">0원</span>
<%--                        </div>--%>
                        <div class="quantity-controls">
                            <button class="quantity-btn minus" onclick="decreaseQuantity()">−</button>
                            <span class="quantity-display" id="quantity">1</span>
                            <button class="quantity-btn plus" onclick="increaseQuantity()">+</button>
                        </div>
                    </div>

                    <div class="action-buttons">
                        <button class="order-btn immediate" onclick="orderImmediately()">바로 주문하기</button>
                        <button class="order-btn cart" onclick="addToCartFromDetail()">담기</button>
                    </div>
                </section>
            </aside>
        </div>
    </c:if>

    <!-- 상품이 없을 때 -->
    <c:if test="${empty product}">
        <div class="no-product">
            <h3>상품을 찾을 수 없습니다.</h3>
            <p>요청하신 상품이 존재하지 않거나 삭제되었습니다.</p>
            <a href="${pageContext.request.contextPath}/products">→ 메뉴 목록으로 돌아가기</a>
        </div>
    </c:if>
</div>


<!-- 성공 메시지 팝업 -->
<div id="successMessage" class="success-message">장바구니에 담았습니다!</div>

<script src="${pageContext.request.contextPath}/js/menu.js"></script>

<script type="text/javascript">
    // 현재 상품 정보
    var currentProduct = {
        id: ${product.productId},
        name: '${fn:escapeXml(product.productName)}',
        price: ${product.price},
        photo: '${product.productPhoto}',
        description: '${fn:escapeXml(product.productContent)}'
    };

    var currentQuantity = 1;
    var selectedOptions = {}; // 선택된 옵션들을 저장
    var totalExtraPrice = 0; // 추가 가격 총합
    var isFavorite = false; // 즐겨찾기 상태

    // 동적으로 옵션 UI 생성
    function createOptionUI(groupedOptions) {
        const container = document.getElementById('dynamic-options-container');

        Object.keys(groupedOptions).forEach(optionName => {
            const options = groupedOptions[optionName];

            // 옵션 그룹 컨테이너 생성
            const optionGroup = document.createElement('div');
            optionGroup.className = 'option-group';

            // 옵션 제목 생성
            const title = document.createElement('h3');
            title.className = 'option-title';
            title.textContent = optionName;
            optionGroup.appendChild(title);

            if (optionName === '온도') {
                // 온도 옵션 특별 UI
                createTemperatureUI(optionGroup, options, optionName);
            } else {
                // 일반 옵션 UI
                createGeneralOptionUI(optionGroup, options, optionName);
            }

            container.appendChild(optionGroup);
        });
    }

    // 온도 옵션 UI 생성
    function createTemperatureUI(container, options, optionName) {
        // 온도 버튼들
        const tempButtons = document.createElement('div');
        tempButtons.className = 'temp-buttons';

        options.forEach((option, index) => {
            const button = document.createElement('button');
            button.className = 'temp-btn' + (index === 1 ? ' active' : '');
            button.dataset.productOptionId = option.productOptionId;
            button.dataset.optionId = option.optionStyleId;
            button.dataset.price = option.extraPrice;
            button.textContent = option.optionStyle;
            button.onclick = () => selectOption(button, optionName);
            tempButtons.appendChild(button);
        });

        container.appendChild(tempButtons);

        // 온도 상세 표시
        // const tempDetail = document.createElement('div');
        // tempDetail.className = 'temp-detail';
        //
        // options.forEach((option, index) => {
        //     const tempOption = document.createElement('div');
        //     tempOption.className = 'temp-option' + (index === 1 ? ' active' : '');
        //     tempOption.dataset.option = option.optionStyle;
        //
        //     if (option.optionStyle === 'ICE') {
        //         const icon = document.createElement('span');
        //         icon.className = 'temp-icon';
        //         icon.textContent = '❄';
        //         tempOption.appendChild(icon);
        //     }
        //
        //     const label = document.createElement('span');
        //     label.className = 'temp-label';
        //     label.textContent = option.optionStyle;
        //     tempOption.appendChild(label);
        //
        //     tempDetail.appendChild(tempOption);
        // });
        //
        // container.appendChild(tempDetail);
    }

    // 일반 옵션 UI 생성
    function createGeneralOptionUI(container, options, optionName) {
        const optionButtons = document.createElement('div');
        optionButtons.className = 'option-buttons-grid';

        // 텀블러 관련 옵션인지 확인
        const isTumblerOption = optionName.includes('텀블러') ||
                               options.some(opt => opt.optionStyle && opt.optionStyle.includes('텀블러'));

        options.forEach((option, index) => {
            const button = document.createElement('button');
            // 텀블러 옵션은 기본 선택하지 않음, 다른 옵션은 첫 번째를 기본 선택
            button.className = 'option-btn-card' + (!isTumblerOption && index === 0 ? ' active' : '');
            button.dataset.productOptionId = option.productOptionId;
            button.dataset.optionId = option.optionStyleId;
            button.dataset.price = option.extraPrice;
            button.dataset.isTumbler = isTumblerOption;
            button.onclick = () => isTumblerOption ? selectTumblerOption(button, optionName) : selectOptionCard(button, optionName);

            const optionText = document.createElement('div');
            optionText.className = 'option-text';
            optionText.textContent = option.optionStyle;
            button.appendChild(optionText);

            if (option.extraPrice > 0) {
                const priceSpan = document.createElement('div');
                priceSpan.className = 'extra-price-card';
                priceSpan.textContent = '(+' + option.extraPrice.toLocaleString() + '원)';
                button.appendChild(priceSpan);
            }

            optionButtons.appendChild(button);
        });

        container.appendChild(optionButtons);
    }

    // 텀블러 옵션 토글 함수
    function selectTumblerOption(button, optionName) {
        // 텀블러 옵션은 토글 가능 (on/off)
        const isCurrentlySelected = button.classList.contains('active');

        if (isCurrentlySelected) {
            // 현재 선택되어 있으면 해제
            button.classList.remove('active');
            delete selectedOptions[optionName];
        } else {
            // 현재 선택되어 있지 않으면 선택
            button.classList.add('active');
            selectedOptions[optionName] = {
                optionId: button.dataset.optionId,
                optionName: optionName,
                optionValue: button.textContent.trim().split('(')[0].trim(),
                extraPrice: parseInt(button.dataset.price) || 0
            };
        }

        // 총 가격 재계산
        calculateTotalPrice();
    }

    // 카드형 옵션 선택 함수
    function selectOptionCard(button, optionName) {
        const optionGroup = button.closest('.option-group');
        const buttons = optionGroup.querySelectorAll('.option-btn-card, .temp-btn');

        // 같은 그룹 내 다른 버튼들 비활성화
        buttons.forEach(btn => btn.classList.remove('active'));

        // 클릭된 버튼 활성화
        button.classList.add('active');

        // 온도 옵션의 경우 temp-detail도 업데이트
        if (optionName === '온도') {
            const tempOptions = optionGroup.querySelectorAll('.temp-option');
            tempOptions.forEach(option => option.classList.remove('active'));

            const selectedTemp = button.textContent.trim();
            const targetOption = optionGroup.querySelector('[data-option="' + selectedTemp + '"]');
            if (targetOption) {
                targetOption.classList.add('active');
            }

            // 주문 섹션의 온도 표시 업데이트
            const optionTempElement = document.querySelector('.option-temp');
            if (optionTempElement) {
                optionTempElement.textContent = selectedTemp;
            }
        }

        // 선택된 옵션 저장
        selectedOptions[optionName] = {
            optionId: button.dataset.optionId,
            optionName: optionName,
            optionValue: button.textContent.trim().split('(')[0].trim(), // 가격 부분 제거
            extraPrice: parseInt(button.dataset.price) || 0
        };

        // 총 추가 가격 계산
        calculateTotalPrice();
    }

    // 기본 옵션 초기화
    function initializeDefaultOptions() {
        const optionGroups = document.querySelectorAll('.option-group');
        optionGroups.forEach(group => {
            const firstButton = group.querySelector('.option-btn.active, .temp-btn.active, .option-btn-card.active');
            if (firstButton) {
                const optionTitle = group.querySelector('.option-title').textContent;
                // 텀블러 옵션은 기본 초기화에서 제외
                const isTumblerOption = firstButton.dataset.isTumbler === 'true';

                if (!isTumblerOption) {
                    selectedOptions[optionTitle] = {
                        optionId: firstButton.dataset.optionId,
                        optionName: optionTitle,
                        optionValue: firstButton.textContent.trim().split('+')[0].trim(),
                        extraPrice: parseInt(firstButton.dataset.price) || 0
                    };
                }
            }
        });

        calculateTotalPrice();
    }

    // 옵션 선택 함수 (기존)
    function selectOption(button, optionName) {
        selectOptionCard(button, optionName);
    }

    // 총 가격 계산
    function calculateTotalPrice() {
        totalExtraPrice = 0;
        Object.values(selectedOptions).forEach(option => {
            totalExtraPrice += option.extraPrice;
        });

        const finalPrice = (currentProduct.price + totalExtraPrice) * currentQuantity;
        const totalPriceElement = document.getElementById('totalPrice');
        if (totalPriceElement) {
            totalPriceElement.textContent = finalPrice.toLocaleString() + '원';
        }

        // 주문 섹션의 개별 가격도 업데이트
        const optionPriceElement = document.querySelector('.option-price');
        if (optionPriceElement) {
            optionPriceElement.textContent = (currentProduct.price + totalExtraPrice).toLocaleString() + '원';
        }
    }

    // 수량 증가
    function increaseQuantity() {
        currentQuantity++;
        document.getElementById('quantity').textContent = currentQuantity;
        const totalQuantityElement = document.getElementById('totalQuantity');
        if (totalQuantityElement) {
            totalQuantityElement.textContent = currentQuantity + '개';
        }
        calculateTotalPrice();
    }

    // 수량 감소
    function decreaseQuantity() {
        if (currentQuantity > 1) {
            currentQuantity--;
            document.getElementById('quantity').textContent = currentQuantity;
            const totalQuantityElement = document.getElementById('totalQuantity');
            if (totalQuantityElement) {
                totalQuantityElement.textContent = currentQuantity + '개';
            }
            calculateTotalPrice();
        }
    }

    // 현재 즐겨찾기 상태 확인
    function checkFavoriteStatus() {
        <c:if test="${pageContext.request.userPrincipal != null}">
            console.log('=== 즐겨찾기 상태 확인 시작 ===');

            fetch('${pageContext.request.contextPath}/users/favorites', {
                method: 'GET'
            })
            .then(response => {
                console.log('즐겨찾기 목록 응답 상태:', response.status);
                if (response.ok) {
                    return response.json();
                }
                throw new Error(`즐겨찾기 목록을 가져올 수 없습니다. 상태: ${response.status}`);
            })
            .then(data => {
                console.log('즐겨찾기 목록 응답 데이터:', data);

                // FavoriteListResponse 구조에 맞게 수정
                if (data && data.favorites && Array.isArray(data.favorites)) {
                    console.log('즐겨찾기 목록:', data.favorites);
                    console.log('현재 상품 ID:', currentProduct.id);

                    // 현재 상품이 즐겨찾기 목록에 있는지 확인
                    isFavorite = data.favorites.some(favorite => {
                        console.log('비교:', favorite.productId, '===', currentProduct.id);
                        return favorite.productId === currentProduct.id;
                    });

                    console.log('즐겨찾기 상태:', isFavorite);
                    updateFavoriteUI();
                } else {
                    console.log('즐겨찾기 목록이 없거나 형식이 잘못됨');
                    isFavorite = false;
                    updateFavoriteUI();
                }
            })
            .catch(error => {
                console.error('즐겨찾기 상태 확인 실패:', error);
                // 에러 시 기본값으로 설정
                isFavorite = false;
                updateFavoriteUI();
            });
        </c:if>
    }

    // 페이지 로드 시 기본 옵션 설정
    document.addEventListener('DOMContentLoaded', function() {
        // 각 옵션 그룹의 첫 번째 옵션을 기본 선택으로 설정
        const optionGroups = document.querySelectorAll('.option-group');
        optionGroups.forEach(group => {
            const firstButton = group.querySelector('.option-btn.active, .temp-btn.active');
            if (firstButton) {
                const optionTitle = group.querySelector('.option-title').textContent;
                selectedOptions[optionTitle] = {
                    optionId: firstButton.dataset.optionId,
                    optionName: optionTitle,
                    optionValue: firstButton.textContent.trim().split('+')[0].trim(),
                    extraPrice: parseInt(firstButton.dataset.price) || 0
                };
            }
        });

        calculateTotalPrice();
        checkFavoriteStatus(); // 즐겨찾기 상태 확인
    });

    // 선택된 옵션 ID들을 수집하는 함수
    function getSelectedOptionIds() {
        let optionIds = [];
        // 각 옵션 그룹에서 선택된 버튼의 productOptionId 수집
        document.querySelectorAll('.option-group .active').forEach(activeBtn => {
            if (activeBtn.dataset.productOptionId) {
                optionIds.push(parseInt(activeBtn.dataset.productOptionId));
            }
        });
        return optionIds;
    }

    // 장바구니에 담기
    function addToCartFromDetail() {
        console.log('=== 장바구니 추가 디버깅 ===');
        console.log('currentProduct:', currentProduct);
        console.log('currentQuantity:', currentQuantity);

        const selectedOptionIds = getSelectedOptionIds();
        console.log('selectedOptionIds:', selectedOptionIds);

        const formData = new FormData();
        formData.append('productId', currentProduct.id);
        formData.append('quantity', currentQuantity);

        // 선택된 옵션 ID들 추가
        selectedOptionIds.forEach(id => {
            formData.append('optionIds', id);
        });

        // FormData 내용 확인
        console.log('FormData 내용:');
        for (let [key, value] of formData.entries()) {
            console.log(key + ': ' + value);
        }

        // API 호출
        fetch('${pageContext.request.contextPath}/users/cart', {
            method: 'POST',
            body: formData
        })
        .then(response => {
            console.log('응답 상태:', response.status);
            console.log('응답 헤더:', response.headers);

            if (response.ok) {
                return response.json();
            } else {
                // 에러 응답 내용도 확인
                return response.text().then(text => {
                    console.error('에러 응답 내용:', text);
                    throw new Error(`HTTP ${response.status}: ${text}`);
                });
            }
        })
        .then(data => {
            console.log('장바구니 추가 성공:', data);
            showSuccessMessage('장바구니에 ' + currentProduct.name + ' ' + currentQuantity + '개를 담았습니다.');
        })
        .catch(error => {
            console.error('장바구니 추가 실패:', error);
            showSuccessMessage('장바구니 추가 중 오류가 발생했습니다: ' + error.message);
        });
    }

    // 성공 메시지 표시
    function showSuccessMessage(message) {
        const messageElement = document.getElementById('successMessage');
        messageElement.textContent = message;
        messageElement.style.display = 'block';

        setTimeout(() => {
            messageElement.style.display = 'none';
        }, 3000);
    }

    // 즐겨찾기 토글 함수
    function toggleFavorite() {
        // 로그인 상태 확인
        <c:choose>
            <c:when test="${pageContext.request.userPrincipal != null}">
                if (isFavorite) {
                    // 즐겨찾기 제거
                    removeFavorite();
                } else {
                    // 즐겨찾기 추가
                    addFavorite();
                }
            </c:when>
            <c:otherwise>
                alert('로그인이 필요한 서비스입니다.');
                return;
            </c:otherwise>
        </c:choose>
    }

    // CSRF 토큰 가져오기
    function getCSRFToken() {
        const token = document.querySelector('meta[name="_csrf"]');
        const header = document.querySelector('meta[name="_csrf_header"]');

        const tokenValue = token ? token.getAttribute('content') : null;
        const headerName = header ? header.getAttribute('content') : 'X-CSRF-TOKEN';

        console.log('🔑 CSRF 토큰 상태:', {
            tokenExists: !!tokenValue,
            headerName: headerName,
            token: tokenValue ? tokenValue.substring(0, 10) + '...' : 'null'
        });

        return {
            token: tokenValue,
            header: headerName
        };
    }

    // 즐겨찾기 추가
    function addFavorite() {
        console.log('=== 즐겨찾기 추가 시작 ===');
        console.log('상품 ID:', currentProduct.id);

        const requestData = {
            productId: currentProduct.id
        };

        const csrf = getCSRFToken();
        const headers = {
            'Content-Type': 'application/json'
        };

        // CSRF 토큰이 있으면 헤더에 추가
        if (csrf.token) {
            headers[csrf.header] = csrf.token;
            console.log('✅ CSRF 토큰 추가됨:', csrf.header);
        } else {
            console.warn('⚠️ CSRF 토큰이 없습니다. 요청이 실패할 수 있습니다.');
        }

        console.log('요청 데이터:', requestData);
        console.log('요청 헤더:', headers);

        fetch('${pageContext.request.contextPath}/users/favorites', {
            method: 'POST',
            headers: headers,
            body: JSON.stringify(requestData)
        })
        .then(response => {
            console.log('응답 상태:', response.status, response.statusText);
            if (response.ok) {
                return response.json();
            } else {
                return response.text().then(text => {
                    console.error('즐겨찾기 추가 실패:', text);

                    // HTTP 상태 코드별 에러 메시지
                    let errorMessage;
                    switch (response.status) {
                        case 401:
                            errorMessage = '로그인이 필요합니다.';
                            break;
                        case 403:
                            errorMessage = 'CSRF 토큰 오류입니다. 페이지를 새로고침한 후 다시 시도해주세요.';
                            break;
                        case 404:
                            errorMessage = '상품을 찾을 수 없습니다.';
                            break;
                        case 500:
                            errorMessage = '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';
                            break;
                        default:
                            errorMessage = `요청 실패 (${response.status}): ${text}`;
                    }

                    throw new Error(errorMessage);
                });
            }
        })
        .then(data => {
            console.log('즐겨찾기 추가 응답:', data);

            // AuthResponse 구조: { success: boolean, message: string }
            if (data.success === true) {
                console.log('즐겨찾기 추가 성공');
                isFavorite = true;
                updateFavoriteUI();
                showSuccessMessage('즐겨찾기에 추가되었습니다.');
            } else {
                console.log('즐겨찾기 추가 실패:', data.message);
                showSuccessMessage(data.message || '즐겨찾기 추가 중 오류가 발생했습니다.');
            }
        })
        .catch(error => {
            console.error('즐겨찾기 추가 실패:', error);

            // 네트워크 오류 vs API 응답 오류 구분
            if (error.message.includes('Failed to fetch') || error.message.includes('NetworkError')) {
                showSuccessMessage('네트워크 연결을 확인해주세요.');
            } else {
                showSuccessMessage(error.message);
            }
        });
    }

    // 즐겨찾기 제거
    function removeFavorite() {
        console.log('=== 즐겨찾기 제거 시작 ===');
        console.log('상품 ID:', currentProduct.id);

        const csrf = getCSRFToken();
        const headers = {};

        // CSRF 토큰이 있으면 헤더에 추가
        if (csrf.token) {
            headers[csrf.header] = csrf.token;
            console.log('✅ CSRF 토큰 추가됨:', csrf.header);
        } else {
            console.warn('⚠️ CSRF 토큰이 없습니다. 요청이 실패할 수 있습니다.');
        }

        console.log('요청 헤더:', headers);

        fetch('${pageContext.request.contextPath}/users/favorites/' + currentProduct.id, {
            method: 'DELETE',
            headers: headers
        })
        .then(response => {
            console.log('응답 상태:', response.status, response.statusText);
            if (response.ok) {
                return response.json();
            } else {
                return response.text().then(text => {
                    console.error('즐겨찾기 제거 실패:', text);

                    // HTTP 상태 코드별 에러 메시지
                    let errorMessage;
                    switch (response.status) {
                        case 401:
                            errorMessage = '로그인이 필요합니다.';
                            break;
                        case 403:
                            errorMessage = 'CSRF 토큰 오류입니다. 페이지를 새로고침한 후 다시 시도해주세요.';
                            break;
                        case 404:
                            errorMessage = '상품이나 즐겨찾기를 찾을 수 없습니다.';
                            break;
                        case 500:
                            errorMessage = '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';
                            break;
                        default:
                            errorMessage = `요청 실패 (${response.status}): ${text}`;
                    }

                    throw new Error(errorMessage);
                });
            }
        })
        .then(data => {
            console.log('즐겨찾기 제거 응답:', data);

            // AuthResponse 구조: { success: boolean, message: string }
            if (data.success === true) {
                console.log('즐겨찾기 제거 성공');
                isFavorite = false;
                updateFavoriteUI();
                showSuccessMessage('즐겨찾기에서 제거되었습니다.');
            } else {
                console.log('즐겨찾기 제거 실패:', data.message);
                showSuccessMessage(data.message || '즐겨찾기 제거 중 오류가 발생했습니다.');
            }
        })
        .catch(error => {
            console.error('즐겨찾기 제거 실패:', error);

            // 네트워크 오류 vs API 응답 오류 구분
            if (error.message.includes('Failed to fetch') || error.message.includes('NetworkError')) {
                showSuccessMessage('네트워크 연결을 확인해주세요.');
            } else {
                showSuccessMessage(error.message);
            }
        });
    }

    // 즐겨찾기 UI 업데이트
    function updateFavoriteUI() {
        const heartElement = document.getElementById('favoriteHeart');
        if (isFavorite) {
            heartElement.textContent = '♥';
            heartElement.style.color = '#ff69b4';
        } else {
            heartElement.textContent = '♡';
            heartElement.style.color = '#ff69b4';
        }
    }

    // 검색 모달 관련 함수
    function showSearchModal() {
        document.getElementById('searchModal').style.display = 'block';
    }

    function hideSearchModal() {
        document.getElementById('searchModal').style.display = 'none';
    }

    // 장바구니 토글
    function toggleCart() {
        if (typeof window.toggleCartHandler === 'function') {
            window.toggleCartHandler();
        }
    }

    // 주문하기
    function placeOrder() {
        if (typeof window.placeOrderHandler === 'function') {
            window.placeOrderHandler();
        }
    }

    // 모달 외부 클릭시 닫기
    window.onclick = function(event) {
        const modal = document.getElementById('searchModal');
        if (event.target == modal) {
            modal.style.display = 'none';
        }
    }
</script>

<style>
    /* 메뉴 상세 페이지 전용 스타일 */
    .product-detail-main .page-header {
        display: flex;
        align-items: center;
        justify-content: flex-start;
        padding-top: 0;
        margin-bottom: 20px;
    }

    .product-detail-main .page-title {
        font-size: 24px;
        font-weight: bold;
        color: #333;
        margin: 0;
        text-align: left;
    }

    .back-btn {
        background: none;
        border: none;
        font-size: 24px;
        cursor: pointer;
        padding: 10px;
        margin-right: 10px;
    }

    .back-btn:hover {
        background: #f8f9fa;
        border-radius: 50%;
    }

    .error-message {
        background: #ffe6e6;
        padding: 15px;
        border-radius: 8px;
        margin-bottom: 20px;
        color: #d00;
    }

    .no-product {
        text-align: center;
        padding: 100px 20px;
        color: #666;
    }

    .no-product a {
        color: #ff6b9d;
        text-decoration: none;
    }

    /* 2열 레이아웃 */
    .menu-detail-container {
        display: flex;
        gap: 15px;
        max-width: 1000px;
        margin: 0 auto;
        /*padding: 20px 10px; !* 양쪽 여백을 20px에서 10px로 줄임 *!*/
    }

    /* 요약 카드 */
    .summary-card .summary-header {
        display: flex;
        align-items: flex-start;
        gap: 24px;
    }

    .summary-card .menu-image-container {
        position: relative;
        flex-shrink: 0;
        width: 220px;
    }

    .summary-card .menu-image {
        width: 100%;
        height: 220px;
        object-fit: cover;
        border-radius: 16px;
        background: none;
        box-shadow: none;
    }

    .summary-card .menu-image.no-image {
        display: flex;
        align-items: center;
        justify-content: center;
        color: #666;
        font-size: 16px;
    }

    .summary-card .menu-content {
        flex: 1;
        min-width: 0;
        padding-top: 6px;
    }

    .menu-info-badge {
        margin-top: 15px;
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .product-detail-main .menu-content {
        flex: 1 1 0%;
        min-width: 0;
    }

    .product-detail-main .menu-title,
    .product-detail-main .menu-price,
    .product-detail-main .menu-description p {
        writing-mode: horizontal-tb;
        white-space: normal;
        word-break: keep-all;
    }

    /* 메뉴 태그 위치 조정 */
    .menu-tag {
        position: absolute;
        /*top: 10px;*/
        left: 10px;
        padding: 4px 8px;
        border-radius: 12px;
        font-size: 11px;
        font-weight: 600;
        color: white;
        z-index: 1;
    }

    .tag-signature {
        background: #ff6b9d;
    }

    .tag-decaf {
        background: #28a745;
    }

    .tag-premium {
        background: #ffc107;
        color: #333;
    }

    .likes {
        display: flex;
        align-items: center;
        gap: 5px;
        margin-bottom: 10px;
        cursor: pointer;
        transition: transform 0.2s ease;
    }

    .likes:hover {
        transform: scale(1.05);
    }

    .likes:active {
        transform: scale(0.95);
    }

    .heart {
        color: #ff69b4;
        font-size: 16px;
    }

    .like-count {
        font-size: 14px;
        color: #666;
    }

    .review-badge {
        background: #ff6b9d;
        color: white;
        padding: 4px 8px;
        border-radius: 12px;
        font-size: 12px;
        font-weight: 600;
        display: inline-block;
        margin-left: auto;
    }

    .menu-header {
        margin-bottom: 20px;
    }

    .menu-title {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 10px;
        color: #333;
    }

    .menu-price {
        font-size: 20px;
        color: #ff6b9d;
        font-weight: bold;
    }

    .menu-description {
        margin-bottom: 20px;
    }

    .menu-description p {
        font-size: 14px;
        color: #666;
        line-height: 1.4;
        margin: 0 0 15px 0;
    }

    .menu-origin {
        display: flex;
        align-items: center;
        gap: 5px;
        font-size: 13px;
        color: #999;
    }

    .info-icon {
        width: 14px;
        height: 14px;
        border-radius: 50%;
        background: #ccc;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 10px;
    }

    .category-tags {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        margin: 12px 0 0;
    }

    .tag {
        background: #f5f5f5;
        color: #666;
        padding: 6px 12px;
        border-radius: 16px;
        font-size: 12px;
        border: 1px solid #e0e0e0;
    }

    /* 오른쪽 주문 섹션 */
    .order-card {
        position: sticky;
        top: 120px;
        padding: 24px 24px;
    }

    .order-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 20px;
        border-bottom: 1px solid #f0f0f0;
    }

    .order-header h3 {
        font-size: 18px;
        font-weight: 600;
        color: #333;
        margin: 0;
    }

    .delete-btn {
        background: none;
        border: none;
        color: #999;
        font-size: 14px;
        cursor: pointer;
    }

    .selected-menu {
        padding: 20px;
        border-bottom: 1px solid #f0f0f0;
    }

    .menu-item-row {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
    }

    .menu-item-info {
        flex: 1;
    }

    .menu-name {
        font-size: 16px;
        font-weight: 600;
        color: #333;
        display: block;
        margin-bottom: 8px;
    }

    .menu-options {
        display: flex;
        flex-direction: column;
        gap: 4px;
    }

    .option-price {
        font-size: 14px;
        color: #666;
    }

    .option-temp {
        font-size: 12px;
        color: #999;
    }

    .option-change {
        font-size: 12px;
        color: #ff6b9d;
        cursor: pointer;
        text-decoration: underline;
    }

    .quantity-section {
        display: flex;
        flex-direction: column;
        gap: 18px;
        padding: 22px 18px;
        border-bottom: 1px solid #f0f0f0;
        margin: 10px 0;
    }

    .quantity-controls {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 15px;
    }

    .quantity-btn {
        width: 40px;
        height: 40px;
        border: 2px solid #ddd;
        background: white;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
        font-weight: 600;
        color: #666;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .quantity-btn:hover {
        background: #f5f5f5;
        border-color: #ff6b9d;
        color: #ff6b9d;
    }

    .quantity-btn:active {
        transform: scale(0.95);
    }

    .quantity-display {
        font-size: 18px;
        font-weight: 600;
        color: #333;
        min-width: 40px;
        text-align: center;
        padding: 8px 16px;
        background: #f8f9fa;
        border-radius: 8px;
        border: 2px solid #e9ecef;
    }

    .quantity-price-display {
        text-align: center;
        padding: 16px 20px;
        background: #fff5f8;
        border-radius: 8px;
        border: 1px solid #ffe0e8;
        margin: 5px 0;
    }

    .price-label {
        font-size: 14px;
        color: #666;
        margin-right: 8px;
    }

    .total-price {
        font-size: 18px;
        font-weight: 700;
        color: #ff6b9d;
    }

    .additional-items {
        padding: 20px;
        border-bottom: 1px solid #f0f0f0;
    }

    .additional-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
    }

    .additional-item:last-child {
        margin-bottom: 0;
        flex-direction: column;
        align-items: flex-start;
    }

    .item-name {
        font-size: 14px;
        color: #333;
    }

    .item-count {
        font-size: 14px;
        color: #666;
    }

    .item-note {
        font-size: 12px;
        color: #999;
        margin-top: 4px;
    }

    .total-section {
        padding: 20px;
        text-align: center;
    }

    .total-price {
        font-size: 24px;
        font-weight: bold;
        color: #ff6b9d;
    }

    .order-btn {
        flex: 1;
        padding: 16px;
        border: none;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: background 0.3s ease;
    }

    :root {
        --pink-1: #ffb6c1; /* 연핑크 */
        --pink-2: #ff69b4; /* 핫핑크 */
    }

    .order-btn.immediate {
        background: #ff6b9d;
        color: white;
        border-radius: 12px 0 0 12px;
    }

    .order-btn.immediate:hover {
        background: linear-gradient(135deg, var(--pink-1), var(--pink-2));
        box-shadow: 0 8px 16px rgba(255, 122, 162, 0.35);
    }

    .order-btn.cart {
        background: #f8f9fa;
        color: #333;
        border: 2px solid #ddd;
        border-radius: 0 12px 12px 0;
        border-left: 1px solid #ddd;
    }

    .order-btn.cart:hover {
        background: #e9ecef;
    }

    .action-buttons {
        display: flex;
        width: 100%;
    }

    .success-message {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: #28a745;
        color: white;
        padding: 15px 30px;
        border-radius: 8px;
        font-weight: bold;
        z-index: 10000;
        box-shadow: 0 4px 15px rgba(0,0,0,0.3);
    }

    /* 모달 스타일 */
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.5);
    }

    .modal-content {
        background-color: white;
        margin: 15% auto;
        padding: 20px;
        border-radius: 10px;
        width: 80%;
        max-width: 500px;
    }

    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        cursor: pointer;
    }

    .modal-content form {
        margin-top: 20px;
    }

    .modal-content input {
        width: 80%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    .modal-content button {
        width: 15%;
        padding: 10px;
        background: #ff6b9d;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
        .menu-detail-container {
            grid-template-columns: 1fr;
            gap: 24px;
        }

        .detail-card {
            padding: 24px 20px;
        }

        .summary-card .summary-header {
            flex-direction: column;
            text-align: center;
            gap: 20px;
        }

        .summary-card .menu-image-container {
            margin: 0 auto;
            width: 180px;
        }

        .summary-card .menu-image {
            height: 200px;
        }

        .summary-card .menu-content {
            padding-top: 0;
        }

        .menu-title {
            font-size: 20px;
        }

        .menu-price {
            font-size: 18px;
        }

        .detail-side-column {
            position: static;
        }

        .order-card {
            position: static;
        }

        .detail-card.options-section,
        .detail-card.nutrition-section,
        .detail-card.allergen-section {
            padding: 24px 20px;
        }
    }

    /* 영양정보 섹션 */
    .nutrition-section h3 {
        margin: 0;
    }

    .nutrition-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 10px;
    }

    .nutrition-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px;
        background: white;
        border: 1px solid #e0e0e0;
        border-radius: 6px;
        transition: all 0.2s ease;
    }

    .nutrition-item:hover {
        border-color: #ff6b9d;
        background: #fff5f8;
    }

    .nutrition-label {
        font-size: 13px;
        color: #666;
        font-weight: 500;
    }

    .nutrition-value {
        font-size: 13px;
        color: #333;
        font-weight: 600;
    }

    /* 옵션 섹션 */
    .option-group {
        margin-bottom: 25px;
    }

    .option-group:last-child {
        margin-bottom: 0;
    }

    .option-title {
        font-size: 16px;
        font-weight: 600;
        color: #333;
        margin: 0 0 15px 0;
        padding-bottom: 8px;
        border-bottom: 1px solid #e0e0e0;
    }

    /* 온도 옵션 스타일 */
    .temp-buttons {
        display: flex;
        gap: 10px;
        margin-bottom: 15px;
    }

    .temp-btn {
        flex: 1;
        padding: 12px 16px;
        border: 2px solid #e0e0e0;
        background: white;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 500;
        color: #666;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .temp-btn:hover {
        border-color: #ff6b9d;
        background: #fff5f8;
        color: #ff6b9d;
    }

    .temp-btn.active {
        border-color: #ff6b9d;
        background: #ff6b9d;
        color: white;
        box-shadow: 0 2px 8px rgba(255, 107, 157, 0.3);
    }

    .temp-detail {
        display: flex;
        gap: 10px;
    }

    .temp-option {
        flex: 1;
        padding: 12px;
        background: white;
        border: 1px solid #e0e0e0;
        border-radius: 6px;
        text-align: center;
        opacity: 0.5;
        transition: all 0.3s ease;
    }

    .temp-option.active {
        opacity: 1;
        border-color: #ff6b9d;
        background: #fff5f8;
    }

    .temp-icon {
        font-size: 18px;
        display: block;
        margin-bottom: 4px;
    }

    .temp-label {
        font-size: 12px;
        color: #666;
        font-weight: 500;
    }

    /* 일반 옵션 카드 스타일 */
    .option-buttons-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 10px;
    }

    .option-btn-card {
        padding: 15px 12px;
        border: 2px solid #e0e0e0;
        background: white;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
        text-align: center;
        min-height: 60px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .option-btn-card:hover {
        border-color: #ff6b9d;
        background: #fff5f8;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(255, 107, 157, 0.15);
    }

    .option-btn-card.active {
        border-color: #ff6b9d;
        background: #ff6b9d;
        color: white;
        box-shadow: 0 4px 12px rgba(255, 107, 157, 0.3);
    }

    .option-text {
        font-size: 14px;
        font-weight: 500;
        margin-bottom: 4px;
    }

    .option-btn-card.active .option-text {
        color: white;
    }

    .extra-price-card {
        font-size: 12px;
        opacity: 0.8;
        font-weight: 400;
    }

    .option-btn-card.active .extra-price-card {
        color: white;
    }

    /* 텀블러 옵션 전용 스타일 */
    .option-btn-card[data-is-tumbler="true"] {
        border-style: dashed;
        position: relative;
    }

    .option-btn-card[data-is-tumbler="true"]:before {
        content: "선택사항";
        position: absolute;
        top: -8px;
        right: -8px;
        background: #17a2b8;
        color: white;
        font-size: 10px;
        padding: 2px 6px;
        border-radius: 8px;
        line-height: 1;
    }

    .option-btn-card[data-is-tumbler="true"]:not(.active) {
        background: #f8f9fa;
        border-color: #dee2e6;
        opacity: 0.7;
    }

    .option-btn-card[data-is-tumbler="true"].active {
        background: #17a2b8;
        border-color: #17a2b8;
        color: white;
        opacity: 1;
    }

    .option-btn-card[data-is-tumbler="true"].active .option-text {
        color: white;
    }

    .option-btn-card[data-is-tumbler="true"].active .extra-price-card {
        color: white;
    }

    .allergen-section h3 {
        margin: 0;
    }

    .allergen-grid {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
    }

    .allergen-item {
        padding: 8px 12px;
        background: #fff3cd;
        border: 1px solid #ffeaa7;
        border-radius: 16px;
        display: inline-flex;
        align-items: center;
        transition: all 0.2s ease;
    }

    .allergen-item:hover {
        background: #fff8e1;
        transform: translateY(-1px);
        box-shadow: 0 2px 8px rgba(255, 193, 7, 0.2);
    }

    .allergen-name {
        font-size: 13px;
        color: #8b5a00;
        font-weight: 500;
    }

    .no-allergen-message {
        text-align: center;
        padding: 20px;
        background: rgba(255,122,162,0.12);
        /*border: 1px solid #e0e0e0;*/
        border-radius: 6px;
    }

    .no-allergen-text {
        font-size: 14px;
        color: #666;
        font-weight: 500;
    }

    /* 반응형 - 모바일에서 그리드 조정 */
    @media (max-width: 768px) {
        .nutrition-grid {
            grid-template-columns: 1fr;
        }

        .detail-card.options-section,
        .detail-card.nutrition-section,
        .detail-card.allergen-section {
            padding: 20px 18px;
        }

        .options-section {
            margin-top: 18px;
        }

        .nutrition-section {
            margin-top: 18px;
        }

        .allergen-section {
            margin-top: 14px;
        }

        .allergen-grid {
            gap: 6px;
        }

        .allergen-item {
            padding: 6px 10px;
        }

        .allergen-name {
            font-size: 12px;
        }

        .option-buttons-grid {
            grid-template-columns: 1fr;
        }

        .temp-buttons {
            flex-direction: column;
        }

        .temp-detail {
            flex-direction: column;
        }

        .options-section {
            margin-top: 18px;
        }
    }
</style>

</main>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
