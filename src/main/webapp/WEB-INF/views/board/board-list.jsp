<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

        .category-tabs {
            display: flex;
            border-bottom: 2px solid #e9ecef;
            margin-bottom: 30px;
        }

        .tab {
            padding: 15px 25px;
            cursor: pointer;
            border: none;
            background: none;
            font-size: 16px;
            font-weight: 500;
            color: #6c757d;
            transition: all 0.3s ease;
            border-bottom: 3px solid transparent;
        }

        .tab.active {
            color: #007bff;
            border-bottom-color: #007bff;
        }

        .tab:hover {
            color: #007bff;
        }

        .board-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        .board-table th,
        .board-table td {
            padding: 15px 10px;
            text-align: left;
            border-bottom: 1px solid #e9ecef;
        }

        .board-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #495057;
        }

        .board-table tbody tr:hover {
            background-color: #f8f9fa;
        }

        .post-title-container {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .post-title {
            color: #333;
            text-decoration: none;
            font-weight: 500;
        }

        .post-title:hover {
            color: #007bff;
        }

        .status-badge {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-badge.pending {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }

        .status-badge.answered {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .write-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease;
        }

        .write-btn:hover {
            transform: translateY(-2px);
        }


        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-top: 30px;
        }

        .page-btn {
            padding: 8px 12px;
            border: 1px solid #dee2e6;
            background: white;
            color: #495057;
            text-decoration: none;
            border-radius: 4px;
            transition: all 0.2s ease;
        }

        .page-btn:hover {
            background-color: #e9ecef;
        }

        .page-btn.active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }

        .empty-state h3 {
            margin-bottom: 10px;
            color: #495057;
        }

        .delete-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }

        .delete-btn:hover {
            background: #c82333;
        }

        .action-cell {
            width: 80px;
            text-align: center;
        }

        .cta {
            display: flex;
            gap: 12px;
            margin-top: 30px;
            justify-content: space-between;
            align-items: center;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.2s ease;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }

        .btn-ghost {
            background: transparent;
            color: #6c757d;
            border: 1px solid #dee2e6;
        }

        .btn-ghost:hover {
            background: #f8f9fa;
            color: #495057;
        }
    </style>
