<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="${pageContext.request.contextPath}/resources/favicon.ico" type="image/x-icon">
<meta charset="UTF-8">
<title>알림 테스트</title>
<script type="text/javascript">
	var sse;

	// 로그인 버튼을 누르면 해당 userId로 SSE 연결을 시도한다.
	function subscribe() {
		var userId = document.getElementById("userId").value;
		if (!userId) {
			alert("로그인 필요");
			return;
		}

		// SSE 연결을 열고, 서버로부터 오는 메시지를 처리
		sse = new EventSource("/notification/subscribe/" + userId);
		sse.onmessage = function(event) {
			var log = document.getElementById("log");
			// 서버에서 전송된 메시지를 Log에 추가
			log.innerHTML += "Received message: " + event.data + "<br>";
			// 스크롤을 맨 아래로 내리기
			log.scrollTop = log.scrollHeight;
		};

		sse.onerror = function(event) {
			console.error("Error: ", event);
			sse.close();
		};

		document.getElementById("status").innerText = "현재 접속중인 ID: " + userId;
	}

	// 공지사항 발송 버튼을 누르면 메시지를 해당 userId로 보낸다.
	function broadcast() {
		var userId = document.getElementById("userId").value;
		var message = document.getElementById("message").value;
		if (!userId || !message) {
			alert("오류 발생");
			return;
		}

		// 공지사항 메시지를 서버로 전송
		var xhr = new XMLHttpRequest();
		xhr.open("POST", "/notification/broadcast/" + userId, true);
		xhr.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var log = document.getElementById("log");
				// 공지사항 발송이 성공적으로 이루어졌을 때 Log에 메시지를 표시
				log.innerHTML += "📢&ensp;공지사항 보냄 >> " + message + "<br>";
				log.scrollTop = log.scrollHeight; // 스크롤을 맨 아래로 내리기
			}
		};
		xhr.send("message=" + encodeURIComponent(message)); // 메시지 전송
	}

	// 메시지 보내기 버튼을 누르면 특정 유저에게 메시지를 전송
	function sendToClient() {
		var targetUserId = document.getElementById("targetUserId").value; // 메시지를 받을 유저 ID
		var message = document.getElementById("message2").value; // 보낼 메시지
		if (!targetUserId || !message) {
			alert("오류 발생");
			return;
		}

		// 메시지를 서버로 전송
		var xhr = new XMLHttpRequest();
		xhr.open("POST", "/notification/sendToClient/" + targetUserId,
				true);
		xhr.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var log = document.getElementById("log");
				// 메시지가 성공적으로 전송된 후 Log에 표시
				log.innerHTML += "👂&ensp;" + targetUserId + "에게 보냄 >> "
						+ message + "<br>";
				log.scrollTop = log.scrollHeight; // 스크롤을 맨 아래로 내리기
			}
		};
		xhr.send("message=" + encodeURIComponent(message2)); // 메시지 전송
	}
</script>
</head>

<body>
	<h1>🔔 알림 테스트</h1>
	<hr>
	<div>
		<label for="userId">아이디: </label> <input type="text" id="userId"
			placeholder="아이디 입력" />
		<button onclick="subscribe()">로그인</button>
		<p id="status"></p>
	</div>
	<hr>
	<div>
		<h2>공지사항</h2>
		<label for="message">내용: </label> <input type="text" id="message"
			placeholder="내용 입력" />
		<button onclick="broadcast()">발송</button>
	</div>

	<div>
		<h2>귓속말</h2>
		<label for="targetUserId">수신자 ID: </label> <input type="text"
			id="targetUserId" placeholder="수신자 입력" /> <label for="message2">내용:
		</label> <input type="text" id="message2" placeholder="내용 입력" />
		<button onclick="sendToClient()">발송</button>
	</div>
	<hr>
	<div>
		<h2>메시지 기록</h2>
		<div id="log"
			style="border: 1px solid black; height: 200px; overflow-y: scroll;"></div>
	</div>
</body>

</html>