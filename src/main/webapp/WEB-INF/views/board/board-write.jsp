<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<body>
<%@ include file="/WEB-INF/views/common/header.jspf" %>
    <style>
        /* 게시판 페이지 전용 스타일 - 헤더에 영향 주지 않도록 메인 콘텐츠만 타겟팅 */
        .board-main-container {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        .board-main-container * {
            box-sizing: border-box;
        }

        .board-main-container .container {
            max-width: 100%;
            width: 100%;
            margin: 0 auto;
            padding: 20px 200px;
        }

        .board-main-container .main-content {
            background: white;
            border-radius: 12px;
            padding: 80px 120px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            max-width: 2000px;
            width: 100%;
            margin: 0 auto;
        }

        .page-header {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e9ecef;
        }

        .page-title {
            font-size: 24px;
            font-weight: 600;
            color: #333;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #495057;
            font-size: 16px;
        }

        .form-label.required::after {
            content: ' *';
            color: #dc3545;
        }

        .form-input {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.2s ease;
            font-family: inherit;
        }

        .form-input:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
        }

        .form-textarea {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 16px;
            min-height: 300px;
            resize: vertical;
            transition: border-color 0.2s ease;
            font-family: inherit;
            line-height: 1.6;
        }

        .form-textarea:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
        }

        .form-select {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 16px;
            background-color: white;
            cursor: pointer;
            transition: border-color 0.2s ease;
        }

        .form-select:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
        }

        .submit-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease;
            width: 100%;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
        }

        .submit-btn:disabled {
            background: #6c757d;
            cursor: not-allowed;
            transform: none;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: background-color 0.2s ease;
            flex: 1;
            writing-mode: horizontal-tb;
            text-orientation: mixed;
            white-space: nowrap;
        }

        .btn-secondary:hover {
            background-color: #545b62;
        }


        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 12px 16px;
            border-radius: 6px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
            display: none;
        }

        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 12px 16px;
            border-radius: 6px;
            margin-bottom: 20px;
            border: 1px solid #c3e6cb;
            display: none;
        }

        .char-count {
            text-align: right;
            font-size: 12px;
            color: #6c757d;
            margin-top: 5px;
        }

        .char-count.warning {
            color: #ffc107;
        }

        .char-count.danger {
            color: #dc3545;
        }
    </style>
