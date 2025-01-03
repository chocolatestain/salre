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
                    <a href="/forgot-password">Forgot Password?</a>
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
 