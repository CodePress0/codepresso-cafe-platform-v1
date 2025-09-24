<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<body class="mypage-body">
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<style>
    .mypage-body {
        background: linear-gradient(160deg, var(--pink-4), #fff 55%);
    }
    .hero.mypage-hero {
        background: transparent;
        padding: 72px 0 92px;
    }
    .mypage-card {
        background: #fff !important;
        border-radius: 28px;
        border: 1px solid rgba(15,23,42,0.06);
        box-shadow: 0 28px 54px rgba(15,23,42,0.08);
    }
    .mypage-body .btn.btn-ghost {
        background: #fff;
        color: var(--pink-1);
        border: 1px solid rgba(255,122,162,0.6);
    }
    .mypage-body .btn.btn-ghost:hover {
        border-color: var(--pink-1);
        background: rgba(255,122,162,0.08);
        color: var(--pink-1);
    }
</style>

<main class="hero mypage-hero">
    <div class="container">
        <div class="hero-card mypage-card" style="grid-template-columns: 1fr; max-width: 800px; margin: 0 auto;">
            <div>
                <div class="badge">CodePress · 마이페이지</div>
                <h1>내 정보</h1>

                <c:if test="${not empty success}">
                    <div class="success-message" style="background: #d4edda; color: #155724; padding: 12px 16px; border-radius: 8px; margin-bottom: 16px;">✅ ${success}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="error-message" style="background: #f8d7da; color: #721c24; padding: 12px 16px; border-radius: 8px; margin-bottom: 16px;">❌ ${error}</div>
                </c:if>

                <style>
                    .info-list { list-style: none; padding: 0; margin: 20px 0; display: grid; gap: 16px; }
                    .info-item {
                        display: grid;
                        grid-template-columns: 140px 1fr;
                        align-items: center;
                        gap: 12px;
                        padding-bottom: 14px;
                        border-bottom: 1px dashed rgba(255, 122, 162, 0.5);
                    }
                    .info-item:last-child { border-bottom: none; padding-bottom: 0; }
                    .info-item b { font-weight: 700; color: var(--text-1); }
                    .edit-mode { display: none; }
                    .edit-mode input {
                        width: 100%;
                        padding: 10px 14px;
                        border: 1px solid rgba(15,23,42,0.12);
                        border-radius: 12px;
                        font-size: 14px;
                        margin-top: 4px;
                    }
                </style>

                <!--
                  간단 표시: accountId는 userPrincipal.name으로 확인 가능
                  추가 정보(이메일/닉네임 등)는 API로 불러오거나, 시큐리티 태그로 principal 확장 정보를 노출하는 방식으로 확장할 수 있어요.
                -->
                <ul class="info-list">
                    <li class="info-item">
                        <b>아이디</b> ${pageContext.request.userPrincipal.name}
                    </li>
                    <li class="info-item">
                        <b>이름</b> 
                        <span id="name-display">불러오는 중...</span>
                        <div class="edit-mode" id="name-edit">
                            <input type="text" id="name-input" placeholder="이름을 입력하세요">
                        </div>
                    </li>
                    <li class="info-item">
                        <b>전화번호</b> 
                        <span id="phone-display">불러오는 중...</span>
                        <div class="edit-mode" id="phone-edit">
                            <input type="text" id="phone-input" placeholder="전화번호를 입력하세요">
                        </div>
                    </li>
                    <li class="info-item">
                        <b>이메일</b> 
                        <span id="email-display">불러오는 중...</span>
                        <div class="edit-mode" id="email-edit">
                            <div style="display: flex; gap: 8px; align-items: center;">
                                <input type="email" id="email-input" placeholder="이메일을 입력하세요" style="flex: 1;">
                                <button type="button" class="btn btn-ghost" onclick="checkEmailDuplicate()" style="padding: 8px 12px; font-size: 12px;">중복체크</button>
                            </div>
                            <div id="email-status" style="font-size: 12px; margin-top: 4px;"></div>
                        </div>
                    </li>
                    <li class="info-item">
                        <b>닉네임</b> 
                        <span id="nickname-display">불러오는 중...</span>
                        <div class="edit-mode" id="nickname-edit">
                            <div style="display: flex; gap: 8px; align-items: center;">
                                <input type="text" id="nickname-input" placeholder="닉네임을 입력하세요" style="flex: 1;">
                                <button type="button" class="btn btn-ghost" onclick="checkNicknameDuplicate()" style="padding: 8px 12px; font-size: 12px;">중복체크</button>
                            </div>
                            <div id="nickname-status" style="font-size: 12px; margin-top: 4px;"></div>
                        </div>
                    </li>
                </ul>

                <div class="cta">
                    <a class="btn btn-primary" href="/branch/list">주문하러 가기</a>
                    <a class="btn btn-ghost" href="/favorites">즐겨찾기</a>
                    <button class="btn btn-ghost" id="edit-btn" onclick="toggleEditMode()">정보 수정</button>
                </div>

                <div class="edit-mode" id="edit-controls" style="text-align: center; margin: 20px 0;">
                    <button class="btn btn-primary" onclick="saveProfile()">저장</button>
                    <button class="btn btn-ghost" onclick="cancelEdit()">취소</button>
                </div>

                <script>
                    let isEditMode = false;
                    let originalData = {};

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

                    // 편집 모드 토글
                    function toggleEditMode() {
                        isEditMode = !isEditMode;
                        
                        if (isEditMode) {
                            // 편집 모드로 전환
                            document.getElementById('edit-btn').style.display = 'none';
                            document.getElementById('edit-controls').style.display = 'block';
                            
                            // 모든 편집 필드 표시
                            document.querySelectorAll('.edit-mode').forEach(el => {
                                if (el.id !== 'edit-controls') {
                                    el.style.display = 'block';
                                }
                            });
                            
                            // 현재 값들을 입력 필드에 설정
                            document.getElementById('name-input').value = originalData.name || '';
                            document.getElementById('phone-input').value = originalData.phone || '';
                            document.getElementById('email-input').value = originalData.email || '';
                            document.getElementById('nickname-input').value = originalData.nickname || '';
                            
                            // 중복 확인 상태 초기화
                            document.getElementById('email-status').textContent = '';
                            document.getElementById('nickname-status').textContent = '';
                            
                        } else {
                            // 보기 모드로 전환
                            document.getElementById('edit-btn').style.display = 'block';
                            document.getElementById('edit-controls').style.display = 'none';
                            
                            // 모든 편집 필드 숨김
                            document.querySelectorAll('.edit-mode').forEach(el => {
                                if (el.id !== 'edit-controls') {
                                    el.style.display = 'none';
                                }
                            });
                        }
                    }

                    // 편집 취소
                    function cancelEdit() {
                        toggleEditMode();
                    }

                    // 한글 라벨 변환 (signup.jsp와 동일)
                    function toKoreanField(f) {
                        switch(f) {
                            case 'id': return '아이디';
                            case 'nickname': return '닉네임';
                            case 'email': return '이메일';
                            default: return '아이디';
                        }
                    }

                    // 2단계 폴백 방식 중복체크 함수 (signup.jsp와 동일)
                    async function checkDup(endpoint, value, msgEl, label) {
                        // 허용되지 않은 endpoint가 오면 기본값 id로 보정
                        const field = (endpoint === 'id' || endpoint === 'nickname' || endpoint === 'email') ? endpoint : 'id';
                        // 라벨은 항상 필드에서 도출하여 빈 문자열 문제 방지
                        const labelText = toKoreanField(field);
                        if (!value) { 
                            msgEl.textContent = labelText + '를 입력해주세요.'; 
                            msgEl.className = 'msg bad'; 
                            return; 
                        }
                        
                        const q = encodeURIComponent(value);
                        try {
                            // 1차 시도: 쿼리 파라미터 방식 (/check?type={field}&value=...)
                            const url1 = '/api/auth/check?type=' + encodeURIComponent(field) + '&value=' + q;
                            console.log('[dup-check] try1', field, url1);
                            let res = await fetch(url1);
                            
                            // 2차 시도: RESTful 경로 (/check/{field}?value=...)
                            if (!res.ok) {
                                const url2 = '/api/auth/check/' + encodeURIComponent(field) + '?value=' + q;
                                console.log('[dup-check] try2', field, url2);
                                res = await fetch(url2);
                            }
                            
                            if (!res.ok) throw new Error('중복체크 실패');
                            
                            const data = await res.json();
                            const lbl = toKoreanField((data && data.field) ? data.field : field);
                            if (data.duplicate) {
                                msgEl.textContent = '이미 사용 중인 ' + lbl + '입니다.';
                                msgEl.className = 'msg bad';
                            } else {
                                msgEl.textContent = '사용 가능한 ' + lbl + '입니다.';
                                msgEl.className = 'msg ok';
                            }
                        } catch(e) {
                            msgEl.textContent = '요청 중 오류가 발생했습니다.';
                            msgEl.className = 'msg bad';
                        }
                    }

                    // 이메일 중복 확인
                    function checkEmailDuplicate() {
                        const email = document.getElementById('email-input').value;
                        const statusDiv = document.getElementById('email-status');
                        
                        if (!email) {
                            alert('이메일을 입력해주세요.');
                            return;
                        }

                        // 현재 이메일과 같으면 중복 확인하지 않음
                        if (email === originalData.email) {
                            statusDiv.textContent = '현재 사용 중인 이메일입니다.';
                            statusDiv.style.color = '#666';
                            return;
                        }

                        checkDup('email', email, statusDiv, '이메일');
                    }

                    // 닉네임 중복 확인
                    function checkNicknameDuplicate() {
                        const nickname = document.getElementById('nickname-input').value;
                        const statusDiv = document.getElementById('nickname-status');
                        
                        if (!nickname) {
                            alert('닉네임을 입력해주세요.');
                            return;
                        }

                        // 현재 닉네임과 같으면 중복 확인하지 않음
                        if (nickname === originalData.nickname) {
                            statusDiv.textContent = '현재 사용 중인 닉네임입니다.';
                            statusDiv.style.color = '#666';
                            return;
                        }

                        checkDup('nickname', nickname, statusDiv, '닉네임');
                    }



                    // 프로필 저장
                    function saveProfile() {
                        const email = document.getElementById('email-input').value;
                        const nickname = document.getElementById('nickname-input').value;
                        const emailStatus = document.getElementById('email-status').textContent;
                        const nicknameStatus = document.getElementById('nickname-status').textContent;

                        // 이메일이 변경되었는데 중복 확인을 하지 않은 경우
                        if (email && email !== originalData.email && !emailStatus.includes('사용 가능') && !emailStatus.includes('현재 사용 중')) {
                            alert('이메일 중복체크를 해주세요.');
                            return;
                        }

                        // 닉네임이 변경되었는데 중복 확인을 하지 않은 경우
                        if (nickname && nickname !== originalData.nickname && !nicknameStatus.includes('사용 가능') && !nicknameStatus.includes('현재 사용 중')) {
                            alert('닉네임 중복체크를 해주세요.');
                            return;
                        }

                        // 중복된 값으로는 저장 불가
                        if (email && email !== originalData.email && emailStatus.includes('이미 사용 중')) {
                            alert('이메일이 중복됩니다. 다른 이메일을 입력해주세요.');
                            return;
                        }

                        if (nickname && nickname !== originalData.nickname && nicknameStatus.includes('이미 사용 중')) {
                            alert('닉네임이 중복됩니다. 다른 닉네임을 입력해주세요.');
                            return;
                        }

                        const requestData = {
                            name: document.getElementById('name-input').value,
                            phone: document.getElementById('phone-input').value,
                            email: email,
                            nickname: nickname
                        };

                        fetch('/api/users/me', {
                            method: 'PUT',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify(requestData)
                        })
                        .then(response => {
                            if (response.ok) {
                                // 성공 시 페이지 새로고침
                                location.reload();
                            } else {
                                alert('프로필 수정에 실패했습니다.');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('프로필 수정 중 오류가 발생했습니다.');
                        });
                    }

                    // 페이지 로드 시 사용자 정보 가져오기
                    (async function(){
                        try {
                            const res = await fetch('/api/users/me');
                            if (!res.ok) {
                                if (res.status === 401) {
                                    alert('로그인이 필요합니다. 로그인 페이지로 이동합니다.');
                                    window.location.href = '/auth/login';
                                    return;
                                }
                                return; // 기타 오류
                            }
                            const data = await res.json();
                            
                            // 원본 데이터 저장
                            originalData = data;
                            
                            // 화면에 표시
                            if (data.name) document.getElementById('name-display').textContent = data.name;
                            if (data.phone) document.getElementById('phone-display').textContent = formatPhone(data.phone);
                            if (data.email) document.getElementById('email-display').textContent = data.email;
                            if (data.nickname) document.getElementById('nickname-display').textContent = data.nickname;
                        } catch (e) { 
                            console.error('사용자 정보 로드 오류:', e);
                            alert('사용자 정보를 불러올 수 없습니다. 로그인 페이지로 이동합니다.');
                            window.location.href = '/auth/login';
                        }
                    })();
                </script>
            </div>
        </div>
    </div>
    
</main>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
