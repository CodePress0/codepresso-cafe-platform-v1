<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" session="false" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<body>
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="hero">
    <div class="container">
        <div class="hero-card signup-card">
            <div>
                <div class="badge">CodePress · 회원가입</div>
                <h1>지금 CodePress에 가입하세요</h1>
                <p>아이디, 비밀번호, 닉네임, 이메일만 입력하면 끝!</p>

                <style>
                    /* 회원가입 페이지는 마스코트 영역 없이 단일 컬럼으로 표시 */
                    .signup-card {
                        grid-template-columns: 1fr;
                        width: 100%;
                        max-width: 640px;   /* 카드 전체 너비 더 축소 */
                        margin: 0 auto;     /* 가운데 정렬 */
                        padding: 24px;      /* 패딩도 조금 더 줄임 */
                        text-align: center; /* 상단 문구 중앙 정렬 */
                    }
                    .form { display: grid; gap: 14px; max-width: 380px; margin: 0 auto; text-align: left; }
                    .field { display: grid; gap: 6px; }
                    .row { display: flex; gap: 8px; }
                    .row > button { white-space: nowrap; }
                    label { font-weight: 700; }
                    input[type=text], input[type=password], input[type=email] {
                        width: 100%; padding: 12px 12px; border-radius: 10px; border: 1px solid rgba(0,0,0,.12);
                        outline: none; transition: border .2s, box-shadow .2s;
                    }
                    input:focus { border-color: var(--pink-1); box-shadow: 0 0 0 3px rgba(255,122,162,.18); }
                    .btn.secondary { background: var(--white); color: var(--text-1); border: 1px solid rgba(0,0,0,.06); }
                    .hint { font-size: 12px; color: var(--text-2); }
                    .msg { font-size: 13px; }
                    .ok { color: #2f855a; }
                    .bad { color: #c53030; }
                    .links { margin-top: 8px; display: flex; gap: 16px; }
                    .links a { color: var(--pink-1); text-decoration: none; font-weight: 700; }
                </style>

                <div class="form">
                    <div class="field">
                        <label for="accountId">아이디</label>
                        <div class="row">
                            <input type="text" id="accountId" placeholder="아이디 입력" />
                            <button class="btn secondary" id="checkIdBtn">중복체크</button>
                        </div>
                        <div class="msg" id="idMsg"></div>
                    </div>

                    <div class="field">
                        <label for="password">비밀번호</label>
                        <input type="password" id="password" placeholder="비밀번호 입력" />
                        <div class="hint">6자 이상, 영문/숫자 포함</div>
                        <div class="msg" id="pwMsg"></div>
                    </div>

                    <div class="field">
                        <label for="nickname">닉네임</label>
                        <div class="row">
                            <input type="text" id="nickname" placeholder="닉네임 입력" />
                            <button class="btn secondary" id="checkNicknameBtn">중복체크</button>
                        </div>
                        <div class="msg" id="nicknameMsg"></div>
                    </div>

                    <div class="field">
                        <label for="email">이메일</label>
                        <div class="row">
                            <input type="email" id="email" placeholder="example@domain.com" />
                            <button class="btn secondary" id="checkEmailBtn">중복체크</button>
                        </div>
                        <div class="msg" id="emailMsg"></div>
                    </div>

                    <div class="field">
                        <button class="btn btn-primary" id="signupBtn">회원가입</button>
                    </div>

                    <div class="links">
                        <a href="#" onclick="alert('아이디 찾기 화면 (준비중)'); return false;">아이디 찾기</a>
                        <a href="#" onclick="alert('비밀번호 찾기 화면 (준비중)'); return false;">비밀번호 찾기</a>
                    </div>
                </div>
            </div>

            
        </div>
    </div>
</main>

<script>
    // ===== 1) DOM 요소 참조 =====
    const idInput = document.getElementById('accountId');
    const pwInput = document.getElementById('password');
    const nickInput = document.getElementById('nickname');
    const emailInput = document.getElementById('email');

    const idMsg = document.getElementById('idMsg');
    const pwMsg = document.getElementById('pwMsg');
    const nicknameMsg = document.getElementById('nicknameMsg');
    const emailMsg = document.getElementById('emailMsg');

    // ===== 2) 유효성 검사 규칙 =====
    // - accountId: 4~50자, 영문/숫자/밑줄
    // - password: 6~100자, 영문 + 숫자 포함
    // - nickname: 2~50자 (문자 조합은 자유, 필요 시 제약 추가 가능)
    // - email: 간단한 이메일 형식
    const patterns = {
        accountId: /^[A-Za-z0-9_]{4,50}$/,
        password: /^(?=.*[A-Za-z])(?=.*\d).{6,100}$/,
        email: /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    };

    function setMsg(el, text, ok){
        el.textContent = text;
        el.className = ok ? 'msg ok' : 'msg bad';
    }

    // ===== 3) 유효성 검사 함수 =====
    function validateAccountId(val){
        if(!val) return '아이디를 입력해주세요.';
        if(!patterns.accountId.test(val)) return '아이디는 4~50자, 영문/숫자/밑줄만 가능합니다.';
        return '';
    }
    function validatePassword(val){
        if(!val) return '비밀번호를 입력해주세요.';
        if(!patterns.password.test(val)) return '비밀번호는 6~100자이며 영문과 숫자를 포함해야 합니다.';
        return '';
    }
    function validateNickname(val){
        if(!val) return '닉네임을 입력해주세요.';
        const len = val.length;
        if(len < 2 || len > 50) return '닉네임은 2~50자여야 합니다.';
        return '';
    }
    function validateEmail(val){
        if(!val) return '이메일을 입력해주세요.';
        if(!patterns.email.test(val)) return '올바른 이메일 형식이 아닙니다.';
        return '';
    }

    // ===== 4) 한글 라벨 변환 =====
    function toKoreanField(f){
        switch(f){
            case 'id': return '아이디';
            case 'nickname': return '닉네임';
            case 'email': return '이메일';
            default: return '아이디';
        }
    }

    // ===== 5) 중복체크 요청 함수 =====
    // - endpoint: 'id' | 'nickname' | 'email'
    // - 우선 /api/auth/check?type={field}&value=... 로 호출 (명확한 파라미터)
    // - 실패 시 /api/auth/check/{field}?value=... 로 재시도 (RESTful 폴백)
    // - 주의: JSP의 $ { } EL과 충돌 방지를 위해 템플릿 리터럴을 쓰지 않고 문자열 결합 사용
    async function checkDup(endpoint, value, msgEl, label){
        // 허용되지 않은 endpoint가 오면 기본값 id로 보정
        const field = (endpoint === 'id' || endpoint === 'nickname' || endpoint === 'email') ? endpoint : 'id';
        // 라벨은 항상 필드에서 도출하여 빈 문자열 문제 방지
        const labelText = toKoreanField(field);
        if(!value){ msgEl.textContent = labelText + '를 입력해주세요.'; msgEl.className='msg bad'; return; }
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

    // 입력값 블러 시 즉시 유효성 메시지 표시
    // idInput.addEventListener('blur', () => {
    //     const m = validateAccountId(idInput.value.trim());
    //     if(m) setMsg(idMsg, m, false); else setMsg(idMsg, '형식이 유효합니다.', true);
    // });
    // pwInput.addEventListener('blur', () => {
    //     const m = validatePassword(pwInput.value.trim());
    //     if(m) setMsg(pwMsg, m, false); else setMsg(pwMsg, '형식이 유효합니다.', true);
    // });
    // nickInput.addEventListener('blur', () => {
    //     const m = validateNickname(nickInput.value.trim());
    //     if(m) setMsg(nicknameMsg, m, false); else setMsg(nicknameMsg, '형식이 유효합니다.', true);
    // });
    // emailInput.addEventListener('blur', () => {
    //     const m = validateEmail(emailInput.value.trim());
    //     if(m) setMsg(emailMsg, m, false); else setMsg(emailMsg, '형식이 유효합니다.', true);
    // });

    // ===== 6) 이벤트 바인딩 =====
    // 중복 체크 버튼: 유효할 때만 서버 요청
    document.getElementById('checkIdBtn').addEventListener('click', () => {
        const m = validateAccountId(idInput.value.trim());
        if(m) { setMsg(idMsg, m, false); return; }
        checkDup('id', idInput.value.trim(), idMsg, '아이디');
    });
    document.getElementById('checkNicknameBtn').addEventListener('click', () => {
        const m = validateNickname(nickInput.value.trim());
        if(m) { setMsg(nicknameMsg, m, false); return; }
        checkDup('nickname', nickInput.value.trim(), nicknameMsg, '닉네임');
    });
    document.getElementById('checkEmailBtn').addEventListener('click', () => {
        const m = validateEmail(emailInput.value.trim());
        if(m) { setMsg(emailMsg, m, false); return; }
        checkDup('email', emailInput.value.trim(), emailMsg, '이메일');
    });

    document.getElementById('signupBtn').addEventListener('click', async () => {
        const accountId = idInput.value.trim();
        const password = pwInput.value.trim();
        const nickname = nickInput.value.trim();
        const email = emailInput.value.trim();

        // 종합 유효성 검사
        const v = [
            {m: validateAccountId(accountId), el: idMsg, focusEl: idInput},
            {m: validatePassword(password), el: pwMsg, focusEl: pwInput},
            {m: validateNickname(nickname), el: nicknameMsg, focusEl: nickInput},
            {m: validateEmail(email), el: emailMsg, focusEl: emailInput}
        ];
        const firstInvalid = v.find(x => x.m);
        if(firstInvalid){
            setMsg(firstInvalid.el, firstInvalid.m, false);
            firstInvalid.focusEl.focus();
            alert('입력값을 확인해주세요.');
            return;
        }

        try{
            const res = await fetch('/api/auth/signup', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ accountId, password, nickname, email })
            });
            if(!res.ok){
                const msg = await res.text();
                alert('회원가입 실패: ' + msg);
                return;
            }
            const data = await res.json();
            // 성공 알림은 모달로 표시되며, 사용자가 확인을 누르면 다음 줄이 실행됩니다.
            alert('회원가입을 축하합니다! ' + data.nickname + '님');
            // 확인을 누른 뒤 메인 페이지로 이동합니다.
            location.href = '/';
        }catch(e){
            alert('요청 중 오류가 발생했습니다.');
        }
    });
</script>
<%@ include file="/WEB-INF/views/common/footer.jspf" %>
