<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<body>
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="cart-page">
    <div class="cart-shell">
        <c:set var="itemCount" value="${empty cart or empty cart.items ? 0 : fn:length(cart.items)}" />
        <c:set var="totalPrice" value="0" />
        <c:if test="${itemCount > 0}">
            <c:forEach var="item" items="${cart.items}">
                <c:set var="totalPrice" value="${totalPrice + item.price}" />
            </c:forEach>
        </c:if>

        <section class="cart-content">
            <header class="cart-header-bar">
                <div>
                    <h1>장바구니</h1>
                    <p>주문 전 담긴 메뉴와 옵션을 한 번 더 확인해 주세요.</p>
                </div>
                <div class="cart-header-info">
                    <span>총 <strong>${itemCount}</strong>개</span>
                    <c:if test="${not empty cart}">
                        <span>ID <strong>${cart.memberId}</strong></span>
                    </c:if>
                </div>
            </header>

            <c:choose>
                <c:when test="${itemCount == 0}">
                    <section class="cart-empty">
                        <div class="cart-empty-illust"></div>
                        <h2>장바구니가 비어 있어요</h2>
                        <p>지금 인기 메뉴를 둘러보고 원하는 음료를 담아보세요.</p>
                        <a class="btn btn-primary" href="/branch/list">메뉴 보러가기</a>
                    </section>
                </c:when>
                <c:otherwise>
                    <ul class="cart-item-list">
                        <c:forEach var="item" items="${cart.items}">
                            <li class="cart-item">
                                <div class="cart-item-thumb" aria-hidden="true"></div>
                                <div class="cart-item-info">
                                    <div class="cart-item-header">
                                        <h3>${item.productName}</h3>
                                        <button type="button" class="btn-text" data-delete="${item.cartItemId}">삭제</button>
                                    </div>
                                    <div class="cart-item-meta">
                                        <div class="meta-text">
                                            <span>수량 ${item.quantity}개</span>
                                            <span class="dot">·</span>
                                            <span><fmt:formatNumber value="${item.price}" type="number" />원</span>
                                        </div>
                                        <div class="qty-actions">
                                            <div class="qty-control" data-item="${item.cartItemId}">
                                                <button type="button" class="qty-btn" data-type="minus">-</button>
                                                <input type="number" min="1" value="${item.quantity}" />
                                                <button type="button" class="qty-btn" data-type="plus">+</button>
                                            </div>
                                            <button type="button" class="btn btn-outline btn-apply" data-update="${item.cartItemId}">적용</button>
                                        </div>
                                    </div>
                                    <c:if test="${not empty item.options}">
                                        <ul class="cart-option-list">
                                            <c:forEach var="opt" items="${item.options}">
                                                <li>
                                                    <span>${opt.optionName}</span>
                                                    <c:if test="${opt.extraPrice ne null && opt.extraPrice ne 0}">
                                                        <em>+<fmt:formatNumber value="${opt.extraPrice}" type="number" />원</em>
                                                    </c:if>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </c:if>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                    <form class="cart-clear-form" action="<c:url value='/users/cart/clear'/>" method="post">
                        <input type="hidden" name="cartId" value="${cart.cartId}" />
                        <button type="submit" class="btn-text">전체 비우기</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </section>

        <aside class="cart-sidebar">
            <div class="summary-card">
                <h2>결제 예정 금액</h2>
                <dl>
                    <div class="row">
                        <dt>상품 금액</dt>
                        <dd><fmt:formatNumber value="${totalPrice}" type="number" />원</dd>
                    </div>
                    <div class="row">
                        <dt>할인</dt>
                        <dd>0원</dd>
                    </div>
                    <div class="total">
                        <dt>총 결제 금액</dt>
                        <dd><fmt:formatNumber value="${totalPrice}" type="number" />원</dd>
                    </div>
                </dl>
                <button class="btn btn-primary btn-block" type="button">주문하기</button>
            </div>
        </aside>
    </div>
</main>

