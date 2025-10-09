# CodePresso Cafe Platform

카페 온라인 주문 및 관리 플랫폼 시스템

## 프로젝트 소개

CodePresso는 카페 운영을 위한 종합 웹 플랫폼입니다. 
<br>고객은 온라인으로 메뉴를 주문하고, 리뷰를 작성하며, 쿠폰을 활용할 수 있습니다. 
<br>관리자는 상품, 주문, 회원, 지점 등을 효율적으로 관리할 수 있습니다.

## 주요 기능

### 회원 관리
- 회원가입 및 로그인 (Spring Security 기반 인증)
- 이메일 인증 (Naver SMTP)
- 프로필 관리 (프로필 이미지 업로드)
- 아이디/비밀번호 찾기
- 찜 목록 관리

### 상품 관리
- 상품 카테고리별 조회
- 상품 검색 기능
- 상품 상세 정보
- 할인가격 적용

### 장바구니
- 장바구니 추가/수정/삭제
- 장바구니 목록 조회

### 주문 및 결제
- 주문 생성 및 관리
- Toss Payments 결제 연동
- 주문 내역 조회
- 주문 상세 정보

### 리뷰 시스템
- 상품 리뷰 작성/수정/삭제
- 리뷰 조회 및 평점

### 게시판
- 공지사항 및 게시글 작성/수정/삭제
- 게시판 타입별 분류
- 게시글 목록 및 상세 조회

### 쿠폰 시스템
- 쿠폰 발급 및 관리
- 쿠폰 적용

### 지점 관리
- 지점 정보 조회
- 지점 목록

## 기술 스택

### Backend
- **Java 21**
- **Spring Boot 3.5.5**
  - Spring MVC
  - Spring Data JPA
  - Spring Security
  - Spring Boot DevTools
  - Spring Boot Docker Compose
- **Hibernate** (JPA 구현체)
- **Lombok** (보일러플레이트 코드 제거)
- **Bean Validation** (입력 검증)

### Database
- **MySQL 8.4** (Docker Container)
- **JPA/Hibernate** (ORM)

### View
- **JSP (Jakarta Server Pages)**
- **JSTL 3.0** (Jakarta Standard Tag Library)

### Build Tool
- **Gradle 8.x**

### DevOps
- **Docker Compose** (MySQL 컨테이너)

### External Services
- **Toss Payments API** (결제 시스템)
- **Naver SMTP** (이메일 발송)

### API Documentation
- **Swagger UI / OpenAPI 3** (SpringDoc)

### Testing
- **JUnit 5**
- **Spring Boot Test**
- **H2 Database** (테스트용 인메모리 DB)

## 프로젝트 구조

```
codepresso/
├── src/
│   ├── main/
│   │   ├── java/com/codepresso/codepresso/
│   │   │   ├── config/              # 설정 클래스 (Security, Swagger 등)
│   │   │   ├── controller/          # 컨트롤러 레이어
│   │   │   │   ├── auth/            # 인증 관련
│   │   │   │   ├── board/           # 게시판
│   │   │   │   ├── branch/          # 지점
│   │   │   │   ├── cart/            # 장바구니
│   │   │   │   ├── coupon/          # 쿠폰
│   │   │   │   ├── member/          # 회원
│   │   │   │   ├── order/           # 주문
│   │   │   │   ├── payment/         # 결제
│   │   │   │   ├── product/         # 상품
│   │   │   │   └── review/          # 리뷰
│   │   │   ├── service/             # 서비스 레이어 (비즈니스 로직)
│   │   │   ├── repository/          # 레포지토리 레이어 (데이터 접근)
│   │   │   ├── entity/              # JPA 엔티티
│   │   │   ├── dto/                 # 데이터 전송 객체
│   │   │   ├── converter/           # Entity ↔ DTO 변환
│   │   │   ├── security/            # Spring Security 설정
│   │   │   ├── exception/           # 예외 처리
│   │   │   └── CodepressoApplication.java
│   │   ├── resources/
│   │   │   ├── application.yml      # 애플리케이션 설정
│   │   │   └── static/              # 정적 리소스 (CSS, JS, 이미지)
│   │   └── webapp/
│   │       └── WEB-INF/
│   │           └── views/           # JSP 뷰 파일
│   └── test/                        # 테스트 코드
├── build.gradle                     # Gradle 빌드 설정
├── docker-compose.yml               # Docker Compose 설정 (MySQL)
└── README.md
```

### 아키텍처

프로젝트는 **레이어드 아키텍처 (Layered Architecture)** 패턴을 따릅니다:

1. **Controller Layer**: HTTP 요청/응답 처리
2. **Service Layer**: 비즈니스 로직 처리
3. **Repository Layer**: 데이터베이스 접근
4. **Entity Layer**: 도메인 모델 (JPA 엔티티)
5. **DTO Layer**: 계층 간 데이터 전송
6. **Converter Layer**: Entity와 DTO 간 변환

## 설치 및 실행

### 사전 요구사항

- **Java 21** 이상
- **Docker** 및 **Docker Compose**
- **Gradle** (또는 프로젝트에 포함된 Gradle Wrapper 사용)

### 1. 프로젝트 클론

```bash
git clone https://github.com/CodePress0/codepresso-cafe-platform-v1.git
cd codepresso
```

### 2. MySQL 데이터베이스 실행 (Docker Compose)

```bash
docker-compose up -d
```

Docker Compose가 자동으로 MySQL 8.4 컨테이너를 생성하고 실행합니다:
- **포트**: `33306` (호스트) → `3306` (컨테이너)
- **데이터베이스**: `codepresso`
- **사용자**: `codepresso` / `codepresso123`
- **루트 비밀번호**: `root`

### 3. 애플리케이션 실행

#### Gradle Wrapper 사용 (권장)

**macOS/Linux:**
```bash
./gradlew bootRun
```

**Windows:**
```bash
gradlew.bat bootRun
```

#### 또는 Gradle 직접 사용

```bash
gradle bootRun
```

### 4. 애플리케이션 접속

애플리케이션이 시작되면 브라우저에서 다음 주소로 접속:

- **메인 페이지**: http://localhost:8080
- **Swagger UI**: http://localhost:8080/swagger-ui.html

## 환경 설정

### application.yml 주요 설정

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:33306/codepresso
    username: codepresso
    password: codepresso123

  jpa:
    hibernate:
      ddl-auto: update    # 스키마 자동 업데이트
    show-sql: true        # SQL 로그 출력

server:
  port: 8080

toss:
  payments:
    client-key: test_ck_Z61JOxRQVEEOn7KM2POwVW0X9bAq
    secret-key: test_sk_oEjb0gm23PWRyYvE0kbo8pGwBJn5
```

> **주의**: 프로덕션 환경에서는 `application-prod.yml`을 별도로 생성하고 환경 변수로 민감한 정보를 관리하세요.

## API 문서

Swagger UI를 통해 API 문서를 확인할 수 있습니다:

**접속 URL**: http://localhost:8080/swagger-ui.html

Swagger UI에서 모든 REST API 엔드포인트를 확인하고 테스트할 수 있습니다.

## 테스트 실행

```bash
./gradlew test
```

테스트는 H2 인메모리 데이터베이스를 사용하여 실행됩니다.

## Git 브랜치 전략

프로젝트는 **Git Flow** 전략을 따릅니다:

- `main`: 프로덕션 배포 브랜치
- `develop`: 개발 통합 브랜치
- `feature/*`: 새로운 기능 개발 브랜치
- `hotfix/*`: 긴급 버그 수정 브랜치
- `fix/*`: 일반 버그 수정 브랜치