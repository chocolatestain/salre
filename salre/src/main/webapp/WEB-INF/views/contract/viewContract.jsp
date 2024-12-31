<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>


<title>계약서</title>


</head>
<body>
	<h2>계약서 보기</h2>
<c:if test="${not empty imagePath}">
    <img src="${imagePath}" alt="계약서 이미지" style="width:100%; height:auto;">
</c:if>
<c:if test="${not empty errorMessage}">
    <p style="color: red;">${errorMessage}</p>
</c:if>
</body>
</html>