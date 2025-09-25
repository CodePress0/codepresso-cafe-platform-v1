<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/head.jspf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<body>
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<main class="hero">
  <div class="container">
    <div class="hero-card" style="grid-template-columns: 1fr;">
      <div>
        <div class="badge">CodePress · 주문 내역</div>
        <h1>내 주문 내역</h1>

        <!-- 필터 옵션 -->
        <div class="filter-section" style="background: var(--white); border-radius: 12px; padding: 16px; margin: 16px 0; box-shadow: var(--shadow);">
          <div style="display: flex; gap: 12px; align-items: center; flex-wrap: wrap;">
            <label style="font-weight: 600;">기간:</label>
            <select id="periodFilter" class="filter-select" style="padding: 8px 12px; border: 1px solid #ddd; border-radius: 8px;">
              <option value="1개월">1개월</option>
              <option value="3개월">3개월</option>
              <option value="전체">전체</option>
            </select>
            <button class="btn btn-ghost" onclick="loadOrders()">조회</button>
          </div>
        </div>

        <!-- 로딩 상태 -->
        <div id="loading" style="text-align: center; padding: 40px; color: var(--text-2);">
          <p>주문 내역을 불러오는 중...</p>
        </div>

        <!-- 에러 메시지 -->
        <div id="error-message" style="display: none; background: #f8d7da; color: #721c24; padding: 12px 16px; border-radius: 8px; margin: 16px 0;">
          <span id="error-text"></span>
        </div>

        <!-- 주문 목록 -->
        <div id="order-list" style="display: none;">
          <!-- 주문 통계 -->
          <div id="order-stats" style="background: var(--pink-4); padding: 12px 16px; border-radius: 12px; text-align: center; margin-bottom: 16px;">
            <strong style="color: var(--pink-1);" id="total-orders">총 0개 주문</strong>
          </div>

          <!-- 주문 카드들이 여기에 동적으로 추가됩니다 -->
          <div id="orders-container" style="display: grid; gap: 16px;">
          </div>
        </div>

        <!-- 빈 상태 -->
        <div id="empty-state" style="display: none; text-align: center; padding: 40px 16px; color: var(--text-2);">
          <h3 style="color: var(--text-2);">📋 주문 내역이 없습니다</h3>
          <p>첫 주문을 시작해보세요!</p>
        </div>

        <!-- 하단 액션 버튼 -->
        <div class="cta" style="justify-content: center; margin-top: 20px;">
          <a href="/branch/list" class="btn btn-primary">주문하러 가기</a>
          <a href="/member/mypage" class="btn btn-ghost">마이페이지로 돌아가기</a>
        </div>
      </div>
    </div>
  </div>
</main>

<script>
// 페이지 로드시 주문 내역 로드
document.addEventListener('DOMContentLoaded', () => {
    loadOrders();
});

// 주문 내역 로드 함수
async function loadOrders() {
    const period = document.getElementById('periodFilter').value;
    
    // 로딩 상태 표시
    document.getElementById('loading').style.display = 'block';
    document.getElementById('order-list').style.display = 'none';
    document.getElementById('empty-state').style.display = 'none';
    document.getElementById('error-message').style.display = 'none';
    
    try {
        const response = await fetch('/users/orders?period=' + encodeURIComponent(period));
        if (response.status === 401) {
            alert('로그인이 필요합니다. 로그인 페이지로 이동합니다.');
            window.location.href = '/auth/login';
            return;
        }
        
        if (!response.ok) {
            throw new Error('주문 내역을 불러올 수 없습니다. (' + response.status + ')');
        }
        
        const data = await response.json();
        
        // 로딩 상태 숨김
        document.getElementById('loading').style.display = 'none';
        
        const totalCount = (typeof data.totalCount === 'number') ? data.totalCount : (data.orders ? data.orders.length : 0);
        const filteredCount = (typeof data.filteredCount === 'number') ? data.filteredCount : (data.orders ? data.orders.length : 0);
        const totalEl = document.getElementById('total-orders');
        if (totalEl) totalEl.textContent = '총 ' + totalCount + '개 주문 (기간 ' + filteredCount + '개)';

        if (data.orders && data.orders.length > 0) {
            displayOrders(data);
        } else {
            showEmptyState();
        }
        
    } catch (error) {
        console.error('주문 내역 로드 오류:', error);
        document.getElementById('loading').style.display = 'none';
        showError(error.message);
    }
}

// 주문 목록 표시
function displayOrders(data) {
    document.getElementById('order-list').style.display = 'block';
    const totalEl = document.getElementById('total-orders');
    const totalCount = (typeof data.totalCount === 'number') ? data.totalCount : (data.orders ? data.orders.length : 0);
    const filteredCount = (typeof data.filteredCount === 'number') ? data.filteredCount : (data.orders ? data.orders.length : 0);
    if (totalEl) totalEl.textContent = '총 ' + totalCount + '개 주문 (기간 ' + filteredCount + '개)';

    const container = document.getElementById('orders-container');
    container.innerHTML = '';

    (data.orders || []).forEach(order => {
        const orderCard = createOrderCard(order);
        container.appendChild(orderCard);
    });
}

