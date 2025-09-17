<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>즐겨찾기 목록</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .favorite-stats {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        .favorite-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .favorite-item {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            background-color: white;
            transition: box-shadow 0.3s ease;
        }
        .favorite-item:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 4px;
            margin-bottom: 10px;
        }
        .product-name {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 8px;
        }
        .product-content {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .product-price {
            font-size: 20px;
            font-weight: bold;
            color: #e74c3c;
            margin-bottom: 15px;
        }
        .favorite-actions {
            display: flex;
            gap: 10px;
            justify-content: space-between;
        }
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        .empty-state h3 {
            margin-bottom: 10px;
            color: #999;
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid #c3e6cb;
        }
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid #f5c6cb;
        }
        .orderby-info {
            font-size: 12px;
            color: #999;
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>❤️ 즐겨찾기 목록</h1>

    <!-- 성공 메시지 -->
    <c:if test="${not empty success}">
        <div class="success-message">
            ✅ ${success}
        </div>
    </c:if>

    <!-- 에러 메시지 -->
    <c:if test="${not empty error}">
        <div class="error-message">
            ❌ ${error}
        </div>
    </c:if>

    <c:choose>
        <c:when test="${not empty favoriteList.favorites and favoriteList.totalCount > 0}">
            <!-- 즐겨찾기 통계 -->
            <div class="favorite-stats">
                <strong>총 ${favoriteList.totalCount}개의 상품이 즐겨찾기에 등록되어 있습니다.</strong>
            </div>

            <!-- 즐겨찾기 목록 -->
            <div class="favorite-grid">
                <c:forEach var="favorite" items="${favoriteList.favorites}" varStatus="status">
                    <div class="favorite-item">
                        <div class="orderby-info">순서: ${favorite.orderby}</div>
                        
                        <c:if test="${not empty favorite.productPhoto}">
                            <img src="${favorite.productPhoto}" alt="${favorite.productName}" class="product-image"
                                 onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwIiBoZWlnaHQ9IjIwMCIgdmlld0JveD0iMCAwIDMwMCAyMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIzMDAiIGhlaWdodD0iMjAwIiBmaWxsPSIjRjVGNUY1Ii8+Cjx0ZXh0IHg9IjE1MCIgeT0iMTAwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSIjOTk5IiBmb250LWZhbWlseT0iQXJpYWwiIGZvbnQtc2l6ZT0iMTQiPkltYWdlPC90ZXh0Pgo8L3N2Zz4='; this.onerror=null;">
                        </c:if>
                        <c:if test="${empty favorite.productPhoto}">
                            <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwIiBoZWlnaHQ9IjIwMCIgdmlld0JveD0iMCAwIDMwMCAyMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIzMDAiIGhlaWdodD0iMjAwIiBmaWxsPSIjRjVGNUY1Ii8+Cjx0ZXh0IHg9IjE1MCIgeT0iMTAwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSIjOTk5IiBmb250LWZhbWlseT0iQXJpYWwiIGZvbnQtc2l6ZT0iMTQiPk5vIEltYWdlPC90ZXh0Pgo8L3N2Zz4=" alt="No Image" class="product-image">
                        </c:if>
                        
                        <div class="product-name">${favorite.productName}</div>
                        <div class="product-content">${favorite.productContent}</div>
                        <div class="product-price">
                            <fmt:formatNumber value="${favorite.price}" type="currency" currencySymbol="₩"/>
                        </div>
                        
                        <div class="favorite-actions">
                            <a href="#" class="btn btn-primary" onclick="alert('상품 상세 페이지는 준비 중입니다!'); return false;">
                                상품 보기
                            </a>
                            <button class="btn btn-danger" onclick="removeFavorite('${favorite.productId}')">
                                즐겨찾기 삭제
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <!-- 즐겨찾기가 없는 경우 -->
            <div class="empty-state">
                <h3>😔 즐겨찾기가 비어있습니다</h3>
                <p>마음에 드는 상품을 즐겨찾기에 추가해보세요!</p>
                <a href="/" class="btn btn-primary">상품 둘러보기</a>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- 하단 액션 버튼 -->
    <div style="text-align: center; margin-top: 30px;">
        <a href="/mypage?memberId=${memberId}" class="btn btn-secondary">마이페이지로 돌아가기</a>
        <a href="/" class="btn btn-secondary">홈으로 돌아가기</a>
    </div>
</div>

<script>
    // 즐겨찾기 삭제 함수
    function removeFavorite(productId) {
        if (confirm('정말로 이 상품을 즐겨찾기에서 삭제하시겠습니까?')) {
            fetch('/users/favorites/' + productId + '?memberId=' + '${memberId}', {
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
</body>
</html>
