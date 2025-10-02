// ================================================
// PRODUCT SEARCH PAGE JAVASCRIPT
// ================================================

// 전역 변수
let currentTab = 'keyword';
let recentSearches = [];
let selectedFilters = {
    beverage: [],
    temperature: [],
    taste: [],
    fruit: [],
    brand: []
};

// ================================================
// 1. 초기화 함수
// ================================================
function initializeSearch() {
    console.log('검색 페이지 초기화');
    loadRecentSearches();
}

// ================================================
// 2. 탭 전환
// ================================================
function switchTab(tabName) {
    currentTab = tabName;

    // 탭 버튼 활성화 상태 변경
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.classList.remove('active');
    });
    event.target.classList.add('active');

    // 탭 컨텐츠 표시/숨김
    document.querySelectorAll('.tab-content').forEach(content => {
        content.classList.remove('active');
    });

    if (tabName === 'keyword') {
        document.getElementById('keywordTab').classList.add('active');
    } else {
        document.getElementById('featureTab').classList.add('active');
    }

    // 검색 결과 초기화
    resetSearchResults();
}

// ================================================
// 3. 검색 기능
// ================================================
function performSearch() {
    const searchInput = document.getElementById('searchInput');
    const keyword = searchInput.value.trim();

    if (keyword === '') {
        alert('검색어를 입력해주세요.');
        return;
    }

    // 최근 검색어에 추가
    addToRecentSearches(keyword);

    // 검색 실행
    searchProducts(keyword);
}

function handleSearchKeyPress(event) {
    if (event.key === 'Enter') {
        performSearch();
    }
}

async function searchProducts(keyword) {
    console.log('검색 실행:', keyword);

    // 랜덤 추천 섹션 숨기기
    hideRecommendSection();

    try {
        // API 호출
        const formData = new URLSearchParams();
        formData.append('keyword', keyword);

        const response = await fetch(`${contextPath}/api/products/search/keyword`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: formData
        });

        if (!response.ok) {
            throw new Error('검색 요청에 실패했습니다.');
        }

        const results = await response.json();
        displaySearchResults(results);
    } catch (error) {
        console.error('검색 오류:', error);
        alert('검색 중 오류가 발생했습니다.');
    }
}

// ================================================
// 4. 최근 검색어 관리
// ================================================
function loadRecentSearches() {
    const saved = localStorage.getItem('recentSearches');
    if (saved) {
        recentSearches = JSON.parse(saved);
        displayRecentSearches();
    }
}

function addToRecentSearches(keyword) {
    // 중복 제거
    recentSearches = recentSearches.filter(item => item !== keyword);

    // 맨 앞에 추가
    recentSearches.unshift(keyword);

    // 최대 10개까지만 유지
    if (recentSearches.length > 10) {
        recentSearches = recentSearches.slice(0, 10);
    }

    // 로컬 스토리지에 저장
    localStorage.setItem('recentSearches', JSON.stringify(recentSearches));

    displayRecentSearches();
}

function displayRecentSearches() {
    const container = document.getElementById('recentSearchTags');

    if (recentSearches.length === 0) {
        container.innerHTML = '<p style="color: #999; font-size: 14px;">최근 검색어가 없습니다.</p>';
        return;
    }

    container.innerHTML = recentSearches.map(keyword => `
        <span class="search-tag" onclick="searchFromRecent('${keyword}')">
            ${keyword}
            <span class="remove-tag" onclick="removeRecentSearch(event, '${keyword}')">×</span>
        </span>
    `).join('');
}

function searchFromRecent(keyword) {
    document.getElementById('searchInput').value = keyword;
    searchProducts(keyword);
}

function removeRecentSearch(event, keyword) {
    event.stopPropagation();
    recentSearches = recentSearches.filter(item => item !== keyword);
    localStorage.setItem('recentSearches', JSON.stringify(recentSearches));
    displayRecentSearches();
}

// ================================================
// 5. 랜덤 추천
// ================================================
async function getRandomRecommendation() {
    try {
        // 모든 카테고리의 상품 가져오기
        const categories = ['COFFEE', 'LATTE', 'JUICE', 'SMOOTHIE', 'TEA', 'FOOD', 'SET', 'MD_GOODS'];
        const randomCategory = categories[Math.floor(Math.random() * categories.length)];

        const response = await fetch(`${contextPath}/api/products?category=${randomCategory}`);

        if (!response.ok) {
            throw new Error('상품 조회에 실패했습니다.');
        }

        const products = await response.json();

        if (products.length === 0) {
            alert('추천할 상품이 없습니다.');
            return;
        }

        const randomIndex = Math.floor(Math.random() * products.length);
        const randomProduct = products[randomIndex];

        displaySearchResults([randomProduct]);

        // 추천 결과로 스크롤
        document.getElementById('searchResults').scrollIntoView({
            behavior: 'smooth',
            block: 'start'
        });
    } catch (error) {
        console.error('랜덤 추천 오류:', error);
        alert('추천 중 오류가 발생했습니다.');
    }
}

// ================================================
// 6. 필터 관리
// ================================================
function toggleFilter(element) {
    const category = element.dataset.category;
    const value = element.dataset.value;

    element.classList.toggle('selected');

    if (element.classList.contains('selected')) {
        if (!selectedFilters[category].includes(value)) {
            selectedFilters[category].push(value);
        }
    } else {
        selectedFilters[category] = selectedFilters[category].filter(item => item !== value);
    }

    console.log('선택된 필터:', selectedFilters);
}