<style>
    body { background-color: #f7f7f7; }
    .cart-page { padding: 48px 0 64px; }
    .cart-shell {
        max-width: 1100px;
        margin: 0 auto;
        display: grid;
        grid-template-columns: minmax(0, 1.5fr) minmax(0, 1fr);
        gap: 32px;
        padding: 0 20px;
    }
    .cart-content { display: grid; gap: 24px; }
    .cart-header-bar {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        gap: 20px;
        padding: 24px 28px;
        background: #fff;
        border-radius: 20px;
        box-shadow: 0 18px 40px rgba(15, 23, 42, 0.08);
    }
    .cart-header-bar h1 { margin: 0 0 8px; font-size: 28px; }
    .cart-header-bar p { margin: 0; color: var(--text-2); font-size: 15px; }
    .cart-header-info { display: flex; gap: 12px; color: var(--text-2); font-weight: 600; }
    .cart-header-info strong { color: var(--text-1); }

    .cart-empty {
        text-align: center;
        padding: 60px 40px;
        background: #fff;
        border-radius: 20px;
        box-shadow: 0 18px 40px rgba(15,23,42,0.08);
        display: grid; gap: 16px; justify-items: center;
    }
    .cart-empty h2 { margin: 0; font-size: 24px; }
    .cart-empty p { margin: 0; color: var(--text-2); }
    .cart-empty-illust {
        width: 88px; height: 88px;
        border-radius: 50%;
        background: linear-gradient(135deg, #ffe5ec, #ffd5e4);
        box-shadow: inset 0 6px 12px rgba(255, 255, 255, 0.6);
    }

    .cart-item-list { list-style: none; margin: 0; padding: 0; display: grid; gap: 18px; }
    .cart-item {
        display: grid;
        grid-template-columns: 96px 1fr;
        gap: 20px;
        padding: 22px 26px;
        background: #fff;
        border-radius: 20px;
        box-shadow: 0 20px 36px rgba(15,23,42,0.08);
        position: relative;
    }
    .cart-item-thumb {
        width: 96px; height: 96px;
        border-radius: 16px;
        background: linear-gradient(135deg, #ffd5e4, #ffafcc);
        box-shadow: inset 0 6px 12px rgba(255, 255, 255, 0.45);
    }
    .cart-item-info { display: grid; gap: 12px; }
    .cart-item-header { display: flex; justify-content: space-between; align-items: flex-start; gap: 16px; }
    .cart-item-header h3 { margin: 0; font-size: 20px; }
    .btn-text { background: none; border: 0; cursor: pointer; color: var(--text-2); font-size: 14px; }
    .btn-text:hover { color: var(--text-1); }
    .cart-item-meta { color: var(--text-2); font-size: 14px; display: flex; justify-content: space-between; align-items: center; gap: 16px; flex-wrap: wrap; }
    .cart-item-meta .dot { opacity: 0.4; }
    .meta-text { display: flex; gap: 8px; align-items: center; }
    .qty-actions { display: flex; align-items: center; gap: 10px; }
    .qty-control {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        border: 1px solid rgba(0,0,0,0.1);
        border-radius: 999px;
        padding: 4px 10px;
        background: #faf5f7;
    }
    .qty-control input {
        width: 42px;
        border: none;
        background: transparent;
        text-align: center;
        font-size: 14px;
        color: var(--text-1);
    }
    .qty-control input:focus { outline: none; }
    .qty-btn {
        width: 22px;
        height: 22px;
        border-radius: 50%;
        border: none;
        background: #fff;
        box-shadow: 0 2px 6px rgba(15,23,42,0.12);
        cursor: pointer;
        display: grid;
        place-items: center;
        font-weight: 700;
        color: var(--text-1);
    }
    .qty-btn:hover { background: #ffe5ec; }
    .btn-apply { padding: 8px 14px; font-size: 13px; }
    .cart-option-list { display: flex; flex-wrap: wrap; gap: 8px; list-style: none; margin: 0; padding: 0; }
    .cart-option-list li { background: rgba(255,122,162,0.12); padding: 6px 12px; border-radius: 999px; font-size: 13px; }
    .cart-option-list em { margin-left: 6px; color: var(--pink-1); font-style: normal; font-weight: 600; }

    .cart-clear-form { text-align: right; }

    .cart-sidebar { display: grid; gap: 20px; align-content: start; }
    .summary-card, .add-card {
        background: #fff;
        border-radius: 20px;
        padding: 28px;
        box-shadow: 0 18px 36px rgba(15,23,42,0.08);
        display: grid; gap: 18px;
    }
    .summary-card h2 { margin: 0; font-size: 22px; }
    .summary-card dl { margin: 0; display: grid; gap: 12px; }
    .summary-card .row { display: flex; justify-content: space-between; color: var(--text-2); }
    .summary-card .total { display: flex; justify-content: space-between; font-size: 18px; font-weight: 700; color: var(--text-1); border-top: 1px solid rgba(0,0,0,0.06); padding-top: 12px; }
    .btn-block { width: 100%; }
    .btn-outline {
        background: #fff;
        border: 1px solid rgba(0,0,0,0.12);
        color: var(--text-1);
        transition: box-shadow .2s ease, transform .08s ease;
    }
    .btn-outline:hover { box-shadow: 0 8px 16px rgba(15, 23, 42, 0.12); }

    .add-card h3 { margin: 0; font-size: 18px; }
    .add-card p { margin: 0; color: var(--text-2); font-size: 14px; }
    .input-group { display: grid; gap: 6px; font-size: 14px; }
    .input-group span { color: var(--text-2); font-weight: 600; }
    .input-group input {
        border-radius: 12px;
        border: 1px solid rgba(0,0,0,0.08);
        padding: 10px 12px;
        font-size: 15px;
        transition: border-color .2s ease, box-shadow .2s ease;
    }
    .input-group input:focus {
        outline: none;
        border-color: var(--pink-1);
        box-shadow: 0 0 0 3px rgba(255,122,162,0.18);
    }

    @media (max-width: 1024px) {
        .cart-shell { grid-template-columns: 1fr; }
        .cart-sidebar { order: -1; }
    }
</style>

<script>
    const csrfTokenMeta = document.querySelector('meta[name="_csrf"]');
    const csrfHeaderMeta = document.querySelector('meta[name="_csrf_header"]');
    const csrfToken = csrfTokenMeta ? csrfTokenMeta.getAttribute('content') : null;
    const csrfHeader = csrfHeaderMeta ? csrfHeaderMeta.getAttribute('content') : null;
    const withCsrf = (headers = {}) => {
        if (csrfToken && csrfHeader) {
            return Object.assign({}, headers, { [csrfHeader]: csrfToken });
        }
        return headers;
    };

    const clampQuantity = value => Math.max(1, Number.isNaN(value) ? 1 : value);

    document.querySelectorAll('.qty-control').forEach(control => {
        const input = control.querySelector('input');
        control.addEventListener('click', event => {
            const btn = event.target.closest('.qty-btn');
            if (!btn) return;
            const type = btn.dataset.type;
            let current = clampQuantity(parseInt(input.value, 10));
            current = type === 'minus' ? Math.max(1, current - 1) : current + 1;
            input.value = current;
        });

        input.addEventListener('change', () => {
            input.value = clampQuantity(parseInt(input.value, 10));
        });
    });

    document.querySelectorAll('[data-update]').forEach(button => {
        button.addEventListener('click', () => {
            const item = button.closest('.cart-item');
            const control = item.querySelector('.qty-control');
            const input = control.querySelector('input');
            const quantity = clampQuantity(parseInt(input.value, 10));
            const id = button.dataset.update;

            fetch(`/users/cart/${id}?quantity=${quantity}`, {
                method: 'PATCH',
                headers: withCsrf(),
                credentials: 'include'
            }).then(() => window.location.reload());
        });
    });

    document.addEventListener('click', event => {
        const deleteBtn = event.target.closest('[data-delete]');
        if (!deleteBtn) return;

        const id = deleteBtn.getAttribute('data-delete');
        window.location.href = `/users/cart/${id}/delete`;
    });
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