</head>
<body>
    <div class="board-main-container">
        <div class="container">
            <!-- 메인 콘텐츠 영역 -->
            <div class="main-content">
            <!-- 카테고리 탭 -->
            <div class="category-tabs">
                <button class="tab" onclick="loadBoard(1, 0)">공지사항</button>
                <button class="tab active" onclick="loadBoard(2, 0)">1대1문의</button>
                <button class="tab" onclick="loadBoard(3, 0)">FAQ</button>
            </div>

            <!-- 게시글 목록 -->
            <div id="boardList">
                <table class="board-table">
                    <thead>
                        <tr>
                            <th style="width: 80px;">번호</th>
                            <th>제목</th>
                            <th style="width: 100px;">작성자</th>
                            <th style="width: 120px;">작성일자</th>
                            <th style="width: 80px;">조회수</th>
                            <th class="action-cell"></th>
                        </tr>
                    </thead>
                    <tbody id="boardTableBody">
                        <!-- 게시글 목록이 여기에 동적으로 로드됩니다 -->
                    </tbody>
                </table>

                <!-- 빈 상태 -->
                <div id="emptyState" class="empty-state" style="display: none;">
                    <h3>게시글이 없습니다</h3>
                    <p>아직 등록된 게시글이 없습니다.</p>
                </div>

                <!-- 페이지네이션 -->
                <div id="pagination" class="pagination">
                    <!-- 페이지네이션이 여기에 동적으로 로드됩니다 -->
                </div>

                <!-- CTA 버튼들 -->
                <div class="cta">
                    <a class="btn btn-primary" href="/branch/list">주문하러 가기</a>
                    <button class="write-btn" onclick="goToWrite()">글쓰기</button>
                </div>
            </div>
            </div>
        </div>
    </div>

    <script>
        // 전역 변수 선언
        var currentBoardType = 2; // 기본값: 1대1문의
        var currentPage = 0;
        var totalPages = 0;
        var currentMemberId = null; // 현재 로그인한 사용자 ID

        // 페이지 로드 시 초기 데이터 로드
        document.addEventListener('DOMContentLoaded', function() {
            console.log('=== DOMContentLoaded START ===');
            console.log('currentBoardType:', currentBoardType);
            console.log('currentPage:', currentPage);
            console.log('Page loaded, calling loadBoard(2)');
            console.log('About to call loadBoard with boardTypeId=2, page=0');
            
            // 현재 로그인한 사용자 정보 가져오기
            getCurrentUser();
            
            // 명시적으로 숫자 값 전달
            loadBoard(2, 0);
        });

        // 게시판 로드 함수
        function loadBoard(boardTypeId, page) {
            console.log('=== loadBoard START ===');
            console.log('Arguments received:', arguments);
            console.log('boardTypeId:', boardTypeId, 'type:', typeof boardTypeId);
            console.log('page:', page, 'type:', typeof page);
            
            // page 기본값 설정
            if (page === undefined || page === null) {
                page = 0;
            }
            
            // 파라미터 검증 및 강제 변환
            if (boardTypeId === undefined || boardTypeId === null || boardTypeId === '') {
                console.error('boardTypeId is invalid:', boardTypeId);
                showEmptyState();
                return;
            }
            
            // 문자열을 숫자로 변환
            var convertedBoardTypeId = parseInt(boardTypeId);
            var convertedPage = parseInt(page) || 0;
            
            console.log('After conversion - boardTypeId:', convertedBoardTypeId, 'page:', convertedPage);
            
            if (isNaN(convertedBoardTypeId) || convertedBoardTypeId < 1 || convertedBoardTypeId > 3) {
                console.error('Invalid boardTypeId:', convertedBoardTypeId);
                showEmptyState();
                return;
            }
            
            // 변환된 값 사용
            var finalBoardTypeId = convertedBoardTypeId;
            var finalPage = convertedPage;
            
            console.log('Final values - boardTypeId:', finalBoardTypeId, 'page:', finalPage);
            
            currentBoardType = finalBoardTypeId;
            currentPage = finalPage;

            // 탭 활성화 상태 변경
            document.querySelectorAll('.tab').forEach(tab => tab.classList.remove('active'));
            
            // boardTypeId에 해당하는 탭을 활성화
            const tabs = document.querySelectorAll('.tab');
            if (boardTypeId === 1) tabs[0].classList.add('active');
            else if (boardTypeId === 2) tabs[1].classList.add('active');
            else if (boardTypeId === 3) tabs[2].classList.add('active');

            // API 호출 전 최종 검증
            if (!boardTypeId || boardTypeId === '' || isNaN(boardTypeId)) {
                console.error('Invalid boardTypeId for API call:', boardTypeId);
                showEmptyState();
                return;
            }
            
            console.log('Calling API with boardTypeId:', finalBoardTypeId, 'page:', finalPage);
            
            // URL을 더 명시적으로 생성
            var url = '/boards?boardTypeId=' + finalBoardTypeId + '&page=' + finalPage + '&size=10';
            console.log('API URL:', url);
            console.log('URL parts - boardTypeId:', finalBoardTypeId, 'page:', finalPage);
            
            // URL이 올바른지 확인
            if (url.includes('boardTypeId=&') || url.includes('page=&')) {
                console.error('URL contains empty parameters:', url);
                console.error('boardTypeId value:', boardTypeId, 'type:', typeof boardTypeId);
                console.error('page value:', page, 'type:', typeof page);
                showEmptyState();
                return;
            }
            
            fetch(url, {
                credentials: 'same-origin'
            })
                .then(response => {
                    console.log('API response status:', response.status);
                    if (!response.ok) {
                        throw new Error('Network response was not ok: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('API response data:', data);
                    displayBoardList(data);
                })
                .catch(error => {
                    console.error('API Error:', error);
                    showEmptyState();
                });
        }

        // 게시글 목록 표시
        function displayBoardList(data) {
            console.log('=== displayBoardList called ===');
            console.log('data:', data);
            console.log('data.boards:', data.boards);
            console.log('data.boards.length:', data.boards ? data.boards.length : 'undefined');
            
            const tbody = document.getElementById('boardTableBody');
            const emptyState = document.getElementById('emptyState');
            const pagination = document.getElementById('pagination');

            if (data.boards && data.boards.length > 0) {
                console.log('Displaying board list with', data.boards.length, 'items');
                tbody.innerHTML = '';
                data.boards.forEach((board, index) => {
                    console.log('Processing board:', board);
                    console.log('Board id:', board.id, 'type:', typeof board.id);
                    console.log('Board title:', board.title);
                    console.log('Board memberNickname:', board.memberNickname);
                    console.log('Board field:', board.field);
                    
                    const row = document.createElement('tr');
                    
                    // 번호 계산
                    const rowNumber = data.totalCount - (currentPage * 10 + index);
                    
                    // board.id가 유효한지 확인
                    if (!board.id) {
                        console.error('Board ID is missing for board:', board);
                        return;
                    }
                    
                    // 날짜 포맷팅 (분까지만)
                    var formattedDate = formatDateToMinute(board.field);
                    
                    // 삭제 버튼 HTML (본인 글인 경우에만)
                    var deleteButtonHtml = '';
                    if (currentMemberId && board.memberId === currentMemberId) {
                        deleteButtonHtml = '<button class="delete-btn" onclick="deletePost(' + board.id + ')">삭제</button>';
                    }
                    
                    // 답변상태 배지 생성
                    var statusBadge = '';
                    if (board.statusTag === 'ANSWERED') {
                        statusBadge = '<span class="status-badge answered">답변완료</span>';
                    } else {
                        statusBadge = '<span class="status-badge pending">답변대기</span>';
                    }
                    
                    // HTML을 문자열 연결로 생성
                    row.innerHTML = '<td>' + rowNumber + '</td>' +
                                   '<td><div class="post-title-container"><a href="#" class="post-title" onclick="viewPost(' + board.id + ')">' + board.title + '</a>' + statusBadge + '</div></td>' +
                                   '<td>' + board.memberNickname + '</td>' +
                                   '<td>' + formattedDate + '</td>' +
                                   '<td>0</td>' +
                                   '<td class="action-cell">' + deleteButtonHtml + '</td>';
                    
                    console.log('Created row HTML:', row.innerHTML);
                    tbody.appendChild(row);
                });

                emptyState.style.display = 'none';
                displayPagination(data);
            } else {
                console.log('No boards found, showing empty state');
                showEmptyState();
            }
        }

        // 빈 상태 표시
        function showEmptyState() {
            document.getElementById('boardTableBody').innerHTML = '';
            document.getElementById('emptyState').style.display = 'block';
            document.getElementById('pagination').innerHTML = '';
        }

        // 페이지네이션 표시
        function displayPagination(data) {
            const pagination = document.getElementById('pagination');
            pagination.innerHTML = '';

            totalPages = data.totalPages;

            // 이전 페이지 버튼
            if (currentPage > 0) {
                const prevBtn = document.createElement('a');
                prevBtn.href = '#';
                prevBtn.className = 'page-btn';
                prevBtn.textContent = '이전';
                prevBtn.onclick = (e) => {
                    e.preventDefault();
                    loadBoard(currentBoardType, currentPage - 1);
                };
                pagination.appendChild(prevBtn);
            }

            // 페이지 번호들
            const startPage = Math.max(0, currentPage - 2);
            const endPage = Math.min(totalPages - 1, currentPage + 2);

            for (let i = startPage; i <= endPage; i++) {
                const pageBtn = document.createElement('a');
                pageBtn.href = '#';
                pageBtn.className = `page-btn ${i == currentPage ? 'active' : ''}`;
                pageBtn.textContent = i + 1;
                pageBtn.onclick = (e) => {
                    e.preventDefault();
                    loadBoard(currentBoardType, i);
                };
                pagination.appendChild(pageBtn);
            }

            // 다음 페이지 버튼
            if (currentPage < totalPages - 1) {
                const nextBtn = document.createElement('a');
                nextBtn.href = '#';
                nextBtn.className = 'page-btn';
                nextBtn.textContent = '다음';
                nextBtn.onclick = (e) => {
                    e.preventDefault();
                    loadBoard(currentBoardType, currentPage + 1);
                };
                pagination.appendChild(nextBtn);
            }
        }

        // 게시글 상세보기
        function viewPost(boardId) {
            console.log('viewPost called with boardId:', boardId);
            console.log('boardId type:', typeof boardId);
            
            if (!boardId) {
                console.error('boardId is null or undefined');
                alert('게시글 ID가 올바르지 않습니다.');
                return;
            }
            
            var detailUrl = '/boards/detail/' + boardId;
            console.log('Redirecting to:', detailUrl);
            window.location.href = detailUrl;
        }

        // 글쓰기 페이지로 이동
        function goToWrite() {
            window.location.href = '/boards/write';
        }

        // 현재 로그인한 사용자 정보 가져오기
        function getCurrentUser() {
            fetch('/api/users/me', {
                credentials: 'same-origin'
            })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    console.log('User not logged in or API not available');
                    return null;
                }
            })
            .then(data => {
                if (data && data.memberId) {
                    currentMemberId = data.memberId;
                    console.log('Current user ID:', currentMemberId);
                } else {
                    console.log('No user data available');
                }
            })
            .catch(error => {
                console.log('Error getting user info:', error);
            });
        }

        // 게시글 삭제
        function deletePost(boardId) {
            console.log('deletePost called with boardId:', boardId);
            
            if (!boardId) {
                console.error('boardId is null or undefined');
                alert('게시글 ID가 올바르지 않습니다.');
                return;
            }
            
            // 삭제 확인
            if (!confirm('정말로 이 게시글을 삭제하시겠습니까?')) {
                return;
            }
            
            fetch('/boards/' + boardId, {
                method: 'DELETE',
                credentials: 'same-origin'
            })
            .then(response => {
                console.log('Delete response status:', response.status);
                if (!response.ok) {
                    throw new Error('Network response was not ok: ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                console.log('Delete response data:', data);
                if (data.success) {
                    alert('게시글이 삭제되었습니다.');
                    // 목록 새로고침
                    loadBoard(currentBoardType, currentPage);
                } else {
                    alert('삭제 실패: ' + (data.message || '알 수 없는 오류'));
                }
            })
            .catch(error => {
                console.error('Delete error:', error);
                alert('삭제 중 오류가 발생했습니다: ' + error.message);
            });
        }

        // 날짜 포맷팅 (분까지만)
        function formatDateToMinute(dateString) {
            const date = new Date(dateString);
            return date.toLocaleString('ko-KR', {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit',
                hour: '2-digit',
                minute: '2-digit',
                hour12: false
            }).replace(/\./g, '.').replace(/\s/g, ' ');
        }

        // 날짜 포맷팅 (기존 함수 - 상세 페이지용)
        function formatDate(dateString) {
            const date = new Date(dateString);
            return date.toLocaleDateString('ko-KR', {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit'
            }).replace(/\./g, '.').replace(/\s/g, '');
        }
    </script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
