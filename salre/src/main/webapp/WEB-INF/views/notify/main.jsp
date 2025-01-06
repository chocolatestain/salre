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
				flex-direction: column;
				align-items: center;
			}

			.main-banner>div {
				width: 50%;
				display: flex;
				flex-direction: column;
				justify-content: center;
				align-items: center;
				max-width: 400px;
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

			table {
				width: 100%;
				margin-top: 20px;
				border-collapse: collapse;
			}

			th {
				border: 1px solid #ddd;
				padding: 8px;
			}

			td {
				border: 1px solid #ddd;
				padding: 8px;
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
			<h1>알림 테스트 페이지</h1>
			<div id="login-form">
				<input type="number" name="id" placeholder="아이디 입력" />
				<button id="login">로그인</button>
			</div>

			<div id="target-form">
				<input type="number" name="target" placeholder="대상 입력" />
				<button id="send">알림 보내기</button>
			</div>

			<div id="notify-form">
				<input type="number" name="target2" placeholder="대상 입력" />
				<button id="list">알림 조회</button>
				<div id="notify-list"></div>
			</div>
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
				const user_id = $("input[name='id']").val();

				// 서버와 SSE 연결
				const eventSource = new EventSource(`${pageContext.request.contextPath}/notify/subscribe/\${user_id}`);

				eventSource.addEventListener('INIT', function (event) {
					$('#login-form').append(`<p>\${user_id}번 로그인 성공</p>`);
				});

				eventSource.addEventListener('NOTIFY', function (event) {
					$('#target-form').append(`<p>알림 전송 성공</p>`);
				});

				eventSource.onerror = function () {
					console.error('SSE 연결 오류');
				};
			});

			// 알림 보내기
			$('#send').click(function () {
				const user_id = $("input[name='target']").val();
				// 알림 내용 입력
				const notify_content = "테스트 메시지";
				// 알림 클릭 시 이동할 URL
				const notify_url = "${pageContext.request.contextPath}/";

				$.ajax({
					type: "POST",
					url: `${pageContext.request.contextPath}/notify/send`,
					contentType: "application/json",
					data: JSON.stringify({
						user_id: user_id,
						notify_content: notify_content,
						notify_url: notify_url
					}),
					success: function () {
						console.log("알림 전송 성공");
					},
					error: function () {
						console.error("알림 전송 오류");
					}
				});
			});

			// 알림 조회
			$('#list').click(function () {
				const user_id = $("input[name='target2']").val();

				$.ajax({
					type: "GET",
					url: `${pageContext.request.contextPath}/notify/list/\${user_id}`,
					contentType: "application/json",
					success: function (data) {
						// 기존 알림 목록 초기화
						$('#notify-list').empty();

						data.forEach(function (item) {
							const is_check = item._check ? 'background-color: #666;' : '';

							$('#notify-list').append(`
								<ul>
									<li>
										<button style="\${is_check}" onclick="doClick(\${item.notify_id}, '\${item.notify_url}')">
											\${item.notify_content}&emsp;\${timeAgo(item.notify_time)}
										</button>
									</li>
								</ul>
							`);
						});
					},
					error: function () {
						console.error("알림 조회 오류");
					}
				});
			});

			// 알림 상태 변경 및 페이지 이동
			function doClick(notify_id, notify_url) {
				$.ajax({
					type: "POST",
					url: `${pageContext.request.contextPath}/notify/check/\${notify_id}`,
					success: function () {
						// 알림 상태 변경 후 페이지 이동
						window.location.href = notify_url;
					},
					error: function () {
						console.error("읽음 처리 오류");
					}
				});
			}

			function timeAgo(timestamp) {
				const now = Date.now(); // 현재 시간 (밀리초)
				const diff = now - timestamp; // 차이 계산 (밀리초)

				// 시간 단위 계산 (밀리초 단위에서 다른 시간 단위로 변환)
				const minute = 60 * 1000;
				const hour = 60 * minute;
				const day = 24 * hour;
				const week = 7 * day;
				const month = 30 * day;

				if (diff < minute) {
					return '방금 전';
				} else if (diff < hour) {
					return `\${Math.floor(diff / minute)}분 전`;
				} else if (diff < day) {
					return `\${Math.floor(diff / hour)}시간 전`;
				} else if (diff < week) {
					return `\${Math.floor(diff / day)}일 전`;
				} else if (diff < month) {
					return `\${Math.floor(diff / week)}주 전`;
				} else {
					return `\${Math.floor(diff / month)}개월 전`;
				}
			}
		</script>
	</body>

	</html>