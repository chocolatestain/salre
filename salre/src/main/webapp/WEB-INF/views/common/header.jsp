<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${contextPath}/resources/css/common/headerfooter.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
    <header>
        <div class="logo">살래?</div>
        <nav>
            <a href="#">대출상품</a>
            <a href="#">채팅</a>
            <a href="#">게시판</a>
            <a href="#">매물</a>
            <a href="#">관심매물</a>
            <a href="#">방내놓기</a>
        </nav>
           <div class="auth">
            <c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    <!-- 로그인 상태일 때 -->
                    <a href="${contextPath }/logout">로그아웃</a> 
                </c:when> 
            </c:choose>
        </div>
        
    </header>
</body>
</html>
