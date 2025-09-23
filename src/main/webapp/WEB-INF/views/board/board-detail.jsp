<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 상세</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .main-content {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .post-header {
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 20px;
            margin-bottom: 30px;
        }

        .post-title {
            font-size: 24px;
            font-weight: 600;
            color: #333;
            margin-bottom: 15px;
            line-height: 1.4;
        }

        .post-meta {
            display: flex;
            gap: 20px;
            color: #6c757d;
            font-size: 14px;
        }

        .post-content {
            margin-bottom: 40px;
            line-height: 1.8;
            font-size: 16px;
            color: #333;
            white-space: pre-wrap;
            min-height: 200px;
        }

        .answer-section {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 25px;
            margin-top: 30px;
            border-left: 4px solid #28a745;
        }

        .answer-status {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .answer-status.pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .answer-status.completed {
            background-color: #d4edda;
            color: #155724;
        }

        .answer-content {
            background: white;
            padding: 20px;
            border-radius: 6px;
            border: 1px solid #dee2e6;
            line-height: 1.6;
            white-space: pre-wrap;
        }

        .answer-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 10px;
            display: block;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: all 0.2s ease;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #545b62;
        }

        .btn-outline {
            background-color: transparent;
            color: #6c757d;
            border: 1px solid #6c757d;
        }

        .btn-outline:hover {
            background-color: #6c757d;
            color: white;
        }


        .loading {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }

        .error {
            text-align: center;
            padding: 60px 20px;
            color: #dc3545;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 메인 콘텐츠 영역 -->
        <div class="main-content">
            <div id="postDetail">
                <!-- 로딩 상태 -->
                <div id="loading" class="loading">
                    <h3>게시글을 불러오는 중...</h3>
                </div>

                <!-- 에러 상태 -->
                <div id="error" class="error" style="display: none;">
                    <h3>게시글을 불러올 수 없습니다</h3>
                    <p>존재하지 않는 게시글이거나 권한이 없습니다.</p>
                </div>

                <!-- 게시글 내용 -->
                <div id="postContent" style="display: none;">
                    <div class="post-header">
                        <h1 class="post-title" id="postTitle"></h1>
                        <div class="post-meta">
                            <span>작성자: <span id="postAuthor"></span></span>
                            <span>작성일자: <span id="postDate"></span></span>
                        </div>
                    </div>

                    <div class="post-content" id="postContentText"></div>

                    <!-- 답변 섹션 -->
                    <div id="answerSection" class="answer-section" style="display: none;">
                        <span id="answerStatus" class="answer-status"></span>
                        <span class="answer-label">답변내용</span>
                        <div id="answerContent" class="answer-content"></div>
                    </div>

                    <!-- 액션 버튼들 -->
                    <div class="action-buttons">
                        <button class="btn btn-outline" onclick="goBack()">목록으로</button>
                        <button id="editBtn" class="btn btn-primary" onclick="editPost()" style="display: none;">수정</button>
                        <button id="deleteBtn" class="btn btn-secondary" onclick="deletePost()" style="display: none;">삭제</button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <script>
        // 전역 변수 선언
        var currentBoardId = null;
        var currentUserId = null;

        // 페이지 로드 시 게시글 상세 정보 로드
        document.addEventListener('DOMContentLoaded', function() {
            console.log('=== board-detail DOMContentLoaded START ===');
            
            var pathParts = window.location.pathname.split('/');
            currentBoardId = pathParts[pathParts.length - 1];
            
            console.log('currentBoardId:', currentBoardId);
            console.log('pathParts:', pathParts);
            
            // 현재 사용자 ID 가져오기 (세션에서)
            loadCurrentUser();
            loadPostDetail();
        });

        // 현재 사용자 정보 로드
        function loadCurrentUser() {
            console.log('Loading current user...');
            fetch('/api/users/me', {
                credentials: 'same-origin'
            })
                .then(response => {
                    console.log('User API response status:', response.status);
                    if (!response.ok) {
                        throw new Error('Network response was not ok: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('User data received:', data);
                    currentUserId = data.id;
                })
                .catch(error => {
                    console.error('Error loading user:', error);
                });
        }

        // 게시글 상세 정보 로드
        function loadPostDetail() {
            console.log('=== loadPostDetail START ===');
            console.log('Loading post detail for boardId:', currentBoardId);
            console.log('boardId type:', typeof currentBoardId);
            
            if (!currentBoardId) {
                console.error('currentBoardId is null or undefined');
                showError();
                return;
            }
            
            var url = '/boards/' + currentBoardId;
            console.log('API URL:', url);
            console.log('About to call fetch...');
            
            fetch(url, {
                credentials: 'same-origin'
            })
                .then(response => {
                    console.log('Post API response status:', response.status);
                    console.log('Response headers:', response.headers);
                    if (!response.ok) {
                        console.error('Response not ok:', response.status, response.statusText);
                        throw new Error('Post not found: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Post data received:', data);
                    console.log('Data type:', typeof data);
                    displayPostDetail(data);
                })
                .catch(error => {
                    console.error('Error loading post:', error);
                    console.error('Error stack:', error.stack);
                    showError();
                });
        }

        // 게시글 상세 정보 표시
        function displayPostDetail(data) {
            console.log('=== displayPostDetail START ===');
            console.log('Post data:', data);
            
            document.getElementById('loading').style.display = 'none';
            document.getElementById('postContent').style.display = 'block';

            // 기본 정보
            console.log('Setting post title:', data.title);
            console.log('Setting post author:', data.memberNickname);
            console.log('Setting post date:', data.field);
            console.log('Setting post content:', data.content);
            
            document.getElementById('postTitle').textContent = data.title;
            document.getElementById('postAuthor').textContent = data.memberNickname;
            document.getElementById('postDate').textContent = formatDate(data.field);
            document.getElementById('postContentText').textContent = data.content;

            // 답변 상태 확인 (statusTag 기반)
            var answerSection = document.getElementById('answerSection');
            var answerStatus = document.getElementById('answerStatus');
            var answerContent = document.getElementById('answerContent');

            console.log('Status tag:', data.statusTag);
            
            if (data.statusTag === 'ANSWERED') {
                answerSection.style.display = 'block';
                answerStatus.textContent = '답변상태: 답변완료';
                answerStatus.className = 'answer-status completed';
                
                // 실제 댓글(답변) 내용 표시
                if (data.children && data.children.length > 0) {
                    // 가장 최근 댓글을 답변으로 표시
                    var latestComment = data.children[data.children.length - 1];
                    answerContent.textContent = latestComment.content;
                } else {
                    answerContent.textContent = '답변이 등록되었습니다.';
                }
            } else {
                answerSection.style.display = 'block';
                answerStatus.textContent = '답변상태: 답변대기';
                answerStatus.className = 'answer-status pending';
                answerContent.textContent = '아직 답변이 등록되지 않았습니다. 빠른 시일 내에 답변드리겠습니다.';
            }

            // 작성자만 수정/삭제 버튼 표시
            if (currentUserId && currentUserId === data.memberId) {
                document.getElementById('editBtn').style.display = 'inline-block';
                document.getElementById('deleteBtn').style.display = 'inline-block';
            }
        }

        // 에러 표시
        function showError() {
            document.getElementById('loading').style.display = 'none';
            document.getElementById('error').style.display = 'block';
        }

        // 목록으로 돌아가기
        function goBack() {
            window.history.back();
        }

        // 게시글 수정
        function editPost() {
            var editUrl = '/boards/edit/' + currentBoardId;
            console.log('Redirecting to edit URL:', editUrl);
            window.location.href = editUrl;
        }

        // 게시글 삭제
        function deletePost() {
            if (confirm('정말로 이 게시글을 삭제하시겠습니까?')) {
                var deleteUrl = '/boards/' + currentBoardId;
                console.log('Deleting post with URL:', deleteUrl);
                
                fetch(deleteUrl, {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    credentials: 'same-origin'
                })
                .then(response => {
                    console.log('Delete response status:', response.status);
                    return response.json();
                })
                .then(data => {
                    console.log('Delete response data:', data);
                    if (data.success) {
                        alert('게시글이 삭제되었습니다.');
                        window.location.href = '/boards/list';
                    } else {
                        alert('삭제 중 오류가 발생했습니다: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Delete error:', error);
                    alert('삭제 중 오류가 발생했습니다.');
                });
            }
        }

        // 날짜 포맷팅
        function formatDate(dateString) {
            console.log('Formatting date:', dateString);
            var date = new Date(dateString);
            var formattedDate = date.toLocaleDateString('ko-KR', {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit'
            }).replace(/\./g, '.').replace(/\s/g, '');
            console.log('Formatted date:', formattedDate);
            return formattedDate;
        }
    </script>
</body>
</html>
