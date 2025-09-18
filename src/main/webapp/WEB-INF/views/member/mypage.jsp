<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<body>
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="hero">
    <div class="container">
        <div class="hero-card" style="grid-template-columns: 1fr; max-width: 800px; margin: 0 auto;">
            <div>
                <div class="badge">CodePress · 마이페이지</div>
                <h1>내 정보</h1>

                <style>
                    .info-list { list-style: none; padding: 0; margin: 16px 0; display: grid; gap: 10px; }
                    .info-item { background: var(--white); border: 1px solid rgba(0,0,0,0.06); border-radius: 12px; padding: 12px 14px; }
                    .info-item b { display: inline-block; width: 120px; }
                </style>

                <!--
                  간단 표시: accountId는 userPrincipal.name으로 확인 가능
                  추가 정보(이메일/닉네임 등)는 API로 불러오거나, 시큐리티 태그로 principal 확장 정보를 노출하는 방식으로 확장할 수 있어요.
                -->
                <ul class="info-list">
                    <li class="info-item"><b>아이디</b> ${pageContext.request.userPrincipal.name}</li>
                    <li class="info-item"><b>이름</b> <span id="name">불러오는 중...</span></li>
                    <li class="info-item"><b>전화번호</b> <span id="phone">불러오는 중...</span></li>
                    <li class="info-item"><b>이메일</b> <span id="email">불러오는 중...</span></li>
                    <li class="info-item"><b>닉네임</b> <span id="nickname">불러오는 중...</span></li>
                </ul>

                <div class="cta">
                    <a class="btn btn-primary" href="/branch/list">주문하러 가기</a>
                    <a class="btn btn-ghost" href="/favorites">즐겨찾기</a>
                </div>

                <script>
                    // 필요 시, 본인 정보 API(/api/users/me)를 호출해 닉네임/이메일을 채워 넣습니다.
                    function formatPhone(value){
                        const d = (value||'').replace(/\D/g,'').slice(0,11);
                        if(!d) return '';
                        if(d.startsWith('02')){
                            if(d.length <= 2) return d;
                            if(d.length <= 5) return d.slice(0,2)+'-'+d.slice(2);
                            if(d.length <= 9) return d.slice(0,2)+'-'+d.slice(2,5)+'-'+d.slice(5);
                            return d.slice(0,2)+'-'+d.slice(2,6)+'-'+d.slice(6);
                        }else{
                            if(d.length <= 3) return d;
                            if(d.length <= 7) return d.slice(0,3)+'-'+d.slice(3);
                            if(d.length <= 10) return d.slice(0,3)+'-'+d.slice(3,6)+'-'+d.slice(6);
                            return d.slice(0,3)+'-'+d.slice(3,7)+'-'+d.slice(7);
                        }
                    }

                    (async function(){
                        try {
                            const res = await fetch('/api/users/me');
                            if (!res.ok) return; // 미로그인 등
                            const data = await res.json();
                            if (data.name) document.getElementById('name').textContent = data.name;
                            if (data.phone) document.getElementById('phone').textContent = formatPhone(data.phone);
                            if (data.email) document.getElementById('email').textContent = data.email;
                            if (data.nickname) document.getElementById('nickname').textContent = data.nickname;
                        } catch (e) { /* 무시 */ }
                    })();
                </script>
            </div>
        </div>
    </div>
    
</main>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
