 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ include file="common/header.jsp" %>
		<!DOCTYPE html>
		<html lang="ko">

		<head>
			<!-- Meta Tags -->
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

			<title>살래?!</title>

			<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=58380a7fb187c1a835fded7eee3e2c78&libraries=services"></script>
			
			<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
			
			<!-- 외부 CSS -->
			<link rel="stylesheet" href="${contextPath}/resources/css/home.css">
			    <!-- Swiper CSS -->
		    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">

		</head>

		<body>
			<!-- Content -->
			<div class="container">
				<section class="main-banner">
					<h1>살래?</h1>
					<p>찾고, 보고, 사고 내가 찾는 부동산</p>
					<form action="product" method="GET">
						<input type="text" name="search" placeholder="원하시는 지역, 건물을 입력해주세요.">
						<button type="submit">검색</button>
					</form>
				</section>

				<section class="stats">
					<p>현재 <span>${regionCount}</span>개의 지역에서 <span>@@@</span>명이 <span>${productCount } </span>개의 집을 보고
						있습니다.</p>
				</section>

				<div id="map1" style="width: 70%; height: 600px"></div>
				
				  <!-- 추천 상품 캐러셀 -->
        <section class="carousel-section">
            <h2>근처 핫한 매물</h2>
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <!-- 추천 상품 리스트 반복문 -->
                    <c:forEach var="product" items="${recommendedProducts}">
                        <div class="swiper-slide">
                         <a href="/product/detail/${product.product_id}" class="product-link">
                            <img src="https://placehold.co/200x100" alt="${product.product_name}" class="carousel-image">
                            <h3>${product.product_name}</h3>
                            <p>${product.description}</p>
                            <p><strong>${product.payment_type}</strong></p>
                            <p>${product.deposit} 원 / 월</p>
                             </a>
                        </div>
                    </c:forEach>
                  
                </div>
                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-pagination"></div>
            </div>
        </section>
			</div>
 
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
                var url = "/salre/product?search=" + query;  // 검색 URL 구성
                window.location.href = url;  // URL로 이동
            });
        });
 
     // Swiper 초기화
        var swiper = new Swiper('.swiper-container', {
            slidesPerView: 3,        // 한 번에 보여줄 슬라이드 수
            spaceBetween: 10,        // 슬라이드 간의 간격
            loop: true,              // 슬라이드 반복 여부
            autoplay: {
                delay: 3000,         // 3초마다 자동으로 슬라이드 전환
                disableOnInteraction: false, // 사용자 상호작용 시에도 자동 슬라이드 전환 유지
            },
            navigation: {
                nextEl: '.swiper-button-next',  // '다음' 버튼
                prevEl: '.swiper-button-prev',  // '이전' 버튼
            },
            pagination: {
                el: '.swiper-pagination', // 페이지네이션 표시
                clickable: true,           // 페이지네이션 클릭 가능하게
            },
        });


        let swiperInstance; // Swiper 인스턴스를 전역 변수로 선언
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                function (position) {
                    const latitude = position.coords.latitude;
                    const longitude = position.coords.longitude;

                    // Kakao API를 활용해 주소 정보 가져오기
                    const geocoder = new kakao.maps.services.Geocoder();
                    const coord = new kakao.maps.LatLng(latitude, longitude);
                    
                    geocoder.coord2RegionCode(coord.getLng(), coord.getLat(), function (result, status) {
                        if (status === kakao.maps.services.Status.OK) {
                            const region = result.find(r => r.region_type === 'H');
                            const regionName = region.address_name; // ex: 서울특별시 서대문구 연희동

                            if (!regionName.includes('서울')) {
                                alert('서울 지역만 지원합니다.');
                                return;
                            }

                            // '서울특별시' 제거하고 구 단위만 추출
                            const districtName = regionName.replace('서울특별시', '').split(' ')[1]; // ex: 서대문구
  
                            // Ajax로 구 단위 정보 전송
                            sendRegionToServer(districtName);
                        }
                    });
                },
                function () {
                    // 위치 정보 제공 거부 시 기본값으로 종로구 설정
                    alert('위치 정보 제공이 거부로 설정되어 있습니다.');
                    sendRegionToServer('종로구');
                }
            );
        } else {
            alert('브라우저에서 위치 정보 기능을 지원하지 않습니다.');
            sendRegionToServer('종로구');
        }

        function sendRegionToServer(regionName) {
            fetch('/salre/nearby-products', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ region: regionName }),
            })
            .then(response => response.json())
            .then(data => { 
                updateSwiper(data);  // Swiper 업데이트 함수 호출
            })
            .catch(error => console.error('지역 정보 전송 중 오류:', error));
        }
 
function updateSwiper(products) {
    const swiperWrapper = document.querySelector('.swiper-wrapper');
    swiperWrapper.innerHTML = ''; // 기존 슬라이드 초기화

    products.forEach(product => {
   

        // 필드 값이 비어있지 않다면 슬라이드 추가
       
        if (product.product_name && product.description && product.payment_type && product.deposit) {
            const slide = document.createElement('div');
            slide.className = 'swiper-slide';
            slide.innerHTML = `
            	<a href="product/detail/\${product.product_id}" class="product-link">
            	<img src="https://placehold.co/200x100" alt="${product.product_name}" class="carousel-image">
                <h3>\${product.product_name}</h3>
                <p>\${product.description}</p>
                <p><strong>\${product.payment_type}</strong></p>
                <p>\${product.deposit} 원 / 월</p>
                </a>
            `;
          
            swiperWrapper.appendChild(slide);
        } else {
            console.log('Invalid product data:', product);  // 데이터가 이상한 경우 
        }
    });
 

    // Swiper가 이미 초기화되어 있으면 갱신
    if (swiperInstance) {
        swiperInstance.update();  // 이미 초기화된 Swiper 인스턴스에서 슬라이드를 업데이트
    } else {
        // Swiper 초기화가 안 된 경우, 최초 한 번만 초기화
        swiperInstance = new Swiper('.swiper-container', {
            slidesPerView: 3,        // 한 번에 보여줄 슬라이드 수
            spaceBetween: 20,        // 슬라이드 사이 간격
            loop: true,              // 반복 여부
            autoplay: {
                delay: 3000,         // 3초마다 자동으로 슬라이드 전환 (밀리초 단위)
                disableOnInteraction: false, // 사용자 상호작용 시 자동 슬라이드 전환이 멈추지 않게
            },
            navigation: {
                nextEl: '.swiper-button-next',  // '다음' 버튼
                prevEl: '.swiper-button-prev',  // '이전' 버튼
            },
            pagination: {
                el: '.swiper-pagination',
                clickable: true,
            },
        });
    }
}


    </script> 
 
		</body>

		</html>