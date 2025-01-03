<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<link rel="stylesheet" href="${contextPath}/resources/css/myPage.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

	<!-- Sidebar -->
	<div class="col-md-3 sidebar">

		<div class="container mt-5">
			<div class="profile-container">
				<!-- Profile Image -->
				<img src="https://via.placeholder.com/100" alt="Profile Image">
				<!-- Toggle Buyer/Seller -->
				<div class="toggle-container">
					<span>구매자</span>
					<div class="form-check form-switch">
						<input class="form-check-input" type="checkbox" id="toggleSwitch">
					</div>
					<span>판매자</span>
				</div>
				<!-- Icon Buttons -->
				<div class="icon-buttons">
					<!-- User Icon -->
					<button title="User Profile" onclick="location.href='${contextPath}/myPage'">
						<i class="bi bi-person-circle"></i>
					</button>
					<!-- Settings Icon -->
					<button title="Settings">
						<i class="bi bi-gear"></i>
					</button>
					<!-- Notifications Icon -->
					<button title="Notifications" class="notification-badge">
						<i class="bi bi-bell"></i> <span class="badge">5</span>
					</button>
				</div>
			</div>
		</div>




		<ul>
			<li><a href="${contextPath}/transactions">나의 거래현황</a></li>
			<li><a href="${contextPath}/favorites">나의 관심매물</a></li>
			<li><a href="${contextPath}/posts">내가 작성한 글</a></li>
			<li><a href="${contextPath}/reviews">나의 거래후기</a></li>
			<li><a href="${contextPath}/reports">나의 신고내역</a></li>
			<%-- <li><a href="${contextPath}/myPage">나의 정보</a></li> --%>
		</ul>
	</div>
</body>
</html>