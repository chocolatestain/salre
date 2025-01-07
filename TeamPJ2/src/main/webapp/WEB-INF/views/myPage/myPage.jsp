<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath"
	value="${pageContext.servletContext.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Page</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<link rel="stylesheet" href="${contextPath}/resources/css/myPage.css">

</head>
<body>
	<%@ include file="../common/header.jsp"%>


	<div class="container-fluid">
		<div class="row">
			<!-- Sidebar -->
			<%@ include file="../common/sidebar.jsp" %>

			<!-- Main Content -->
			<div class="col-md-9 content">

				<h1 class="mb-4">나의 정보관리</h1>
				<br> <br>

				<h4 class="mb-4">나의 정보</h4>
				<!-- <form> -->
				
	
					<div class="row mb-3">
						<div class="col-md-6">
							<label for="id" class="form-label">ID</label> <input type="text"
								id="id" class="form-control" value="${loggedInUser.id}" readonly>
						</div>
						<div class="col-md-6">
							<label for="phone" class="form-label">Phone</label> <input
								type="text" id="phone" class="form-control"
								value="${loggedInUser.phone_num}" readonly>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col-md-6">
							<label for="name" class="form-label">이름</label> <input
								type="text" id="name" class="form-control"
								value="${loggedInUser.user_name}" readonly>
						</div>
						<div class="col-md-6">
							<label for="email" class="form-label">Email</label> <input
								type="email" id="email" class="form-control"
								value="${loggedInUser.email}" readonly>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col-md-6">
							<label for="resident" class="form-label">주민등록번호</label> <input
								type="text" id="resident" class="form-control"
								value="${loggedInUser.resident_num}" readonly>
						</div>
						<div class="col-md-6">
							<label for="address" class="form-label">주소</label> <input
								type="text" id="address" class="form-control"
								value="${loggedInUser.address}/${loggedInUser.address_detail}" readonly
								>
						</div>
					</div><br><br>

					<%-- <div class="row mb-3">
						<div class="col-md-6">
							<label for="password" class="form-label">Password</label>
							<input
								type="password" id="password" class="form-control"
								value="${loggedInUser.password}" > --%>
						<%-- 	<div class="input-group">
								<input type="password" id="password" class="form-control"
									value="${loggedInUser.password}" >
								<button type="button" class="btn btn-outline-secondary"
									onclick="togglePassword()">👁</button> 
							</div> --%>

			<!-- 			</div>
					</div> -->

				<%-- 	<button onclick="call()" type="button" class="btn btn-primary w-10">회원정보수정</button>
					
					<form action="${contextPath}/deleteUser" method="post" onsubmit="return confirm('정말로 탈퇴하시겠습니까?');">
					    <input type="hidden" name="id" value="${loggedInUser.id}">
					    <button type="submit" class="btn btn-danger">회원탈퇴</button>
					</form> --%>
			<div class="d-flex justify-content-end align-items-center">
			    <!-- <button onclick="call()" type="button" class="btn btn-primary me-2">회원정보수정</button> -->
			    <button onclick="location.href='${contextPath}/updatemyPage'" type="button" class="btn btn-primary me-2">회원정보수정</button>
			    
			    <form action="${contextPath}/deleteUser" method="post" onsubmit="return confirm('정말로 탈퇴하시겠습니까?');" class="m-0">
			        <input type="hidden" name="id" value="${loggedInUser.id}">
			        <button type="submit" class="btn btn-danger">회원탈퇴</button>
			    </form>
			</div>
			

			</div>
		</div>
	</div>

   <!--  <script type="text/javascript">
    	function call(){
    		$.ajax({
    			url : '${contextPath}/myPage/myPage',
    			type: 'post',
    			data:{"id":$("#id").val(),  "user_name":"ppp" },
    			success:function(a){
    				alert(a);
    			}
    		});
    			
    		
    	}
    </script>
 -->

	<%@ include file="../common/footer.jsp"%>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Icons -->
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
	
	
	<!-- 회원정보수정(password 보이게) -->
	<script>
		function togglePassword() {
			const passwordInput = document.getElementById('password');
			if (passwordInput.type === 'password') {
				passwordInput.type = 'text';
			} else {
				passwordInput.type = 'password';
			}
		}
	</script>
</body>
</html>
