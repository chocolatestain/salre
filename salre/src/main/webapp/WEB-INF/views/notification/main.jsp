<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html lang="ko">

	<head>
		<link rel="icon" href="${pageContext.request.contextPath}/resources/favicon.ico" type="image/x-icon" />
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<title>살래?</title>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
				background-color: #f5f5f5;
				text-align: center;
				display: flex;
				padding: 60px 20px;
				width: 100%;
			}

			.main-banner>div {
				width: 100%;
				display: flex;
				flex-direction: column;
				justify-content: center;
				align-items: center;
			}

			.form-box {
				background-color: white;
				padding: 2rem;
				box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
				border-radius: 10px;
				max-width: 400px;
				width: 100%;
				text-align: left;
			}

			.main-banner h1 {
				font-size: 2.5rem;
				color: #333;
			}

			.main-banner h2 {
				font-size: 1.25rem;
				color: #666;
				margin-bottom: 3rem;
			}

			.form-box h3 {
				margin: 0 auto;
				font-size: 1.25rem;
				padding-bottom: 1.5rem;
			}

			input,
			select,
			button {
				width: 100%;
				padding: 0.75rem;
				margin: 1rem 0;
				font-size: 1rem;
				border-radius: 5px;
				border: 1px solid #ccc;
				box-sizing: border-box;
			}

			button {
				background-color: #455f9e;
				color: white;
				cursor: pointer;
				border: none;
			}

			button:hover {
				background-color: #2c3562;
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
				<a href="${pageContext.request.contextPath}/loan/main">대출상품</a> <a href="#">채팅</a> <a href="#">게시판</a>
				<a href="#">매물</a> <a href="#">관심매물</a>
				<a href="#">방내놓기</a>
			</nav>
			<div class="auth">
				<a href="login.jsp">로그인</a> <a href="register.jsp">회원가입</a>
			</div>
		</header>

		<!-- Main Banner -->
		<section class="main-banner">
			<input type="number" name="id" placeholder="아이디 입력" />
			<button id="login">로그인</button>
		</section>

		<!-- Footer -->
		<footer>
			<div>
				<h3>형태 별 검색</h3>
				<p>전세<br />월세<br />아파트<br />빌라<br />상가</p>
			</div>
			<div>
				<h3>고객 지원</h3>
				<a href="#">자주 묻는 질문(FAQ)</a><br />
				<a href="#">Android</a><br />
				<a href="#">iOS</a>
			</div>
			<div>
				<h3>저희 회사는</h3>
				<a href="#">회사소개</a><br />
				<a href="#">오시는 길</a><br />
				<a href="#">제휴문의</a><br />
				<a href="#">채용</a><br />
			</div>
		</footer>

		<script>
			$('#login').click(function () {
				const userId = $("input[name='id']").val();

				const eventSource = new EventSource(`${pageContext.request.contextPath}/notification/subscribe/\${userId}`);

				console.log('연결된 userId:', userId);
				console.log('EventSource URL:', `${pageContext.request.contextPath}/notification/subscribe/\${userId}`);

				eventSource.onmessage = function (event) {
					const message = event.data;
					alert('알림 수신:' + message);
				};

				eventSource.onerror = function (error) {
					alert('SSE 연결 오류');
					eventSource.close();
				};
			});
		</script>
	</body>

	</html>