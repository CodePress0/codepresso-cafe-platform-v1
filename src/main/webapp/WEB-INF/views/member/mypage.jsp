<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .member-info {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .info-row {
            display: flex;
            margin-bottom: 15px;
            align-items: center;
        }
        .info-label {
            font-weight: bold;
            color: #555;
            width: 120px;
            margin-right: 15px;
        }
        .info-value {
            color: #333;
            font-size: 16px;
        }
        .profile-image {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            margin: 0 auto 20px;
            display: block;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin-right: 10px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .actions {
            text-align: center;
            margin-top: 30px;
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid #c3e6cb;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            color: #555;
            margin-bottom: 5px;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0,123,255,0.3);
        }
        .form-row {
            display: flex;
            gap: 20px;
        }
        .form-row .form-group {
            flex: 1;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>마이페이지</h1>

    <!-- 성공 메시지 -->
    <c:if test="${not empty success}">
        <div class="success-message">
            ✅ ${success}
        </div>
    </c:if>

    <!-- 에러 메시지 -->
    <c:if test="${not empty error}">
        <div class="error">
            ❌ ${error}
        </div>
    </c:if>

    <c:choose>
        <c:when test="${not empty member}">
            <!-- 프로필 수정 모드 확인 -->
            <c:choose>
                <c:when test="${param.mode == 'edit'}">
                    <!-- 프로필 수정 폼 -->
                    <div class="member-info">
                        <h3>프로필 수정</h3>
                        <form action="/profile-update" method="post">
                            <input type="hidden" name="memberId" value="${member.memberId}">
                            
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="name">이름</label>
                                    <input type="text" id="name" name="name" value="${member.name}" required>
                                </div>
                                <div class="form-group">
                                    <label for="nickname">닉네임</label>
                                    <input type="text" id="nickname" name="nickname" value="${member.nickname}" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="birthDate">생년월일</label>
                                <input type="date" id="birthDate" name="birthDate" value="${member.birthDate}" required>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="phone">전화번호</label>
                                    <input type="tel" id="phone" name="phone" value="${member.phone}" required>
                                </div>
                                <div class="form-group">
                                    <label for="email">이메일</label>
                                    <input type="email" id="email" name="email" value="${member.email}" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="profileImage">프로필 이미지 URL</label>
                                <input type="url" id="profileImage" name="profileImage" value="${member.profileImage}" placeholder="https://example.com/image.jpg">
                            </div>

                            <div class="actions">
                                <button type="submit" class="btn">프로필 수정</button>
                                <a href="/mypage?memberId=${member.memberId}" class="btn btn-secondary">취소</a>
                            </div>
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- 회원 정보 표시 -->
                    <div class="member-info">
                        <c:if test="${not empty member.profileImage}">
                            <!-- 디버깅: 프로필 이미지 URL 확인 -->
                            <div style="font-size: 12px; color: #666; margin-bottom: 10px;">
                                이미지 URL: ${member.profileImage}
                            </div>
                            <img src="${member.profileImage}" alt="프로필 사진" class="profile-image" 
                                 onerror="console.log('이미지 로딩 실패:', this.src); this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgdmlld0JveD0iMCAwIDEwMCAxMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIxMDAiIGhlaWdodD0iMTAwIiBmaWxsPSIjRjVGNUY1Ii8+CjxjaXJjbGUgY3g9IjUwIiBjeT0iNDAiIHI9IjE1IiBmaWxsPSIjQ0NDQ0NDIi8+CjxwYXRoIGQ9Ik0yMCA4MEMyMCA3MC4zNTg5IDI3LjM1ODkgNjMgMzcgNjNINjNDNzIuNjQxMSA2MyA4MCA3MC4zNTg5IDgwIDgwVjEwMEgyMFY4MFoiIGZpbGw9IiNDQ0NDQ0MiLz4KPC9zdmc+'; this.onerror=null;">
                        </c:if>
                        
                        <div class="info-row">
                            <span class="info-label">회원번호:</span>
                            <span class="info-value">${member.memberId}</span>
                        </div>
                        
                        <div class="info-row">
                            <span class="info-label">아이디:</span>
                            <span class="info-value">${member.accountId}</span>
                        </div>
                        
                        <div class="info-row">
                            <span class="info-label">이름:</span>
                            <span class="info-value">${member.name}</span>
                        </div>
                        
                        <div class="info-row">
                            <span class="info-label">닉네임:</span>
                            <span class="info-value">${member.nickname}</span>
                        </div>
                        
                        <div class="info-row">
                            <span class="info-label">생년월일:</span>
                            <span class="info-value">${member.birthDate}</span>
                        </div>
                        
                        <div class="info-row">
                            <span class="info-label">전화번호:</span>
                            <span class="info-value">${member.phone}</span>
                        </div>
                        
                        <div class="info-row">
                            <span class="info-label">이메일:</span>
                            <span class="info-value">${member.email}</span>
                        </div>
                        
                        <div class="info-row">
                            <span class="info-label">권한:</span>
                            <span class="info-value">${member.role}</span>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <div class="error">
                회원 정보를 찾을 수 없습니다.
            </div>
        </c:otherwise>
    </c:choose>

    <div class="actions">
        <c:choose>
            <c:when test="${param.mode == 'edit'}">
                <!-- 수정 모드에서는 버튼 숨김 -->
            </c:when>
            <c:otherwise>
                <a href="/mypage?memberId=${member.memberId}&mode=edit" class="btn">프로필 수정</a>
                <a href="/" class="btn btn-secondary">홈으로 돌아가기</a>
                <a href="/favorites?memberId=${member.memberId}" class="btn">즐겨찾기목록</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