</head>
<body>
    <div class="board-main-container">
        <div class="container">
            <!-- 메인 콘텐츠 영역 -->
            <div class="main-content">
            <div class="page-header">
                <h1 class="page-title">글쓰기</h1>
            </div>

            <!-- 에러 메시지 -->
            <div id="errorMessage" class="error-message"></div>
            
            <!-- 성공 메시지 -->
            <div id="successMessage" class="success-message"></div>

            <form id="writeForm">
                <div class="form-group">
                    <label for="boardTypeId" class="form-label required">게시판 선택</label>
                    <select id="boardTypeId" name="boardTypeId" class="form-select" required>
                        <option value="">게시판을 선택하세요</option>
                        <option value="1">공지사항</option>
                        <option value="2" selected>1대1문의</option>
                        <option value="3">FAQ</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="title" class="form-label required">제목</label>
                    <input type="text" id="title" name="title" class="form-input" 
                           placeholder="제목을 입력하세요" maxlength="200" required>
                    <div class="char-count" id="titleCount">0 / 200</div>
                </div>

                <div class="form-group">
                    <label for="content" class="form-label required">내용</label>
                    <textarea id="content" name="content" class="form-textarea" 
                              placeholder="내용을 입력하세요" required></textarea>
                    <div class="char-count" id="contentCount">0</div>
                </div>


                <div class="form-actions">
                    <button type="button" class="btn-secondary" onclick="goBack()">취소</button>
                    <button type="submit" class="submit-btn" id="submitBtn">제출하기</button>
                </div>
            </form>
            </div>
        </div>
    </div>

    <script>
        // 폼 요소들
        const form = document.getElementById('writeForm');
        const titleInput = document.getElementById('title');
        const contentInput = document.getElementById('content');
        const titleCount = document.getElementById('titleCount');
        const contentCount = document.getElementById('contentCount');
        const submitBtn = document.getElementById('submitBtn');

        // 페이지 로드 시 이벤트 리스너 설정
        document.addEventListener('DOMContentLoaded', function() {
            setupEventListeners();
        });

        // 이벤트 리스너 설정
        function setupEventListeners() {
            // 제목 입력 이벤트
            titleInput.addEventListener('input', function() {
                updateCharCount(titleInput, titleCount, 200);
            });

            // 내용 입력 이벤트
            contentInput.addEventListener('input', function() {
                updateCharCount(contentInput, contentCount);
            });

            // 폼 제출 이벤트
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                submitForm();
            });
        }

        // 글자 수 업데이트
        function updateCharCount(input, countElement, maxLength = null) {
            const length = input.value.length;
            countElement.textContent = maxLength ? `${length} / ${maxLength}` : length;
            
            // 경고 색상 설정
            if (maxLength) {
                if (length > maxLength * 0.9) {
                    countElement.className = 'char-count danger';
                } else if (length > maxLength * 0.8) {
                    countElement.className = 'char-count warning';
                } else {
                    countElement.className = 'char-count';
                }
            }
        }

        // 폼 제출
        function submitForm() {
            // 유효성 검사
            if (!validateForm()) {
                return;
            }

            // 제출 버튼 비활성화
            submitBtn.disabled = true;
            submitBtn.textContent = '제출 중...';

            // 폼 데이터 수집
            const formData = {
                title: titleInput.value.trim(),
                content: contentInput.value.trim(),
                statusTag: 'PENDING', // 항상 답변대기로 설정
                boardTypeId: parseInt(document.getElementById('boardTypeId').value)
            };

            // API 호출
            fetch('/boards', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData),
                credentials: 'same-origin'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showSuccess('게시글이 성공적으로 작성되었습니다.');
                    setTimeout(() => {
                        window.location.href = '/boards/list';
                    }, 1500);
                } else {
                    showError('게시글 작성 중 오류가 발생했습니다: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showError('게시글 작성 중 오류가 발생했습니다.');
            })
            .finally(() => {
                // 제출 버튼 활성화
                submitBtn.disabled = false;
                submitBtn.textContent = '제출하기';
            });
        }

        // 폼 유효성 검사
        function validateForm() {
            const title = titleInput.value.trim();
            const content = contentInput.value.trim();
            const boardTypeId = document.getElementById('boardTypeId').value;

            if (!boardTypeId) {
                showError('게시판을 선택해주세요.');
                return false;
            }

            if (!title) {
                showError('제목을 입력해주세요.');
                titleInput.focus();
                return false;
            }

            if (title.length > 200) {
                showError('제목은 200자를 초과할 수 없습니다.');
                titleInput.focus();
                return false;
            }

            if (!content) {
                showError('내용을 입력해주세요.');
                contentInput.focus();
                return false;
            }

            return true;
        }

        // 에러 메시지 표시
        function showError(message) {
            const errorDiv = document.getElementById('errorMessage');
            errorDiv.textContent = message;
            errorDiv.style.display = 'block';
            
            // 5초 후 자동 숨김
            setTimeout(() => {
                errorDiv.style.display = 'none';
            }, 5000);
        }

        // 성공 메시지 표시
        function showSuccess(message) {
            const successDiv = document.getElementById('successMessage');
            successDiv.textContent = message;
            successDiv.style.display = 'block';
        }

        // 뒤로가기
        function goBack() {
            if (confirm('작성 중인 내용이 사라집니다. 정말로 나가시겠습니까?')) {
                window.history.back();
            }
        }
    </script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
