<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
 	<%@ include file="../common/header.jsp" %>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>살래?</title>
  <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=58380a7fb187c1a835fded7eee3e2c78&libraries=services"></script>

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
header, footer {
  display: block; /* 기본 블록 요소로 설정하여 flexbox 영향을 받지 않게 함 */
}
.product-address {
  font-size: 1.5rem;
  font-weight: bold;
  color: #555;
  margin-top: 20px;
}
header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 40px;
  background: linear-gradient(90deg, #333, #4a4a5a); /* 어두운 색 기반 그라디언트 */
  color: #fff;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 박스 쉐도우 */
  position: sticky;
  top: 0;
  z-index: 1000;
}

  
/* 푸터 스타일 */
footer {
    display: flex;
    justify-content: center; /* 푸터 섹션들을 수평 가운데 정렬 */
    align-items: flex-start; /* 섹션들을 상단에 정렬 */
    flex-wrap: wrap; /* 화면 크기 줄어들 때 줄바꿈 허용 */
    background: linear-gradient(90deg, #333, #4a4a5a); /* 어두운 블루 그라데이션 */
    color: #fff;
    padding: 20px 0;
    flex-direction : row;
    box-shadow: 0 -4px 8px rgba(0, 0, 0, 0.2); /* 박스 쉐도우 추가 */
    text-align: center; /* 전체적인 텍스트를 가운데 정렬 */
}


 

/* 콘텐츠 영역 */
.screen {
  margin-top: 200px; /* 고정된 header 높이만큼 여백 추가 */
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
.right{
	gap : 20px;
}
/* 이미지 및 텍스트 스타일 */
.main-image {
  max-width: 100%;
  height: auto;
  border-radius: 10px;
  object-fit: cover; /* 크기가 더 클 때 잘리고, 작으면 늘어남 */
  
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
  justify-content: space-between;
}

.generic-avatar, .review-avatar {
  border-radius: 50%;
  border: 2px solid #ddd;
}

.generic-avatar {
  width: 75px;
  height: 75px;
}

.review-avatar {
  width: 50px;
  height: 50px;
}

.seller-name {
  font-size: 2rem;
  color: #333;
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: space-between;
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

.product-price, .info-category {
  font-size: 1.5rem;
  color: #333;
  font-weight: bold;
}

.info-content, .product-descript, .review-content {
  font-size: 1rem;
  color: #555;
  line-height: 1.5;
}

.product-descript-name, .recent-review {
  font-weight: bold;
  font-size: 2rem;
  color: #333;
}

.review-seller-name, .review-seller-region {
  font-size: 1rem;
  color: #333;
}

.division-line {
  margin-top: 20px;
}

/* 리뷰 영역 */
.review-container {
  margin-top: 40px;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.review {
  display: flex;
  gap: 10px;
  align-items: flex-start;
  border: 1px solid #ddd;
  padding: 10px;
  border-radius: 10px;
}

.review-content p {
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 3;
  overflow: hidden;
  text-overflow: ellipsis;
  margin: 0;
}

#addressCopyButton {
  padding: 12px 11px;
  background-color: #f4a261;
  color: #fff;
  border: none;
  cursor: pointer;
  border-radius: 5px;
}

.reviewer {
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
    margin-top: 300px;
  }

  .left, .right {
    padding: 15px;
  }
}

/* 기타 스타일 */
#price-row {
  display: flex;
  gap: 10px;
  align-items: center;
}

.chat-button {
  display: block;
  padding: 10px 20px;
  font-size: 16px;
  color: white;
  background-color: #f4a261;
  border: none;
  border-radius: 5px;
  text-decoration: none;
  text-align: center;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.chat-button:hover {
  background-color: #80543E;
}

.status-before {
  color: green !important;
}

.status-in-progress {
  color: orange !important;
}

.status-completed {
  color: gray !important;
}

.status-unknown {
  color: red !important;
}

  </style>

</head>
<body>


  <div class="screen">
    <div class="left"> 
    <div>
      <img class="main-image" 
     src="../../resources/images/products/${product.product_id}.jpeg" 
     onerror="this.onerror=null; this.src='https://placehold.co/600x600'" 
     alt="Main Image" />
     </div>
      <div class="seller-profile">
        <img class="generic-avatar" src="https://placehold.co/75x75" alt="Avatar" />
        <p class="seller-name">
          <span class="seller-nickname">${user_nickname}</span> 
                  </p>
          	<form action="${contextPath}/chat/createChatRoom.do" method="post">
		<input type="hidden" name="product_id" value="${product.product_id}">
		<input type="hidden" name="product_user_id" value="${product.user_id}">
		<input type="hidden" name="product_name" value="${product.product_name}"> 
		 <button type="submit" id = "chatButton" class="chat-button">채팅하기</button>
		</form>	  
      </div>
		<input type="hidden" id="product_status" value="${product.product_status}">

		<script>
		    // product_status 값 가져오기
		    const productStatus = document.getElementById("product_status").value;
		
		    // product_status가 2면 버튼 숨기기
		    if (productStatus === "2") {
		        document.getElementById("chatButton").style.display = "none";
		    }
		</script>

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
                      <div style="display: flex; justify-content: space-between; align-items: center;">
              <p class="product-descript-name" style="margin-top : 30px;">상세 내용</p>
           	<div>
              <a href="report_page.html" id="report" style="text-decoration: none; color: #f4a261; cursor: pointer;">신고하기</a>
              <div class = "readCount">조회수 ${product.view_count } 회</div>
              </div>
            </div> 
            	<div id = "status" style="display: flex;  align-items : center;">
				<div class="info-row" id="price-row" style = "margin-right : 20px;">
				    <div class="${status}">
				        <h2>${label}</h2> 
				    </div>
				</div> 
			    <div class="payment-type" style="display:inline; margin-right : 20px;">
			        <h2>${product.payment_type}</h2>
			    </div>
			    <div class="deposit" id = "product_deposit">
			        <h2>${product.deposit} </h2>
			    </div>
			    <div class="rentfee"> 
			         <c:choose>
				        <c:when test="${product.payment_type == '월세'}">
				            <h2> / ${product.rentfee}</h2>
				        </c:when>
				        <c:otherwise>
 
				        </c:otherwise>
				    </c:choose>
				    </div>
	   		    </div>
			</div>


            <div class="info-row">
              <div class="info-category">주소</div>
              <div class="info-content">${product.address} ${product.floor } 층 ${product.address_detail }</div>
            </div> 
            
            <div class="info-row">
              <div class="info-category">면적</div>
              <div class="info-content">${product.area } 평</div>
            </div>
            <div class="info-row">
              <div class="info-category">방/욕실 수</div>
              <div class="info-content">방 ${product.room_count } 개 / 욕실 ${product.bath_count }</div>
            </div> 
            <div class="info-row">
              <div class="info-category">전세/월세</div>
              <div class="info-content">${product.payment_type }</div>
            </div>  
            <div class="info-row">
              <div class="info-category">방향</div>
              <div class="info-content">${product.direction} </div>
            </div> 
             <p class="product-descript">
              ${product.description }
            </p>  
			<div id="map" style="width:550px;height:200px;"></div>
   
           
   <script>  
    let map; // 전역 변수로 지도 객체 생성
    const query = "${product.address }"
 

    window.onload = function () {
 
        if (query) {
            console.log("query : " + query);
            searchAddress();
        } else {
            console.log('query가 없음');
        }
  
	        const depositElement = document.getElementById('product_deposit');
	        const depositValue = parseInt(depositElement.innerText, 10); 
	        
	        depositElement.innerHTML = '<h2>' + formatNumber(depositValue) + '</h2>';
 
    };

    
    // Kakao 지도 초기화 함수
    function initMap(x, y) {
        const mapContainer = document.getElementById('map'); // 지도를 표시할 div
        const mapOption = {
            center: new kakao.maps.LatLng(y, x), // 동적으로 받은 x, y 값 사용
            level: 3, // 확대 레벨
            draggable: false 
        };

        // 지도 생성
        map = new kakao.maps.Map(mapContainer, mapOption);

        // 마커 생성
        const marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(y, x)
        });

        // 지도 중심 설정
        map.setCenter(new kakao.maps.LatLng(y, x));
    }

    async function searchAddress() { 
    	
        const encodedQuery = encodeURIComponent(query); 
        const apiUrl = `https://dapi.kakao.com/v2/local/search/address.json?query=\${encodedQuery}`;
        console.log("API 요청 URL: " + apiUrl); // 여기서 로그 출력

        try {
            const response = await fetch(apiUrl, {
                method: "GET",
                headers: {
                    "Authorization": "KakaoAK 0a921d8f6de257f50d4e45968e437ec5"
                }
            });

            if (!response.ok) {
            	console.log("API 호출 실패: " + response.status);
                throw new Error("API 호출 실패: " + response.status);
            }

            const data = await response.json();

            if (data.documents.length === 0) {
                console.log("검색 결과가 없습니다.");
                return;
            }

            const result = data.documents[0];
            const address = result.address.address_name;
            const x = result.x;
            const y = result.y;

            initMap(x, y); 
            
        } catch (error) {
            console.error("Error:", error);
            alert("API 호출 중 오류가 발생했습니다.");
        }
    }
		</script>

		<div class="product-address" id="address">
		 	${product.address } ${product.address_detail}
		</div>
		<div id="copyNotification" style="display: none; color: green; font-size: 1rem; margin-top: 10px;">주소가 복사되었습니다!</div>

 	   <script>
		  document.getElementById("address").addEventListener("click", function() {
		    var copyText = document.getElementById("address");
		    var notification = document.getElementById("copyNotification");

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
    </div>  <!--  script end   -->
	         	</div>         
 
	
	 <script> 

	 function formatNumber(num) {
		    const units = ["백만", "천만", "억"]; // 각 단위 정의
		    let result = ''; // 결과 문자열
		    let unitIndex = 0; // 단위 인덱스
			console.log(num);
		    // 1억 단위로 나누면서 단위 붙임
		    while (num > 0) {
		        const remainder = num % 10000; // 10,000으로 나눈 나머지
		        if (remainder > 0) {
		            let part = remainder.toString(); // 나머지를 문자열로 변환
		            if (unitIndex > 0) {
		                part = part.replace(/0+$/, ''); // 뒤에 있는 0 제거
		            }
		            result = part + (units[unitIndex] ? units[unitIndex] : '') + result; // 결과에 추가
		        }
		        num = Math.floor(num / 10000); // 10,000으로 나눈 몫을 다시 num에 저장
		        unitIndex++; // 단위 인덱스 증가
		    }

		    // "백", "천" 단위가 중간에 있을 경우 제거
		    result = result.replace(/(천|백)(?=\d)/g, ''); // 백, 천이 중간에 있을 경우 제거

		    // "만" 단위도 절삭
		    if (result.includes("백만") && !result.includes("천")) {
		        result = result.replace(/만$/, ''); // 만 단위가 필요 없으면 제거
		    }
			console.log(result);
		    return result || '0'; // 결과 반환, 0이면 '0' 반환
		}

	</script> 
		<%@ include file="../common/footer.jsp" %>
</body> 
</html>