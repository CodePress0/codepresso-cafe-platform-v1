<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<body class="my-review-page">

<style>
    @import url('${pageContext.request.contextPath}/css/myReview.css');
</style>

<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="my-review-main">
    <div class="rcontainer">
        <div class="section-header">
            <h2 class="section-title">
                <button class="back-btn" onclick="history.back()">←</button>
                내가 작성한 리뷰
            </h2>
        </div>

        <!-- 리뷰 통계 카드 -->
        <div class="review-stats-card">
            <div class="stats-item">
                <div class="stats-number" id="totalReviews">0</div>
                <div class="stats-label">작성한 리뷰</div>
            </div>
            <div class="stats-item">
                <div class="stats-number" id="averageRating">0.0</div>
                <div class="stats-label">평균 별점</div>
            </div>
        </div>

        <!-- 리뷰 필터 -->
        <div class="review-filters" id="reviewFilters" style="display: none;">
            <div class="filter-tabs" id="filterTabs">
                <button class="filter-tab active" data-filter="all">전체 (0)</button>
            </div>
        </div>


        <!-- 리뷰 목록 -->
        <div class="my-reviews-container">
            <c:choose>
                <c:when test="${empty userReviews}">
                    <div class="no-reviews">
                        <div class="no-reviews-icon">📝</div>
                        <h3>작성한 리뷰가 없습니다</h3>
                        <p>상품을 구매한 후 리뷰를 작성해보세요!</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="review" items="${userReviews}">
                        <div class="my-review-card" data-rating="${review.rating}">
                            <div class="review-product-info">
                                <div class="product-image">
                                    <img src="${review.productPhoto}" alt="${review.productName}" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                    <div class="no-image" style="display:none;">이미지 없음</div>
                                </div>
                                <div class="product-details">
                                    <h3 class="product-name">${review.productName}</h3>
                                    <div class="review-date">${review.createdAt.toLocalDate()}</div>
                                </div>
                            </div>
                            <div class="review-content-section">
                                <div class="review-rating">
                                    <div class="stars">
                                        <c:forEach var="i" begin="1" end="5">
                                            <c:choose>
                                                <c:when test="${i <= review.rating}">
                                                    <span class="star filled">⭐</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="star">⭐</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </div>
                                    <span class="rating-text">${review.rating}.0</span>
                                </div>
                                <div class="review-text">${review.content}</div>
                                <c:if test="${not empty review.photoUrl}">
                                    <div class="review-images">
                                        <img src="${review.photoUrl}" alt="리뷰 사진" class="review-image"/>
                                    </div>
                                </c:if>
                                <div class="review-actions">
                                    <button class="action-btn edit-btn" data-edit="${review.id}">
                                        <span class="icon">✏️</span>
                                        수정
                                    </button>
                                <button class="action-btn delete-btn" data-delete="${review.id}">
                                    <span class="icon">🗑️</span>
                                    삭제
                                </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination-container" id="paginationContainer" style="display: none;">
            <div class="pagination">
                <button class="page-btn prev" id="prevBtn">이전</button>
                <div class="page-numbers" id="pageNumbers"></div>
                <button class="page-btn next" id="nextBtn">다음</button>
            </div>
        </div>
    </div>
</main>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>

