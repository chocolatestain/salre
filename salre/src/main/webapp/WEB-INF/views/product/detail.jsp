<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>살래?</title>
  <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=58380a7fb187c1a835fded7eee3e2c78"></script>
  <style>
    /* 기본 설정 */
    body, html {
      margin: 0;
      padding: 0;
      height: 100%;
      font-family: "Inter", Helvetica, sans-serif;
      display: flex;
      flex-direction: column;
      align-items: center; /* 좌우 가운데 정렬 */
      justify-content: flex-start; /* 상단 정렬 */
      background-color: #f9f9f9;
    }
    .product-address{
      font-size: 1.5rem;
      font-weight: bold;
      color: #555;
      margin-top: 20px;
    }
    /* 헤더 스타일 */
    header {
      position: fixed; /* 항상 맨 위에 고정 */
      top: 0;
      left: 0;
      width: 100%;
      background-color: #fff;
      border-bottom: 1px solid #ddd;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 20px;
      box-sizing: border-box;
      z-index: 10;
    }

    header .logo {
      font-size: clamp(1.5rem, 2.5vw, 3rem);
      font-weight: bold;
    }

    header nav a {
      font-size: clamp(1rem, 1.5vw, 1.5rem);
      margin: 0 10px;
      text-decoration: none;
      font-weight: bold;
      color: #333;
    }

    header .auth a {
      margin-left: 15px;
      padding: 10px 20px;
      background-color: #f4a261;
      color: #fff;
      border-radius: 5px;
      text-decoration: none;
    }
    footer {
            width:100%;
            display: flex;
            justify-content: space-around;
            background-color: #222;
            color: #fff;
            padding: 20px 0;
        }
        footer div {
            text-align: left;
        }
        footer a {
            color: #f4a261;
            text-decoration: none;
    }
    /* 콘텐츠 영역 */
    .screen {
      margin-top: 80px; /* 고정된 header 높이만큼 여백 추가 */
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 20px;
      width: 100%;
      max-width: 1200px;
      padding: 20px;
      box-sizing: border-box;
    }

    /* 왼쪽, 오른쪽 패널 스타일 */
    .left, .right { 
      padding: 20px; 
    }

    /* 이미지 및 텍스트 스타일 */
    .main-image {
      max-width: 100%;
      height: auto;
      border-radius: 10px;
    }

    .product-directory {
      font-size: 1rem;
      color: #555;
      margin-bottom: 20px;
    }

    .seller-profile {
      display: flex;
      align-items: center;
      margin-top: 20px;
      gap: 10px;
    }

    .generic-avatar {
      width: 75px;
      height: 75px;
      border-radius: 50%;
      border: 2px solid #ddd;
      margin-right : 5px;
    }
    .review-avatar {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      border: 2px solid #ddd;
    }
    .seller-name {
      font-size: 2rem;
      font-weight : b;
      color: #333;
    }

    .product-info {
      margin-top: 20px;
      display: flex;
      flex-direction: column;
      gap: 15px;
    }
    .product-status {
      font-weight: bold;
      color: #f4a261;
    }

    .product-price {
      font-size: 1.5rem;
      color: #333;
      font-weight: bold;
    }

    .info-category {
      font-size: 1.5rem;
      color: #333;
      font-weight: bold;
      margin-bottom: 5px;
    }

    .info-content {
      font-size: 1rem;
      color: #555;
      line-height: 1.5;
    }

    .product-descript-name {
      font-weight: bold;
      font-size: 2rem;
      color: #333;
    }
    .recent-review {
      font-weight: bold;
      font-size: 2rem;
      color: #333;
      margin-top: 10px;
    }
    .review-seller-name{
      font-size: 1rem;
      color: #333;
      margin-bottom: 50px;
    }
    .review-seller-region{
      font-size: 1rem;
      color: #555;
    }
  .review-content{ 
    font-size: 1rem;
    color: #555;

 
  }
  .product-descript {
    font-size: 1rem;
    color: #555;
    line-height: 1.5;
  }

  .division-line {
    margin-top: 20px;
  }

  .review-container{
    margin-top : 40px;
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  .review{ 
    display: flex;
    gap: 10px; 
    align-items: flex-start;  
    border : 1px solid #ddd;
    padding: 10px;
    border-radius: 10px;

  } 
  .review-content{
    display: flex;
    gap: 10px;
    flex-direction: column;    
  } 
  .review-content p {
  display: -webkit-box; /* Webkit 기반 브라우저에서 box처럼 동작하도록 설정 */
  -webkit-box-orient: vertical; /* 세로 방향으로 정렬 */
  -webkit-line-clamp: 3; /* Webkit 브라우저에서 최대 3줄까지 표시 */
  overflow: hidden; /* 넘치는 텍스트 숨기기 */
  text-overflow: ellipsis; /* 넘친 텍스트에 ... 추가 */
  
  display: box; /* 구버전 Firefox 및 Opera 지원 */
  box-orient: vertical; /* 구버전 Firefox 및 Opera 지원 */
  line-clamp: 3; /* 표준 CSS 속성, 일부 최신 브라우저 지원 */
  
  font-size: 1rem;
  color: #555; 

  margin: 0;
  padding: 0;
}
 
.seller-name {
  margin: 0;
  padding: 0;
}

#addressCopyButton{
  padding: 12px 11px;
  background-color: #f4a261;
  color: #fff;
  border: none;
  cursor: pointer;
  border-radius: 5px;
}
  .product-address{
    font-size: 1.5rem;
    font-weight: bold;
    color: #555;
    margin-top: 20px;
}
  .reviewer{
    display: flex;
    gap: 10px;
    align-items: flex-start;
  }
    /* 반응형 처리 */
    @media (max-width: 768px) {
      header nav a {
        font-size: 1rem;
        margin: 5px;
      }

      .screen {
        grid-template-columns: 1fr;
        padding: 10px;
      }

      .left, .right {
        padding: 15px;
      }
      .division-line {
        margin-top: 20px;
      }
    }
    
  </style>

