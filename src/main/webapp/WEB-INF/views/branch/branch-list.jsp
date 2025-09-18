<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<body>
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="hero branch-page">
    <div class="container">
        <!--
          매장 선택 화면 (하드코딩 데이터 3개)
          - 카드형식, 분홍 테마 유지
          - 이미지: 마스코트 이미지 재사용 (/banners/mascot.png)

          학습 포인트
          - 지금은 서버 API 없이 정적인 카드로 구성합니다.
          - 나중에 DB/서비스 연동 시, 같은 레이아웃 안에서 목록을 서버에서 주입하면 됩니다.
        -->
        <section class="branch-hero">
            <h1>가까운 CodePress 매장을 선택하세요</h1>
        </section>

        <style>
            /* 이 페이지는 상단 여백을 줄입니다 */
            .hero.branch-page { padding-top: 40px; }
            /* 레이아웃: 카드 그리드 */
            .branch-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 16px;
            }
            @media (max-width: 900px) {
                .branch-grid { grid-template-columns: 1fr; }
            }

            /* 카드 */
            .branch-card {
                background: var(--white);
                border-radius: 18px;
                box-shadow: var(--shadow);
                overflow: hidden;
                display: grid;
                grid-template-rows: 160px auto;
            }
            .branch-cover {
                background: linear-gradient(135deg, var(--pink-3), var(--pink-4));
                position: relative;
            }
            .branch-cover img { width: 100%; height: 100%; object-fit: cover; display: block; }
            .branch-body { padding: 16px; display: grid; gap: 8px; }
            .branch-name { font-size: 18px; font-weight: 800; }
            .branch-meta { color: var(--text-2); font-size: 14px; }
            .badge-open {
                display: inline-block; padding: 4px 10px; border-radius: 999px;
                background: var(--pink-4); color: var(--pink-1); font-weight: 800; font-size: 12px;
            }
            .card-actions { display: flex; justify-content: flex-end; }

            /* 텍스트 링크 스타일 */
            .text-link { color: var(--text-1); text-decoration: none; font-weight: 700; }
            .text-link:hover { text-decoration: underline; }
            .text-muted { color: var(--text-2); }
        </style>

        <c:choose>
            <c:when test="${not empty branches}">
                <div id="branchGrid" class="branch-grid">
                    <jsp:include page="/WEB-INF/views/branch/branch-cards.jsp" />
                </div>
                <div class="cta" style="justify-content:center; margin-top: 16px; gap: 12px;">
                    <a id="loadMoreLink" href="#" class="text-link">더 보기</a>
                    <span class="text-muted">|</span>
                    <a id="scrollTopLink" href="#" class="text-link">맨위로 이동</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state" style="text-align:center; padding:40px 16px; color:var(--text-2);">
                    <h3>등록된 매장이 없습니다</h3>
                    <p>관리자 페이지에서 매장을 먼저 등록해주세요.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<script>
  (function(){
    var nextPage = ${hasNext ? nextPage : -1};
    var pageSize = ${pageSize};
    var grid = document.getElementById('branchGrid');
    var more = document.getElementById('loadMoreLink');
    var toTop = document.getElementById('scrollTopLink');
    if (toTop) {
      toTop.addEventListener('click', function(e){ e.preventDefault(); window.scrollTo({ top: 0, behavior: 'smooth' }); });
    }
    if (!more) return; // 빈 상태
    if (nextPage === -1) {
      more.style.display = 'none';
    }
    more.addEventListener('click', async function(e){
      e.preventDefault();
      try {
        more.style.pointerEvents = 'none';
        var res = await fetch('/branch/page?page=' + nextPage + '&size=' + pageSize, { headers: { 'X-Requested-With': 'XMLHttpRequest' }});
        if (!res.ok) { more.style.pointerEvents = 'auto'; return; }
        var html = await res.text();
        if (html && html.trim().length > 0) {
          grid.insertAdjacentHTML('beforeend', html);
        }
        var hasNext = res.headers.get('X-Has-Next') === 'true';
        if (hasNext) {
          nextPage = nextPage + 1;
          more.style.pointerEvents = 'auto';
        } else {
          more.style.display = 'none';
        }
      } catch(e) {
        more.style.pointerEvents = 'auto';
      }
    });
  })();
  
  // 로그인 이후 잘못된 페이지 접근으로 리다이렉트된 경우(예: / 또는 /auth/login) 안내 알림
  (function(){
    var p = new URLSearchParams(location.search);
    if (p.get('blocked') === '1') {
      alert('이미 로그인되어 있어 접근할 수 없는 페이지입니다. 매장을 선택해주세요.');
    }
  })();
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
