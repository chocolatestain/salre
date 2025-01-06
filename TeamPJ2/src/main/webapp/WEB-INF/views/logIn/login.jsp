<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Login</title>
    
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            background-color: #fff;
            border-bottom: 1px solid #ddd;
        }
        header .logo {	
            font-size: 24px;
            font-weight: bold;
        }
        header nav a {
            margin: 0 10px;
            text-decoration: none;
            color: #333;
        }
        header .auth a {
            margin-left: 15px;
            padding: 10px 20px;
            background-color: #f4a261;
            color: #fff;
            border-radius: 5px;
            text-decoration: none;
        }
        .main-banner {
            text-align: center; 
            background: url('resources/images/mainpage_bg.webp') no-repeat center center/cover;
            color: #333;
            padding: 60px 20px;
        }
        .main-banner img {
 		  opacity: 0.5; /* 이미지 투명도 설정 */
		}
        .main-banner h1 {
            font-size: 48px;
            margin-bottom: 10px;
        }
        .main-banner p {
            font-size: 18px;
            margin-bottom: 20px;
        }
        .main-banner input {
            padding: 10px;
            width: 300px;
            margin-right: 10px;
        }
        .main-banner button {
            padding: 10px 20px;
            background-color: #f4a261;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        .stats {
            text-align: center;
            padding: 20px;
            background-color: #f9f9f9;
            font-size: 18px;
        }
 
        footer {
            display: flex;
            justify-content: space-around;
            background-color: #222;
            color: #fff;
            padding: 20px 0;
        }
        footer div {
            text-align: left;
        }
        footer a {
            color: #f4a261;
            text-decoration: none;
        }
 
    </style>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	
    <h1>Login</h1>
    
    <!-- 로그인 -->
    <form action="${contextPath}/login" method="post">
        <label for="id">ID:</label>
        <input type="text" id="id" name="id" required>
        <br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <br>
        <button type="submit">Login</button><br>
    </form>
    
      <!-- ID 찾기와 PW 찾기 버튼 추가 -->
    <div style="margin-top: 10px;">
        <button onclick="location.href='${contextPath}/findId'">ID 찾기</button>
        <button onclick="location.href='${contextPath}/resetPassword'">PW 찾기</button><br>
    </div>

    <!-- 에러 메시지 표시 -->
    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>
    
    <%@ include file="../common/footer.jsp" %>
</body>
</html>
 --%>
 
 
 
 
 
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"></c:set>
  <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Log In</title>
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
            <h1>Log In</h1>
               <!-- 에러 메시지 표시 -->
			    <c:if test="${not empty error}">
			        <p style="color: red; margin-bottom: 10px;">${error}</p>
			    </c:if>
			            
               <form action="${contextPath}/login" method="post">
                <div class="form-group">
                    <label for="id">ID</label>
                    <input type="text" id="id" name="id" placeholder="ID를 입력하세요." required>
                </div>
                <div class="form-group password-toggle">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="PW를 입력하세요." required>
                </div>
                <div class="actions">
                   <!--  <label>
                        <input type="checkbox" name="remember"> Remember me
                    </label> -->
                    <a href="${contextPath}/findId">Forgot Id?</a>
                    <a href="${contextPath}/findPassword">Forgot Password?</a>
                </div>
                <button type="submit">Log In</button>
            </form>
            <div class="signup-link">
                <p>No account yet? <a href="${contextPath}/signup">Sign Up</a></p>
            </div>
        </div>
    </div>



    
    
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






 