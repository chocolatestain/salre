<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<title>살래?</title>
	
	<!-- 외부 CSS -->
    <%-- <link rel="stylesheet" href="${contextPath}/resources/css/home.css"> --%>
    <link rel="stylesheet" href="${contextPath}/resources/css/header.css">
</head>
<body>
	<%--
	<!-- Header START -->
	<header>
		<div class="container">
			<nav class="navbar navbar-expand-xl">
				<!-- Logo -->
		        <a class="navbar-brand logo" href="${contextPath}/">
					<img src="${contextPath}/resources/images/favicon.ico" class="light-mode-item navbar-brand-item">
					<span class="dark-mode-item navbar-brand-item">살래?</span>
				</a>
		        
		        <!-- Nav Main menu -->
		        <ul class="navbar-nav mx-auto">
		        	<li class="nav-item"><a class="nav-link" href="${contextPath}/product?search=">매물</a></li>
		            <li class="nav-item"><a class="nav-link" href="${contextPath}/product/insert">방내놓기</a></li>
		            <c:choose>
	        			<c:when test="${not empty sessionScope.loggedInUser}">
		        			<li class="nav-item"><a class="nav-link" href="${contextPath}/chat/main.do" target="_blank">채팅</a></li>
	        			</c:when>
	        			<c:otherwise>
	        				<li class="nav-item"><a class="nav-link" href="${contextPath}/chat/main.do">채팅</a></li>
	        			</c:otherwise>
	        		</c:choose>
		            <li class="nav-item"><a class="nav-link" href="${contextPath}/board/list">게시판</a></li>
		            <li class="nav-item"><a class="nav-link" href="${contextPath}/loan/main">대출 상품</a></li>
		        </ul>
		        
		        <div class="auth">
	        		<c:choose>
	        			<c:when test="${not empty sessionScope.loggedInUser}">
	        				<!-- 로그인 상태일 때 -->
		        			<a href="${contextPath}/logout">로그아웃</a>
		        			<a href="${contextPath}/transactions">마이페이지</a>
	        			</c:when>
	        			<c:otherwise>
	        				<!-- 로그아웃 상태일 때 -->
	        				<a href="${contextPath}/login">로그인</a>
	        				<a href="${contextPath}/signup">회원가입</a>
	        			</c:otherwise>
	        		</c:choose>
		        </div>
	    	</nav>
	    </div>
    </header>
	<!-- Header END -->
	--%>
	
	<!-- Header START -->
    <header>
        <div class="logo">
            <nav>
                <a href="${contextPath}/">
                    <div style="padding-right: 20px;">
                        <img src="${contextPath}/resources/images/favicon.ico">
                    </div>
                    <div>살래?</div>
                </a>
            </nav>
        </div>
        <div class="menu">
            <nav>
                <a href="${contextPath}/product?search=">매물</a>
                <a href="${contextPath}/product/insert">방내놓기</a>
                <c:choose>
                    <c:when test="${not empty sessionScope.loggedInUser}">
                            <a class="nav-link" href="${contextPath}/chat/main.do" target="_blank">채팅</a>
                    </c:when>
                    <c:otherwise>
                            <a class="nav-link" href="${contextPath}/chat/main.do">채팅</a>
                    </c:otherwise>
                </c:choose>
                <a href="${contextPath}/board/list">게시판</a>
                <a href="${contextPath}/loan/main">대출상품</a>
            </nav>
        </div>
        <div class="auth">
            <c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    <!-- 로그인 상태일 때 -->
                    <a href="${contextPath}/logout">로그아웃</a>
                    <a href="${contextPath}/transactions">마이페이지</a>
                </c:when>
                <c:otherwise>
                    <!-- 로그아웃 상태일 때 -->
                    <a href="${contextPath}/login">로그인</a>
                    <a href="${contextPath}/signup">회원가입</a>
                </c:otherwise>
            </c:choose>
        </div>
    </header>
    <!-- Header END -->
</body>
</html>