</head>
<body>
  <header>
    <div class="logo" onclick="location.href='/salre'" style="cursor: pointer;">살래?</div>

    <nav>
      <a href="#">대출상품</a>
      <a href="#">채팅</a>
      <a href="#">게시판</a>
      <a href="#">매물</a>
      <a href="#">관심매물</a>
      <a href="#">방내놓기</a>
    </nav>
    <div class="auth">
      <a href="login.jsp">로그인</a>
      <a href="register.jsp">회원가입</a>
    </div>
  </header>

  <div class="screen">
    <div class="left">
      <p class="product-directory">홈 &gt; 매물검색 &gt; 서울시 종로구 &gt; 빌라</p>
      <img class="main-image" src="https://placehold.co/600x600" alt="Main Image" />
      <div class="seller-profile">
        <img class="generic-avatar" src="https://placehold.co/75x75" alt="Avatar" />
        <p class="seller-name">
          <span class="seller-nickname">xyl4h4jrhe<br /></span>
          <span class="seller-region">종로구</span>
        </p>
      </div>

      <div class="division-line">
        <hr />
      </div>
      <div class="recent-review">최근 리뷰
          <div class = "review-container">
            <div class = "review">
              <div class = "reviewer">
                <img class="review-avatar" src="https://placehold.co/75x75" alt="Avatar" />
                <p class="seller-name">
                  <span class="review-seller-name">xyl4h4jrhe<br /></span> 
                  <span class="review-seller-region">종로구</span>                                  
                </p>
              </div>
              <div class = "review-content">
                <p>집주인이 너무 못생겼어요집주인이 너무 못생겼어요집주인이 너무 못생겼어요집주인이 너무 못생겼어요집주인이 너무 못생겼어요집주인이 너무 못생겼어요집주인이 너무 못생겼어요집주인이 너무 못생겼어요집주인이 너무 못생겼어요집주인이 너무 못생겼어요집주인이 너무 못생겼어요</p>
              </div>
            </div>
            <div class = "review">
              <div class = "reviewer">
                <img class="review-avatar" src="https://placehold.co/75x75" alt="Avatar" />
                <p class="seller-name">
                  <span class="review-seller-name">xyl4h4jrhe<br /></span>
                  <span class="review-seller-region">종로구</span>
                </p>
              </div>
              <div class = "review-content">
                <p>집이 고장났는데 고쳐주질 않아요요집이 고장났는요집이 고장났는데 고쳐주질 쳐주쳐주쳐주쳐요집이 고요집이 고장났는데 고쳐주질 쳐주쳐주쳐주쳐요집이 고장났는데 고쳐주질 쳐주쳐주쳐주쳐요집이 고장났는데 고쳐주질 쳐주쳐주쳐주쳐장났는데 고쳐주질 쳐주쳐주쳐주쳐요집이 고장났는데 고쳐주질 쳐주쳐주쳐주쳐요집이 고장났는데 고쳐주질 쳐주쳐주쳐주쳐요집이 고장났는데 고쳐주질 쳐주쳐주쳐주쳐데 고쳐주질 쳐주쳐주쳐주쳐주쳐주쳐주쳐주쳐주쳐주쳐주쳐주쳐주쳐주쳐주쳐주쳐주쳐주쳐주쳐주쳐주쳐주쳐주않아요요집이 고장났는데 고쳐주질 않아요요집이 고장났는데 고쳐주질 않아요요집이 고장났는데 고쳐주질 않아요요</p>
              </div>
            </div> 
            </div>
          </div>
        </div>
        <div class="right">
     
          <div class="product-info">
            <div class="info-row">
              <div class="info-category">면적</div>
              <div class="info-content">7평 · 전용 23.1㎡</div>
            </div>
            <div class="info-row">
              <div class="info-category">방/욕실 수</div>
              <div class="info-content">방 1개 / 욕실 1개</div>
            </div>
            <div class="info-row">
              <div class="info-category">층</div>
              <div class="info-content">1층 / 2층</div>
            </div>
            <div class="info-row">
              <div class="info-category">대출가능여부</div>
              <div class="info-content">확인필요</div>
            </div>
            <div class="info-row">
              <div class="info-category">입주 가능일</div>
              <div class="info-content">즉시 가능</div>
            </div>
            <div class="info-row">
              <div class="info-category">반려동물</div>
              <div class="info-content">불가능</div>
            </div>
            <div class="info-row">
              <div class="info-category">주차</div>
              <div class="info-content">불가능</div>
            </div>
            <div class="info-row">
              <div class="info-category">내부 시설</div>
              <div class="info-content">에어컨, 침대, 옥탑, 세탁기</div>
             </div>
            </div>  
            <div style="display: flex; justify-content: space-between; align-items: center;">
              <p class="product-descript-name" style="margin-top : 30px;">상세 내용</p>
              <a href="report_page.html" id="report" style="text-decoration: none; color: #f4a261; cursor: pointer;">신고하기</a>
            </div>
            <p class="product-descript">
              대문이 하나 더 있어 여자 혼자 살기 좋은 원룸입니다. 원하시면 1년도 안 쓴 2층 침대와 소파도 드립니다. 냉장고는 8만원에 판매 예정입니다.
            </p>
            
          	<div id="map" style="width:550px;height:200px;"></div>
            <script>
            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                mapOption = { 
                    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                    level: 3, // 지도의 확대 레벨
                    draggable: false

                };

            // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
            var map = new kakao.maps.Map(mapContainer, mapOption); 
 
            var markerPosition  = new kakao.maps.LatLng(33.450701, 126.570667);

              var marker = new kakao.maps.Marker({
                  position: markerPosition
              });

              marker.setMap(map)
            </script>