function resetFilter(category) {
    selectedFilters[category] = [];

    // UI 업데이트
    document.querySelectorAll(`.filter-tag[data-category="${category}"]`).forEach(tag => {
        tag.classList.remove('selected');
    });
}

async function applyFilters() {
    console.log('필터 적용:', selectedFilters);

    // 선택된 필터가 없으면 경고
    const hasSelectedFilters = Object.values(selectedFilters).some(arr => arr.length > 0);
    if (!hasSelectedFilters) {
        alert('하나 이상의 특징을 선택해주세요.');
        return;
    }

    // 랜덤 추천 섹션 숨기기
    hideRecommendSection();

    try {
        // 첫 번째 선택된 해시태그로 검색
        let firstHashtag = null;
        for (const category in selectedFilters) {
            if (selectedFilters[category].length > 0) {
                firstHashtag = selectedFilters[category][0];
                break;
            }
        }

        if (!firstHashtag) {
            alert('필터를 선택해주세요.');
            return;
        }

        // API 호출
        const formData = new URLSearchParams();
        formData.append('hashtag', firstHashtag);

        const response = await fetch(`${contextPath}/api/products/search/hashtag`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: formData
        });

        if (!response.ok) {
            throw new Error('필터 검색에 실패했습니다.');
        }

        let results = await response.json();

        // 클라이언트 사이드에서 추가 필터링 (나머지 선택된 필터들)
        results = results.filter(product => {
            for (const category in selectedFilters) {
                const filterValues = selectedFilters[category];
                if (filterValues.length > 0) {
                    // 상품이 해당 카테고리의 필터 중 하나라도 만족해야 함
                    const matches = filterValues.some(filterValue => {
                        // ProductListResponse에는 hashtags가 없을 수 있으므로 이름으로 체크
                        return product.productName && product.productName.includes(filterValue);
                    });
                    if (!matches) {
                        return false;
                    }
                }
            }
            return true;
        });

        displaySearchResults(results);

        // 결과로 스크롤
        document.getElementById('searchResults').scrollIntoView({
            behavior: 'smooth',
            block: 'start'
        });
    } catch (error) {
        console.error('필터 적용 오류:', error);
        alert('필터 적용 중 오류가 발생했습니다.');
    }
}

// ================================================
// 7. 검색 결과 표시
// ================================================
function displaySearchResults(results) {
    const emptyState = document.getElementById('emptyState');
    const resultsList = document.getElementById('resultsList');

    if (results.length === 0) {
        emptyState.style.display = 'block';
        resultsList.style.display = 'none';
        emptyState.innerHTML = `
            <div class="mascot-large">
                <img src="/banners/mascot.png" alt="Mascot" />
            </div>
            <p class="empty-message">검색 결과가 없습니다.<br>다른 검색어나 특징을 선택해주세요.</p>
        `;
        return;
    }

    emptyState.style.display = 'none';
    resultsList.style.display = 'grid';

    resultsList.innerHTML = results.map(product => createProductCard(product)).join('');
}

function createProductCard(product) {
    const imageHtml = product.productPhoto
        ? `<img src="${product.productPhoto}" alt="${product.productName}" class="result-image">`
        : `<div class="result-image no-image">이미지 없음</div>`;

    // ProductListResponse에는 hashtags가 없으므로 categoryName 사용
    const categoryTag = product.categoryName
        ? `<span class="result-tag">${product.categoryName}</span>`
        : '';

    return `
        <a href="${contextPath}/products/${product.productId}" class="result-card">
            <div class="result-image-wrapper">
                ${imageHtml}
            </div>
            <div class="result-content">
                <h3 class="result-name">${product.productName}</h3>
                <div class="result-price">${product.price.toLocaleString()}원</div>
                <div class="result-tags">${categoryTag}</div>
            </div>
        </a>
    `;
}

function resetSearchResults() {
    const emptyState = document.getElementById('emptyState');
    const resultsList = document.getElementById('resultsList');

    emptyState.style.display = 'block';
    resultsList.style.display = 'none';
    emptyState.innerHTML = `
        <div class="mascot-large">
            <img src="/banners/mascot.png" alt="Mascot" />
        </div>
        <p class="empty-message">찾고 싶은 메뉴를 검색하거나<br>특징을 선택해주세요!</p>
    `;

    // 랜덤 추천 섹션 다시 표시
    showRecommendSection();
}

// ================================================
// 8. 유틸리티 함수
// ================================================
function hideRecommendSection() {
    const recommendSection = document.querySelector('.random-recommend-section');
    if (recommendSection) {
        recommendSection.style.display = 'none';
    }
}

function showRecommendSection() {
    const recommendSection = document.querySelector('.random-recommend-section');
    if (recommendSection) {
        recommendSection.style.display = 'block';
    }
}

function formatNumber(num) {
    if (num >= 10000) {
        return (num / 10000).toFixed(1) + '만';
    } else if (num >= 1000) {
        return (num / 1000).toFixed(1) + '천';
    }
    return num.toString();
}

// ================================================
// 9. 이벤트 리스너
// ================================================
document.addEventListener('DOMContentLoaded', function() {
    initializeSearch();
});