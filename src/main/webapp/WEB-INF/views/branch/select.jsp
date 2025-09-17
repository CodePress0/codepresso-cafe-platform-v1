<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<body>
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="hero">
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
            <p class="desc">영업시간: Open 07:00 ~ 21:00 · 주문 가능</p>
        </section>

        <style>
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
        </style>

        <div class="branch-grid">
            <!-- 카드 1: 강남역사거리점 -->
            <article class="branch-card">
                <div class="branch-cover" aria-label="매장 이미지">
                    <img src="/banners/mascot.png" alt="CodePress Mascot" />
                </div>
                <div class="branch-body">
                    <div class="branch-name">강남역사거리점</div>
                    <div class="branch-meta">Open 07:00 ~ 21:00</div>
                    <div><span class="badge-open">주문 가능</span></div>
                    <div class="card-actions">
                        <button class="btn btn-primary" onclick="alert('강남역사거리점 선택! 주문을 시작해볼까요?');">선택</button>
                    </div>
                </div>
            </article>

            <!-- 카드 2: 강남점 -->
            <article class="branch-card">
                <div class="branch-cover" aria-label="매장 이미지">
                    <img src="/banners/mascot.png" alt="CodePress Mascot" />
                </div>
                <div class="branch-body">
                    <div class="branch-name">강남점</div>
                    <div class="branch-meta">Open 07:00 ~ 21:00</div>
                    <div><span class="badge-open">주문 가능</span></div>
                    <div class="card-actions">
                        <button class="btn btn-primary" onclick="alert('강남점 선택! 주문을 시작해볼까요?');">선택</button>
                    </div>
                </div>
            </article>

            <!-- 카드 3: 삼성타운점 -->
            <article class="branch-card">
                <div class="branch-cover" aria-label="매장 이미지">
                    <img src="/banners/mascot.png" alt="CodePress Mascot" />
                </div>
                <div class="branch-body">
                    <div class="branch-name">삼성타운점</div>
                    <div class="branch-meta">Open 07:00 ~ 21:00</div>
                    <div><span class="badge-open">주문 가능</span></div>
                    <div class="card-actions">
                        <button class="btn btn-primary" onclick="alert('삼성타운점 선택! 주문을 시작해볼까요?');">선택</button>
                    </div>
                </div>
            </article>
        </div>
    </div>
</main>

<script>
  // 로그인 이후 잘못된 페이지 접근으로 리다이렉트된 경우(예: / 또는 /auth/login) 안내 알림
  (function(){
    var p = new URLSearchParams(location.search);
    if (p.get('blocked') === '1') {
      alert('이미 로그인되어 있어 접근할 수 없는 페이지입니다. 매장을 선택해주세요.');
    }
  })();
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>