// 주문 카드 생성
function createOrderCard(order) {
    const card = document.createElement('div');
    card.className = 'order-card';
    card.style.cssText = 'background: var(--white); border-radius: 16px; box-shadow: var(--shadow); padding: 18px; cursor: pointer; transition: transform 0.2s;';
    
    // 상태에 따른 색상 설정
    const statusColor = getStatusColor(order.productionStatus);
    const takeoutText = order.isTakeout ? '포장' : '매장';
    
    function getSelectedBranchName(){
        try {
            var s = (window.branchSelection && typeof window.branchSelection.load === 'function') ? window.branchSelection.load() : null;
            return (s && s.name) ? s.name : '';
        } catch (e) { return ''; }
    }

    card.innerHTML = ''
        + '<div style="display: flex; justify-content: between; align-items: flex-start; margin-bottom: 12px;">'
        +   '<div style="flex: 1;">'
        +     '<div style="font-size: 12px; color: var(--text-2); margin-bottom: 4px;">주문번호: ' + (order.orderNumber || '') + '</div>'
        +     '<div style="font-weight: 800; font-size: 18px; margin-bottom: 4px;">' + (order.representativeName || '') + '</div>'
        +     '<div id="checkoutStoreName" style="font-size: 14px; color: var(--text-2);">' + (order.branchName || getSelectedBranchName() || '') + ' · ' + takeoutText + '</div>'
        +   '</div>'
        +   '<div style="text-align: right;">'
        +     '<div style="background: ' + statusColor + '; color: white; padding: 4px 8px; border-radius: 8px; font-size: 12px; font-weight: 600; margin-bottom: 4px;">' + (order.productionStatus || '') + '</div>'
        +     '<div style="font-weight: 800; color: var(--pink-1); font-size: 16px;">₩' + Number(order.totalAmount || 0).toLocaleString() + '</div>'
        +   '</div>'
        + '</div>'
        + '<div style="display: flex; justify-content: between; align-items: center; padding-top: 12px; border-top: 1px solid #eee;">'
        +   '<div style="font-size: 12px; color: var(--text-2);">'
        +     '주문일시: ' + (order.orderDate ? formatDateTime(order.orderDate) : '') + '<br>'
        +     (order.pickupTime ? ('픽업시간: ' + formatDateTime(order.pickupTime)) : '')
        +   '</div>'
        +   '<div style="display: flex; gap: 8px;">'
        +     '<button class="btn btn-ghost" onclick="viewOrderDetail(' + order.orderId + ')" style="padding: 6px 12px; font-size: 12px;">상세보기</button>'
        +   '</div>'
        + '</div>';
    
    // 카드 클릭시 상세보기
    card.addEventListener('click', (e) => {
        if (!e.target.closest('button')) {
            viewOrderDetail(order.orderId);
        }
    });
    
    // 호버 효과
    card.addEventListener('mouseenter', () => {
        card.style.transform = 'translateY(-2px)';
    });
    
    card.addEventListener('mouseleave', () => {
        card.style.transform = 'translateY(0)';
    });
    
    return card;
}

// 상태별 색상 반환
function getStatusColor(status) {
    switch(status) {
        case '주문접수': return '#6c757d';
        case '제조중': return '#fd7e14';
        case '제조완료': return '#20c997';
        case '픽업완료': return '#198754';
        default: return '#6c757d';
    }
}

// 날짜 포맷팅
function formatDateTime(dateTimeString) {
    const date = new Date(dateTimeString);
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    const hours = date.getHours().toString().padStart(2, '0');
    const minutes = date.getMinutes().toString().padStart(2, '0');
    return month + '/' + day + ' ' + hours + ':' + minutes;
}

// 주문 상세보기
async function viewOrderDetail(orderId) {
    try {
        // 주문 상세 정보 가져오기
        const response = await fetch('/users/orders/' + orderId);
        if (!response.ok) {
            throw new Error('주문 상세 정보를 불러올 수 없습니다.');
        }
        
        const orderDetail = await response.json();
        
        // 세션 스토리지에 주문 상세 정보 저장
        sessionStorage.setItem('orderDetailData', JSON.stringify(orderDetail));
        
        // 주문 상세 페이지로 이동
        window.location.href = '/orders/' + orderId;
        
    } catch (error) {
        console.error('주문 상세 조회 오류:', error);
        alert('주문 상세 정보를 불러오는 중 오류가 발생했습니다.');
    }
}

// 리뷰 작성
function writeReview(orderId) {
    alert('리뷰 작성 기능은 준비 중입니다.');
}

// 에러 메시지 표시
function showError(message) {
    document.getElementById('error-text').textContent = message;
    document.getElementById('error-message').style.display = 'block';
}

// 빈 상태 표시
function showEmptyState() {
    document.getElementById('empty-state').style.display = 'block';
}
</script>

<script>
  (function(){
    var nameTarget = document.getElementById('checkoutBranchName');
    var storeTitleTarget = document.getElementById('checkoutStoreName');
    var idInput = document.getElementById('selectedBranchIdInput');
    var nameInput = document.getElementById('selectedBranchNameInput');

    function setName(name){
      var display = name && String(name).trim() ? String(name).trim() : '-';
      if (nameTarget) nameTarget.textContent = display;
      if (storeTitleTarget) storeTitleTarget.textContent = display === '-' ? '매장 정보 없음' : display;
      if (nameInput) nameInput.value = name ? String(name).trim() : '';
    }

    function hydrate(){
      var id = idInput && idInput.value ? String(idInput.value).trim() : '';
      var nm = nameInput && nameInput.value ? String(nameInput.value).trim() : '';
      if (nm) { setName(nm); return; }
      if (id) {
        setName('매장 정보를 불러오는 중...');
        fetch('/branch/info/' + encodeURIComponent(id))
                .then(function(r){ if(!r.ok) throw 0; return r.json(); })
                .then(function(d){ setName(d && (d.name || d.branchName) ? (d.name || d.branchName) : ('ID ' + id)); })
                .catch(function(){ setName('매장 정보를 불러오지 못했습니다'); });
        return;
      }
      try {
        var sel = (window.branchSelection && typeof window.branchSelection.load === 'function') ? window.branchSelection.load() : null;
        setName(sel && sel.name ? sel.name : '');
      } catch(e) {
        setName('');
      }
    }

    document.addEventListener('DOMContentLoaded', hydrate);
  })();
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
