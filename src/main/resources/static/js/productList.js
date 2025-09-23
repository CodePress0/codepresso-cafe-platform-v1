// 상품 목록 페이지 JavaScript

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', function() {
    loadProductList();
    initializeCategoryButtons();
});

// 카테고리 버튼 초기화
function initializeCategoryButtons() {
    const categoryButtons = document.querySelectorAll('.category-btn');
    categoryButtons.forEach(btn => {
        btn.addEventListener('click', function() {
            const category = this.getAttribute('data-category');
            selectCategory(category);
            loadProductList(category);
        });
    });
}

// 카테고리 선택
function selectCategory(category) {
    const categoryButtons = document.querySelectorAll('.category-btn');
    categoryButtons.forEach(btn => {
        if (btn.getAttribute('data-category') === category) {
            btn.classList.add('active');
        } else {
            btn.classList.remove('active');
        }
    });
}

// 상품 목록 로드
function loadProductList(category = 'COFFEE') {
    showLoadingState();

    fetch(`/api/products?category=${category}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to load products');
            }
            return response.json();
        })
        .then(products => {
            updateProductListUI(products);
            hideLoadingState();
        })
        .catch(error => {
            console.error('Error loading products:', error);
            showErrorMessage('상품 목록을 불러올 수 없습니다.');
            hideLoadingState();
        });
}

// 상품 목록 UI 업데이트
function updateProductListUI(products) {
    const productContainer = document.querySelector('.product-container, .products-grid');
    if (!productContainer) return;

    productContainer.innerHTML = '';

    products.forEach(product => {
        const productElement = createProductElement(product);
        productContainer.appendChild(productElement);
    });
}

// 상품 요소 생성
function createProductElement(product) {
    const productDiv = document.createElement('div');
    productDiv.className = 'product-item';
    productDiv.innerHTML = `
        <div class="product-image-container">
            <img src="${product.productPhoto || '/images/default-product.jpg'}"
                 alt="${product.productName}" class="product-image">
        </div>
        <div class="product-info">
            <h3 class="product-name">${product.productName}</h3>
            <p class="product-price">${product.price.toLocaleString()}원</p>
        </div>
    `;

    // 클릭 이벤트 추가
    productDiv.addEventListener('click', function() {
        window.location.href = `/products/${product.id}`;
    });

    return productDiv;
}

// 로딩 상태 표시
function showLoadingState() {
    const productContainer = document.querySelector('.product-container, .products-grid');
    if (productContainer) {
        productContainer.innerHTML = '<div class="loading">상품을 불러오는 중...</div>';
    }
}

// 로딩 상태 해제
function hideLoadingState() {
    // 실제 상품 데이터로 대체되므로 별도 처리 불필요
}

// 에러 메시지 표시
function showErrorMessage(message) {
    const errorToast = document.createElement('div');
    errorToast.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: #f44336;
        color: white;
        padding: 12px 20px;
        border-radius: 8px;
        z-index: 10000;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        font-size: 14px;
        font-weight: 500;
    `;
    errorToast.textContent = message;

    document.body.appendChild(errorToast);

    setTimeout(() => {
        if (errorToast.parentNode) {
            errorToast.parentNode.removeChild(errorToast);
        }
    }, 3000);
}