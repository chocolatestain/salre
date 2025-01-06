<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PW 찾기</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    
    
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
        
    <h1>비밀번호 찾기</h1>
    <form id="findPasswordForm">
        <label for="id">ID:</label>
        <input type="text" id="id" name="id" required><br><br>
        
        <label for="email">이메일:</label>
        <input type="email" id="email" name="email" required><br><br>
        
        <button type="button" onclick="sendVerificationCode()">인증번호 발송</button><br><br>

        <div id="verificationSection" style="display:none;">
            <label for="verificationCode">인증번호:</label>
            <input type="text" id="verificationCode" name="verificationCode"><br><br>
            <button type="button" onclick="verifyCode()">인증번호 확인</button><br><br>

            <div id="resetPasswordSection" style="display:none;">
                <label for="newPassword">새 비밀번호:</label>
                <input type="password" id="newPassword" name="newPassword"><br><br>
                <button type="button" onclick="resetPassword()">비밀번호 변경</button>
            </div>
        </div>
    </form>
   </div>
      </div>
   
     
    <script>
        function sendVerificationCode() {
            const id = $('#id').val();
            const email = $('#email').val();

            $.ajax({
                url: '${contextPath}/sendVerificationCode',
                type: 'POST',
                data: { id: id, email: email },
                success: function(response) {
                    if (response.success) {
                        alert(response.message);//성공메세지표시
                        $('#verificationSection').show();// 인증번호 입력 영역 표시
                    } else {
                        alert(response.message);//실패메세지표시
                    }
                },
                error: function() {
                    alert("서버 오류가 발생했습니다.");
                }
            });
        }

        function verifyCode() {
            const verificationCode = $('#verificationCode').val();
            const email = $('#email').val();

            $.ajax({
                url: '${contextPath}/verifyCode',
                type: 'POST',
                data: { verificationCode: verificationCode, email: email },
                success: function(response) {
                    if (response.success) {
                        alert(response.message);//성공메세지표시
                        $('#resetPasswordSection').show();
                    } else {
                        alert(response.message);//실패메세지표시
                    }
                },
                error: function() {
                    alert("서버 오류가 발생했습니다.");
                }
            });
        }

        function resetPassword() {
            const email = $('#email').val();
            const newPassword = $('#newPassword').val();

            $.ajax({
                url: '${contextPath}/resetPassword',
                type: 'POST',
                data: { email: email, newPassword: newPassword },
                success: function(response) {
                    alert(response.message);
                    if (response.success) {
                        window.location.href = '${contextPath}/login';
                    }
                },
                error: function() {
                    alert("서버 오류가 발생했습니다.");
                }
            });
        }
    </script>
</body>
</html>

 
