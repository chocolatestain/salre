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
<style>
    .profile-container {
        cursor: pointer; /* 클릭 가능하게 커서 스타일 변경 */
         
    } 
</style>
</head>
<body>
<script>
function submitFormWithUserData() {
    // 세션에서 user 데이터를 가져오기 (예시: 세션에 저장된 'loggedInUser' 객체)
    const user = ${loggedInUser};  // Thymeleaf를 사용하여 세션의 user 객체를 JavaScript로 전달

    // POST할 데이터를 담은 form 생성
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '${contextPath}/admin/myPage';  // 목표 URL 설정

    // user 데이터에서 필요한 정보를 form 데이터로 추가
    const userIdInput = document.createElement('input');
    userIdInput.type = 'hidden';
    userIdInput.name = 'id';  // 전달할 데이터의 key (예: id)
    userIdInput.value = user.id;  // 세션에서 받아온 id 값
    form.appendChild(userIdInput);

    const userNameInput = document.createElement('input');
    userNameInput.type = 'hidden';
    userNameInput.name = 'password';  // 전달할 데이터의 key (예: name)
    userNameInput.value = user.password;  // 세션에서 받아온 name 값
    form.appendChild(userNameInput);

    // 필요한 다른 데이터를 추가할 수 있습니다
    // ...

    // form을 body에 추가하고 제출
    document.body.appendChild(form);
    form.submit();  // POST 요청 전송
}
</script>
	<!-- Sidebar -->
	<div class="col-md-3 sidebar">

		<div class="container mt-5">
			<div class="profile-container" onclick="submitFormWithUserData()">
			    <!-- Profile Image -->
			    <img src="https://via.placeholder.com/100" alt="Profile Image">
			    <!-- Toggle Buyer/Seller -->
			    <div class="toggle-container">
			        <span>관리자</span>
			    </div>
			</div>
		</div>	
 
		<ul> 
			<li><a href="${contextPath }/admin/boardreport">게시물 신고 관리</a></li>
			<li><a href="${contextPath }/admin/productreport">매물 신고 관리</a></li>
			<li><a href="${contextPath }/admin/userreport">사용자 신고 관리</a></li>
		</ul>
	</div>
</body>
</html>