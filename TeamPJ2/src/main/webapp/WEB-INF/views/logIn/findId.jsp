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
    <title>ID찾기</title>
    
     <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .container {
            display: flex;
            width: 90%;
            max-width: 1200px;
            height: 80%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            overflow: hidden;
        }

         .image-section {
        flex: 1;
        background: url('resources/house.jpg') no-repeat center center;
        background-size: cover;
  		}

        .form-section {
            flex: 1;
            padding: 40px;
            background-color: #fff;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-section h1 {
            margin-bottom: 20px;
            font-size: 32px;
            color: #333;
        }

        .form-section form {
            display: flex;
            flex-direction: column;
        }

        .form-section form .form-group {
            margin-bottom: 20px;
        }

        .form-section form label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            color: #666;
        }

        .form-section form input {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-section form .password-toggle {
            position: relative;
        }

        .form-section form .password-toggle input {
            padding-right: 40px;
        }

        .form-section form .password-toggle .toggle {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            cursor: pointer;
            color: #007bff;
        }

        .form-section form .actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .form-section form .actions a {
            font-size: 14px;
            color: #007bff;
            text-decoration: none;
        }

        .form-section form button {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .form-section .signup-link {
            text-align: center;
            margin-top: 20px;
        }

        .form-section .signup-link a {
            color: #007bff;
            text-decoration: none;
        }

    </style>
</head>
<body>
<div class="container">
        <div class="image-section">
        </div>
         <div class="form-section">
        
    <h1>Find Your ID</h1>
    <form action="${contextPath}/findId" method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="user_name" placeholder="Name(이름)" required><br><br>
      <!--   <label for="resident_num">ResidentNum:</label>
        <input type="text" id="birthday" name="resident_num" placeholder="First digits of Resident Registration Number(주민번호앞6자리)" required><br><br> -->
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" placeholder="Enter your email(가입시 등록한 이메일)" required><br><br>
        <button type="submit">Find ID</button>
    </form>
    <br>
   		 <!-- ID찾기 결과 메시지 -->
	    <c:if test="${not empty message}">
	        <p style="color: green;">${message}</p>
	    </c:if>
	    <c:if test="${not empty error}">
	        <p style="color: red;">${error}</p>
	    </c:if>
     </div>
   </div>  
    
   


   
</body>
</html>
