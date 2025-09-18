<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var="b" items="${branches}">
    <article class="branch-card">
        <div class="branch-cover" aria-label="매장 이미지">
            <c:choose>
                <c:when test="${not empty b.photoUrl}">
                    <img src="${b.photoUrl}"
                         alt="${b.branchName}"
                         onerror="this.src='/banners/mascot.png'; this.onerror=null;" />
                </c:when>
                <c:otherwise>
                    <img src="/banners/mascot.png" alt="CodePress Mascot" />
                </c:otherwise>
            </c:choose>
        </div>
        <div class="branch-body">
            <div class="branch-name">${b.branchName}</div>
            <div class="branch-meta">Open ${b.openingTime} ~ ${b.closingTime}</div>
            <div>
                <span class="badge-open">
                    <c:choose>
                        <c:when test="${b.isOpen}">주문 가능</c:when>
                        <c:otherwise>영업 종료</c:otherwise>
                    </c:choose>
                </span>
            </div>
            <div class="card-actions">
                <button class="btn btn-primary" onclick="alert('${b.branchName} 선택! 주문을 시작해볼까요?');">선택</button>
            </div>
        </div>
    </article>
</c:forEach>
