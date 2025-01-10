<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<title>살래?!</title>
	
	<!-- Meta Tags -->
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
	<!-- Favicon -->
	<link rel="shortcut icon" href="${contextPath}/resources/images/favicon.ico">
	
	<!-- Google Font -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;700&family=Roboto:wght@400;500;700&display=swap">

	<!-- Plugins CSS -->
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/vendor/font-awesome/css/all.min.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/vendor/bootstrap-icons/bootstrap-icons.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/vendor/tiny-slider/tiny-slider.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/vendor/glightbox/css/glightbox.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/vendor/aos/aos.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/vendor/choices/css/choices.min.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/vendor/quill/css/quill.snow.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/vendor/stepper/css/bs-stepper.min.css">

	<!-- Theme CSS -->
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/css/style.css">
	
	<!-- 외부 CSS -->
    <link rel="stylesheet" href="${contextPath}/resources/css/home.css">
</head>
<body>
	<!-- Header START -->
	<header>
		<div class="container">
			<nav class="navbar navbar-expand-xl">
				<!-- Logo -->
		        <a class="navbar-brand logo" href="${contextPath}/">살래?</a>
		        
		        <!-- Nav Main menu -->
		        <ul class="navbar-nav mx-auto">
		            <li class="nav-item"><a class="nav-link" href="${contextPath}/loan/main">대출 상품</a></li>
		            <li class="nav-item"><a class="nav-link" href="${contextPath}/chat/main" target="_blank">채팅</a></li>
		            <li class="nav-item"><a class="nav-link" href="${contextPath}/board/list">게시판</a></li>
		            <li class="nav-item"><a class="nav-link" href="${contextPath}/product?search=">매물</a></li>
		            <li class="nav-item"><a class="nav-link" href="${contextPath}/product/insert">방내놓기</a></li>
		        </ul>
		        
		        <div class="auth">
        		<c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    <!-- 로그인 상태일 때 -->
                    <a href="${contextPath }/logout">로그아웃</a> 
                   <a href="${contextPath }/transactions">마이페이지</a>
                </c:when> 
                       </c:choose>
                       		             <a href="${contextPath }/login">로그인</a>
		            <a href="${contextPath}/signup">회원가입</a> 
		        </div>
	    	</nav>
	    </div>
    </header>
	<!-- Header END -->
</body>
</html>
