<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"></c:set>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action = "/salre/findId" method="post">
		<label for="user_name">이름 : </label>
		<input type="user_name" id="user_name" name="user_name" required>
		<br>
		<label for="email">이메일 : </label>
		<input type="email" id="email" name="email" required>
		<button type="submit">아이디 찾기</button>	
	</form>
	
	<c:if test="${not empty message}">
		<p style="color:green;">${message}</p>
	</c:if>
	<c:if test="${not empty error}">
	<p style="color: red;">${error}</p>
	</c:if>

</body>
</html> --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"></c:set>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find ID</title>
</head>
<body>
    <h1>Find Your ID</h1>
    <form action="${contextPath}/findId" method="post">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" placeholder="Enter your email" required>
        <button type="submit">Find ID</button>
    </form>
    
   <!-- ID찾기 결과 -->
   ${message}
   
   
</body>
</html>
