<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>살래?</title>
  		 <script type = "text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=58380a7fb187c1a835fded7eee3e2c78">
		  		
  		 </script> 
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            background-color: #fff;
            border-bottom: 1px solid #ddd;
        }
        header .logo {	
            font-size: 24px;
            font-weight: bold;
        }
        header nav a {
            margin: 0 10px;
            text-decoration: none;
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
        .main-banner {
            text-align: center; 
            background: url('resources/images/mainpage_bg.webp') no-repeat center center/cover;
            color: #333;
            padding: 60px 20px;
        }
        .main-banner img {
 		  opacity: 0.5; /* 이미지 투명도 설정 */
		}
        .main-banner h1 {
            font-size: 48px;
            margin-bottom: 10px;
        }
        .main-banner p {
            font-size: 18px;
            margin-bottom: 20px;
        }
        .main-banner input {
            padding: 10px;
            width: 300px;
            margin-right: 10px;
        }
        .main-banner button {
            padding: 10px 20px;
            background-color: #f4a261;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        #map1{
        	margin: 0 auto;
        }
        .stats {
            text-align: center;
            padding: 20px;
            background-color: #f9f9f9;
            font-size: 18px;
        }
 
        footer {
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
 
    </style>
</head>
<body>

    <header>
        <div class="logo">살래?</div>
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

    <section class="main-banner">
        <h1>살래?</h1>
        <p>찾고, 보고, 사고 내가 찾는 부동산</p>
        <form action="search" method="GET">
            <input type="text" name="search" placeholder="원하시는 지역, 건물을 입력해주세요.">
            <button type="submit">검색</button>
        </form>
    </section>

    <section class="stats">
        <p>현재 <span>@@</span>개의 지역에서 <span>@@@</span>명이 <span>@@@@</span>개의 집을 보고 있습니다.</p>
    </section>
 
	    <div id="map1" style="width: 70%; height: 600px"></div>
 	
     <script>
        // 지도를 표시할 div
        var mapContainer = document.getElementById('map1');

        // 지도 옵션
        var mapOption = { 
            center: new kakao.maps.LatLng(37.5642135, 127.0016985), // 서울 중심 좌표
            draggable: false,
            level: 8 // 확대 레벨
        };

        // 지도 생성
        var map = new kakao.maps.Map(mapContainer, mapOption); 
        
        // 마커 이미지 설정
        var imageSrc = 'https://cdn-icons-png.flaticon.com/512/5973/5973800.png',
            imageSize = new kakao.maps.Size(40, 40),
            imageOption = { offset: new kakao.maps.Point(20, 40) };

        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

        // 서울 각 구의 중심 좌표와 이름
        var districts = [
            { name: "종로구", lat: 37.573050, lng: 126.979189 },
            { name: "중구", lat: 37.563759, lng: 126.997671 },
            { name: "용산구", lat: 37.532598, lng: 126.990611 },
            { name: "성동구", lat: 37.563513, lng: 127.036431 },
            { name: "광진구", lat: 37.538378, lng: 127.082218 },
            { name: "동대문구", lat: 37.574368, lng: 127.039617 },
            { name: "중랑구", lat: 37.606324, lng: 127.092253 },
            { name: "성북구", lat: 37.589453, lng: 127.016743 },
            { name: "강북구", lat: 37.639749, lng: 127.025596 },
            { name: "도봉구", lat: 37.668687, lng: 127.047128 },
            { name: "노원구", lat: 37.654360, lng: 127.056516 },
            { name: "은평구", lat: 37.617612, lng: 126.922700 },
            { name: "서대문구", lat: 37.579115, lng: 126.936880 },
            { name: "마포구", lat: 37.563682, lng: 126.908016 },
            { name: "양천구", lat: 37.516770, lng: 126.866577 },
            { name: "강서구", lat: 37.550964, lng: 126.849532 },
            { name: "구로구", lat: 37.495485, lng: 126.887823 },
            { name: "금천구", lat: 37.460096, lng: 126.900202 },
            { name: "영등포구", lat: 37.526414, lng: 126.896430 },
            { name: "동작구", lat: 37.512409, lng: 126.939957 },
            { name: "관악구", lat: 37.478229, lng: 126.951394 },
            { name: "서초구", lat: 37.483545, lng: 127.032368 },
            { name: "강남구", lat: 37.517236, lng: 127.047325 },
            { name: "송파구", lat: 37.514575, lng: 127.105193 },
            { name: "강동구", lat: 37.530125, lng: 127.123770 }
        ];

        // 마커 추가 및 클릭 이벤트 등록
        districts.forEach(function(district) {
            var markerPosition = new kakao.maps.LatLng(district.lat, district.lng);

            var marker = new kakao.maps.Marker({
                position: markerPosition,
                image: markerImage,
                map: map // 지도에 마커 표시
            });

            // 마커 클릭 이벤트
            kakao.maps.event.addListener(marker, 'click', function() {
                var query = encodeURIComponent(district.name);
 
                var basePath = window.location.pathname.split('/')[1];  
                var url = "/" + basePath + "/search?search=" + query;

                window.location.href = url;
            });
        });
    </script>
    <!-- Footer -->
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
</body>
</html>
