<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <!-- Meta Tags -->
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
    <title>살래?!</title>
    
    <script type = "text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=58380a7fb187c1a835fded7eee3e2c78"></script>
    
    <!-- 외부 CSS -->
    <link rel="stylesheet" href="${contextPath}/resources/css/home.css">
</head>
<body>
	<!-- Content -->
	<div class="container">
	    <section class="main-banner">
	        <h1>살래?</h1>
	        <p>찾고, 보고, 사고 내가 찾는 부동산</p>
	        <form action="search" method="GET">
	            <input type="text" name="search" placeholder="원하시는 지역, 건물을 입력해주세요.">
	            <button type="submit">검색</button>
	        </form>
	    </section>
	
	    <section class="stats">
	        <p>현재 <span>${regionCount}</span>개의 지역에서 <span>@@@</span>명이 <span>${productCount } </span>개의 집을 보고 있습니다.</p>
	    </section>
	    
	    <div id="map1" style="width: 70%; height: 600px"></div>
    </div>
    
    <%@ include file="common/footer.jsp" %>
    
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

        
        var regions = ${regions};  // 서버에서 전달된 JSON 데이터를 regions 변수에 할당

        regions.forEach(function(region) {
            var markerPosition = new kakao.maps.LatLng(region.latitude, region.longitude);  // 위도와 경도로 위치 설정

            var marker = new kakao.maps.Marker({
                position: markerPosition,
                image: markerImage,  // 마커 이미지 설정 (이미지 객체는 따로 정의되어야 합니다)
                map: map  // 지도에 마커 표시
            });

            // 마커 클릭 이벤트 설정
            kakao.maps.event.addListener(marker, 'click', function() {
                var query = encodeURIComponent(region.province);  // 지역명을 URL 인코딩
                var url = "/salre/search?search=" + query;  // 검색 URL 구성
                window.location.href = url;  // URL로 이동
            });
        });
    </script>
</body>
</html>