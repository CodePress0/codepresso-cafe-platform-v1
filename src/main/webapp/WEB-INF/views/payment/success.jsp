<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 성공 - CodePresso 카페</title>
    <style>
        @import url('${pageContext.request.contextPath}/css/paymentSuccess.css');
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-icon"> Success </div>
        <h1 class="success-title"> 결제가 완료되었습니다! </h1>
        <p>CodePresso 카페를 이용해주셔서 감사합니다. </p>

        <div class="payment-info">
            <div class="info-row">
                <span class="info-label"> 주문번호: </span>
                <span class="info-value"> ${orderId}</span>
            </div>
            <div class="info-row">
                <span class="info-label"> 결제금액: </span>
                <span class="info-value">
                    <fmt:formatNumber value="${amount}" type="number" groupingUsed="true"/>원
                </span>
            </div>
            <div class="info-row">
                <span class="info-label"> 결제키: </span>
                <span class="info-value"> ${paymentKey}</span>
            </div>
        </div>

        <div class="button-group">
            <a href="/orders" class="btn btn-primary">주문 내역 보기</a>
            <a href="/" class="btn btn-secondary">홈으로 가기</a>
        </div>
    </div>

<script>
    console.log('결제 성공:', {
        orderId: '${orderId}',
        paymentKey: '${paymentKey}',
        amount: '${amount}'
    });

</script>
</body>
</html>