<div class="product-address" id="address">
  서울특별시 종로구 옥인길 59-11 경복궁역
</div>
<div id="copyNotification" style="display: none; color: green; font-size: 1rem; margin-top: 10px;">주소가 복사되었습니다!</div>

<script>
  document.getElementById("address").addEventListener("click", function() {
    var copyText = document.getElementById("address");
    var notification = document.getElementById("copyNotification");

    // 텍스트 색상 변경 (선택사항)
    copyText.style.color = "#f4a261"; // 복사된 후 텍스트 색 변경

    navigator.clipboard.writeText(copyText.innerText)
      .then(function() {
        // 복사 성공 후 알림 메시지 표시
        notification.style.display = "block";
        setTimeout(function() {
          notification.style.display = "none";
        }, 2000); // 2초 후 알림 숨기기
      })
      .catch(function(err) {
        alert("복사 실패: " + err);
      });
  });
</script>

            </div>
          </div>
       </div>
      </div>  
    </div>
  </div>
</body>

<footer>
  <div>
      <h3>형태 별 검색</h3>
      <p>전세<br>월세<br>아파트<br>빌라<br>상가</p>
  </div>
  <div>
      <h3>고객 지원</h3>
      <a href="#">자주 묻는 질문(FAQ)</a><br>
      <a href="#">Android</a><br>
      <a href="#">iOS</a>
  </div>
  <div>
      <h3>저희 회사는</h3>
      <a href="#">회사소개</a><br>
      <a href="#">오시는 길</a><br>
      <a href="#">제휴문의</a><br>
      <a href="#">채용</a><br>
  </div>
</footer>
</html>
