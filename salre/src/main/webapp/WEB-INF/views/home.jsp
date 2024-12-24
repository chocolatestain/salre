<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/favicon.ico"
	type="image/x-icon">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>살래?</title>
<!--     <link rel="stylesheet" href="styles/main.css"> 외부 CSS 연결 -->
<script type="text/javascript"
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=58380a7fb187c1a835fded7eee3e2c78">
	
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
	background: url('resources/images/mainpage_bg.webp') no-repeat center
		center/cover;
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
	<!-- Header -->
	<header>
		<div class="logo">살래?</div>
		<nav>
			<a href="notification/">대출상품</a> <a href="#">채팅</a> <a href="#">게시판</a> <a
				href="#">매물</a> <a href="#">관심매물</a> <a href="#">방내놓기</a>
		</nav>
		<div class="auth">
			<a href="login.jsp">로그인</a> <a href="register.jsp">회원가입</a>
		</div>
	</header>

	<!-- Main Banner -->
	<section class="main-banner">
		<h1>살래?</h1>
		<p>찾고, 보고, 사고 내가 찾는 부동산</p>
		<form action="search" method="GET">
			<input type="text" name="" placeholder="원하시는 지역, 건물을 입력해주세요.">
			<button type="submit">검색</button>
		</form>
	</section>

	<!-- Stats Section -->
	<section class="stats">
		<p>
			현재 <span>@@</span>개의 지역에서 <span>@@@</span>명이 <span>@@@@</span>개의 집을
			보고 있습니다.
		</p>
	</section>

	<div id="map1" style="width: 500px; height: 400px">!!!!!!!!!!</div>

	<script>
		var mapContainer = document.getElementById('map1'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption);
	</script>
	<!-- Footer -->
	<footer>
		<div>
			<h3>형태 별 검색</h3>
			<p>
				전세<br>월세<br>아파트<br>빌라<br>상가
			</p>
		</div>
		<div>
			<h3>고객 지원</h3>
			<a href="#">자주 묻는 질문(FAQ)</a><br> <a href="#">Android</a><br>
			<a href="#">iOS</a>
		</div>
		<div>
			<h3>저희 회사는</h3>
			<a href="#">회사소개</a><br> <a href="#">오시는 길</a><br> <a
				href="#">제휴문의</a><br> <a href="#">채용</a><br>
		</div>
	</footer>
</body>
</html>
