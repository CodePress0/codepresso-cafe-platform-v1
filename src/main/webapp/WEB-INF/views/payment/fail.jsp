<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 실패 - CodePresso 카페</title>
    <style>
        @import url('${pageContext.request.contextPath}/css/paymentFail.css');
    </style>
</head>

<body>
<div class="fail-container">
    <div class="fail-icon">❌</div>
    <h1 class="fail-title">결제에 실패했습니다</h1>
    <p>결제 처리 중 문제가 발생했습니다. 다시 시도해 주세요.</p>

    <div class="error-info">
        <c:if test="${not empty code}">
            <div class="error-row">
                <span class="error-label">에러코드:</span>
                <span class="error-value">${code}</span>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="error-row">
                <span class="error-label">실패 사유:</span>
                <span class="error-value">${errorMessage}</span>
            </div>
        </c:if>
        <c:if test="${not empty orderId}">
            <div class="error-row">
                <span class="error-label">주문번호:</span>
                <span class="error-value">${orderId}</span>
            </div>
        </c:if>
    </div>

    <div class="button-group">
        <a href="javascript:history.back()" class="btn btn-primary">다시 시도</a>
        <a href="/" class="btn btn-secondary">홈으로 가기</a>
    </div>
</div>

<script>
    // 실패 로그
    console.log('결제 실패:', {
        code: '${code}',
        message: '${errorMessage}',
        orderId: '${orderId}'
    });
</script>
</body>
</html>