<script>
    // 필터링 관련 변수들 (서버 렌더링 사용으로 비활성화)
    /*
    let currentPage = 1;
    let currentFilter = 'all';
    let currentSort = 'latest';
    let allReviews = [];
    */

    // 서버에서 전달된 리뷰 데이터
    <c:if test="${not empty userReviews}">
    const serverReviews = [
        <c:forEach var="review" items="${userReviews}" varStatus="status">
        {
            id: ${review.id},
            productName: '${fn:escapeXml(review.productName)}',
            productPhoto: '${review.productPhoto}',
            photoUrl: '${review.photoUrl}',
            rating: ${review.rating},
            content: '${fn:escapeXml(review.content)}',
            createdAt: [${review.createdAt.year}, ${review.createdAt.monthValue}, ${review.createdAt.dayOfMonth}],
            formattedDate: '${review.formattedDate}',
            helpfulCount: 0,
            productId: ${review.productId}
        }<c:if test="${not status.last}">,</c:if>
        </c:forEach>
    ];
    </c:if>
    <c:if test="${empty userReviews}">
    const serverReviews = [];
    </c:if>

    // 페이지 로드 시 초기 설정 (간소화)
    document.addEventListener('DOMContentLoaded', function() {
        // 서버에서 렌더링된 통계 업데이트
        updateStatsFromServer();
    });

    // 이벤트 리스너 설정 (서버 렌더링 사용으로 비활성화)
    /*
    function setupEventListeners() {
        // 필터 버튼 이벤트 (존재하는 경우에만)
        document.querySelectorAll('.filter-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                currentFilter = this.dataset.filter;
                currentPage = 1;
                applyFiltersAndSort();
            });
        });

        // 정렬 셀렉트 이벤트 (존재하는 경우에만)
        const sortSelect = document.getElementById('sortSelect');
        if (sortSelect) {
            sortSelect.addEventListener('change', function() {
                currentSort = this.value;
                currentPage = 1;
                applyFiltersAndSort();
            });
        }
    }
    */

    // 내 리뷰 데이터 로딩 (서버 렌더링 사용으로 비활성화)
    /*
    function loadMyReviews() {
        const requestUrl = '/api/users/reviews/myReviews';

        fetch(requestUrl)
            .then(response => {
                if (!response.ok) {
                    throw new Error('HTTP 오류! 상태: ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                // 디버깅: API 응답 데이터 확인
                if (data && data.length > 0) {
                    console.log('API 응답 첫 번째 리뷰 데이터:', data[0]);
                    console.log('리뷰 ID 필드들:', {
                        id: data[0].id
                    });
                    console.log('모든 키:', Object.keys(data[0]));
                }

                // 리뷰 데이터 렌더링
                renderReviews(data);

                // 별점 및 리뷰 수 업데이트
                updateAverageRating(data);
                updateTotalReviewCount(data.length);

                // 필터 탭 생성
                createFilterTabs(data);

                // 필터 표시
                if (data && data.length > 0) {
                    document.getElementById('reviewFilters').style.display = 'block';
                }
            })
            .catch(error => {
                console.error('리뷰 로딩 실패:', error);
                const reviewsContainer = document.querySelector('.my-reviews-container');
                reviewsContainer.innerHTML = '<div style="text-align: center; padding: 50px; color: red;">리뷰를 불러올 수 없습니다. 오류: ' + error.message + '</div>';
            });
    }
    */

    // 서버 데이터로 통계 업데이트
    function updateStatsFromServer() {
        const reviews = serverReviews || [];
        updateStats(reviews);
    }

    // 통계 업데이트
    function updateStats(reviews) {
        const totalReviews = reviews.length;
        const averageRating = totalReviews > 0 ?
            (reviews.reduce((sum, review) => sum + review.rating, 0) / totalReviews).toFixed(1) : '0.0';
        const helpfulCount = reviews.reduce((sum, review) => sum + review.helpfulCount, 0);

        document.getElementById('totalReviews').textContent = totalReviews;
        document.getElementById('averageRating').textContent = averageRating;
        document.getElementById('helpfulCount').textContent = helpfulCount;
    }

    // 필터 및 정렬 적용 (서버 렌더링 사용으로 비활성화)
    /*
    function applyFiltersAndSort() {
        const allCards = document.querySelectorAll('.my-review-card');

        allCards.forEach(card => {
            const rating = card.getAttribute('data-rating');

            // 필터 적용
            if (currentFilter === 'all' || rating == currentFilter) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });

        // 정렬은 서버에서 이미 처리되어 있음 (createdAt desc)
        // 필요 시 클라이언트에서 추가 정렬 가능
    }
    */

    // 별점 생성 함수 (서버 렌더링 사용으로 비활성화)
    /*
    function generateStars(rating) {
        let stars = '';
        for (let i = 1; i <= 5; i++) {
            if (i <= rating) {
                stars += '<span class="star filled">⭐</span>';
            } else {
                stars += '<span class="star">⭐</span>';
            }
        }
        return stars;
    }

    // 전역 스코프에 함수 등록
    window.generateStars = generateStars;
    */

    // 날짜 포맷 함수 (서버 렌더링 사용으로 비활성화)
    /*
    function formatDate(dateInput) {
        if (!dateInput) return '';

        let year, month, day;

        // 배열 형태 처리: [year, month, day]
        if (Array.isArray(dateInput) && dateInput.length >= 3) {
            [year, month, day] = dateInput;
        }
        // LocalDateTime 객체 배열 형태: [year, month, day, hour, minute, second, nano]
        else if (Array.isArray(dateInput) && dateInput.length >= 7) {
            [year, month, day] = dateInput;
        }
        // ISO 문자열 처리: "2024-09-26T10:30:00"
        else if (typeof dateInput === 'string') {
            const date = new Date(dateInput);
            if (isNaN(date.getTime())) return '';
            year = date.getFullYear();
            month = date.getMonth() + 1;
            day = date.getDate();
        }
        // Date 객체 처리
        else if (dateInput instanceof Date) {
            year = dateInput.getFullYear();
            month = dateInput.getMonth() + 1;
            day = dateInput.getDate();
        }
        // 숫자 배열이 아닌 경우 처리
        else {
            console.warn('지원하지 않는 날짜 형식:', dateInput);
            return '';
        }

        return year + '.' + String(month).padStart(2, '0') + '.' + String(day).padStart(2, '0');
    }
    */

    // 리뷰 렌더링 (서버 렌더링 사용으로 비활성화)
    /*
    function renderReviews(reviews) {
        const container = document.querySelector('.my-reviews-container');

        if (!reviews || reviews.length === 0) {
            container.innerHTML = `
                <div class="no-reviews">
                    <div class="no-reviews-icon">📝</div>
                    <h3>작성한 리뷰가 없습니다</h3>
                    <p>상품을 구매한 후 리뷰를 작성해보세요!</p>
                </div>
            `;
            return;
        }

        const reviewsHtml = reviews.map(review =>
            '<div class="my-review-card" data-rating="' + review.rating + '">' +
                '<div class="review-product-info">' +
                    '<div class="product-image">' +
                        '<img src="' + review.productPhoto + '" alt="' + review.productName + '"' +
                             ' onerror="this.style.display=\'none\'; this.nextElementSibling.style.display=\'flex\';">' +
                        '<div class="no-image" style="display:none;">이미지 없음</div>' +
                    '</div>' +
                    '<div class="product-details">' +
                        '<h3 class="product-name">' + review.productName + '</h3>' +
                        '<div class="review-date">' + review.formattedDate + '</div>' +
                    '</div>' +
                '</div>' +
                '<div class="review-content-section">' +
                    '<div class="review-rating">' +
                        '<div class="stars">' +
                            generateStars(review.rating) +
                        '</div>' +
                        '<span class="rating-text">' + review.rating + '.0</span>' +
                    '</div>' +
                    '<div class="review-text">' + review.content + '</div>' +
                    (review.photoUrl ? '<div class="review-images"><img src="' + review.photoUrl + '" alt="리뷰 사진" class="review-image"/></div>' : '') +
                    '<div class="review-actions">' +
                        '<button class="action-btn edit-btn" data-edit="' + review.id + '">' +
                            '<span class="icon">✏️</span>' +
                            '수정' +
                        '</button>' +
                        '<button class="action-btn delete-btn" data-delete="' + review.id + '">' +
                            '<span class="icon">🗑️</span>' +
                            '삭제' +
                        '</button>' +
                    '</div>' +
                '</div>' +
            '</div>'
        ).join('');

        container.innerHTML = reviewsHtml;
    }
    */

    // 평균 별점 및 리뷰 수 업데이트 (서버 렌더링 사용으로 비활성화)
    /*
    function updateAverageRating(reviews) {
        const totalReviews = reviews.length;
        const averageRating = totalReviews > 0 ?
            (reviews.reduce((sum, review) => sum + review.rating, 0) / totalReviews).toFixed(1) : '0.0';

        document.getElementById('averageRating').textContent = averageRating;
    }

    function updateTotalReviewCount(count) {
        document.getElementById('totalReviews').textContent = count;
    }
    */

    // 필터 탭 생성 (서버 렌더링 사용으로 비활성화)
    /*
    function createFilterTabs(reviews) {
        const filterTabs = document.getElementById('filterTabs');
        if (!filterTabs) return;

        const ratingCounts = {};
        reviews.forEach(review => {
            ratingCounts[review.rating] = (ratingCounts[review.rating] || 0) + 1;
        });

        let tabsHtml = '<button class="filter-tab active" data-filter="all">전체 (' + reviews.length + ')</button>';

        for (let rating = 5; rating >= 1; rating--) {
            if (ratingCounts[rating]) {
                tabsHtml += '<button class="filter-tab" data-filter="' + rating + '">' + rating + '점 (' + ratingCounts[rating] + ')</button>';
            }
        }

        filterTabs.innerHTML = tabsHtml;

        // 새로 생성된 필터 탭에 이벤트 리스너 추가
        filterTabs.querySelectorAll('.filter-tab').forEach(btn => {
            btn.addEventListener('click', function() {
                filterTabs.querySelectorAll('.filter-tab').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                currentFilter = this.dataset.filter;
                currentPage = 1;
                applyFiltersAndSort();
            });
        });
    }
    */

    // 이벤트 위임을 사용한 리뷰 삭제 처리
    document.addEventListener('click', e => {
        // 삭제 버튼 클릭 처리
        const deleteBtn = e.target.closest('[data-delete]');
        if (deleteBtn) {
            const reviewId = deleteBtn.dataset.delete;
            console.log('클릭된 버튼:', deleteBtn);
            console.log('data-delete 속성 값:', reviewId);
            console.log('reviewId 타입:', typeof reviewId);

            if (!confirm('정말로 이 리뷰를 삭제하시겠습니까?')) return;

            const requestUrl = '/api/users/reviews/' + reviewId;
            console.log('requestUrl:', '/api/users/reviews/'+ reviewId);
            fetch(requestUrl, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                credentials: 'same-origin'
            })
            .then(res => {
                if (!res.ok) throw new Error(`삭제 실패 (${res.status})`);

                // 해당 리뷰 카드 제거
                const reviewCard = deleteBtn.closest('.my-review-card');
                if (reviewCard) {
                    reviewCard.remove();
                }

                alert('리뷰가 삭제되었습니다.');

                // 통계 업데이트를 위해 페이지 새로고침
                setTimeout(() => {
                    window.location.reload();
                }, 500);
            })
            .catch(err => {
                console.error('Delete error:', err);
                alert(err.message || '삭제에 실패했습니다.');
            });
        }

        // 수정 버튼 클릭 처리
        const editBtn = e.target.closest('[data-edit]');
        if (editBtn) {
            const reviewId = editBtn.dataset.edit;
            window.location.href = '/users/reviews/' + reviewId + '/edit';
        }
    });
</script>
</body>
</html>