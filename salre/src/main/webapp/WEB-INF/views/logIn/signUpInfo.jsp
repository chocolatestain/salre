<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" />
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<%
    String certifiedName = (String) session.getAttribute("certifiedName");
    String certifiedPhone = (String) session.getAttribute("certifiedPhone");
    String certifiedBirthday = (String) session.getAttribute("certifiedBirthday");
    System.out.println("Info 세션 데이터:");
    System.out.println("Name: " + certifiedName);
    System.out.println("Phone: " + certifiedPhone);
    System.out.println("Birthday: " + certifiedBirthday);


%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - 회원정보입력</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
        }

        .container {
            display: flex;
            width: 90%;
            max-width: 1200px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            overflow: hidden;
            background-color: #fff;
        }

        .image-section {
            flex: 1;
            background: url('resources/house.jpg') no-repeat center center;
            background-size: cover;
        }

        .form-section {
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-section h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }

        .form-section p {
            font-size: 14px;
            color: #666;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        .form-group {
            margin-bottom: 20px;
            display: flex;
            flex-direction: column;
            
        }
        .residenseTop{
         margin-bottom: 20px;
        }

        .form-group-inline  {
            display: flex;
            align-items: center;/* 세로 중앙 정렬 */
            gap: 15px;/* 입력 필드와 버튼 사이 간격 */
          
        }

        .form-group-inline input  {
           
            flex: 1; /* 입력 필드가 남은 공간을 차지하도록 설정 */
		    padding: 10px;
		    font-size: 14px;
		    border: 1px solid #ccc;
		    border-radius: 4px;
		    /*background-color: #f8f9fa;  입력 필드 배경색 */
		    background-color: white;
		    color: #6c757d; /* 텍스트 색상 */
    		
    		width : 75%
        }

           .labelInput{
           
            flex: 1; /* 입력 필드가 남은 공간을 차지하도록 설정 */
	 		
    		width : 75%
        }
        
        .form-group-inline button {
   
            padding: 10px; /* 버튼 내부 좌우 여백 */
		    font-size: 14px;
		    /* font-weight: bold; */
		    color: white;
		    background-color: #007bff; /* 버튼 배경색 */
		    border: none;
		    border-radius: 4px;
		    cursor: pointer;
		    width:25%
        }

        .form-group-inline button:hover {
            background-color: #0056b3; /* 마우스 오버 시 버튼 색상 */
        }

        input {
            
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        .navigation-buttons {
            display: flex;
            gap: 10px;
        }

        .navigation-buttons button {
            flex: 1;
            background: transparent;
            border: 1px solid #007bff;
            color: #007bff;
            border-radius: 4px;
            cursor: pointer;
        }

        .navigation-buttons button:hover {
            background-color: #007bff;
            color: white;
        }

        a {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
            color: #007bff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
        
        .success-message {
		    color: green; /* 초록색 */
		    font-size: 14px;
		    margin-top: 5px;
		}
		
		.error-message {
		    color: red; /* 빨간색 */
		    font-size: 14px;
		    margin-top: 5px;
}
        
    </style>
</head>
<%-- <body>
    <div class="container">
        <!-- 좌측 이미지 섹션 -->
        <div class="image-section"></div>

        <!-- 우측 폼 섹션 -->
        <div class="form-section">
            <h1>Sign Up / 회원정보입력</h1>
            <p>회원님의 정보를 입력해주세요.</p>
            <form action="${contextPath}/signUpProcess" method="post"> 
                
                 <div class="form-group">
	                <label for="id">ID</label>     
	                <div class="form-group-inline">              
	 				      
	                    <input type="text" id="id" name="id" placeholder="ID" required>
	                    <button type="button" id="idcheck" onclick="checkIdAvailability()">ID 중복체크</button>
	                    <br>
	                </div>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Password" required>
                </div>

				<div class="form-group-inline">                                             
                        <label for="name"  class="labelInput">Name</label>            
                        <label for="phone" class="labelInput">Phone</label>                  
                </div>
                
                <div class="form-group-inline residenseTop">                                             
                        <input type="text" id="name" name="name" placeholder="Name" required>            
                        <input type="text" id="phone" name="phone" placeholder="Phone" required>                  
                </div>

                <div class="form-group">
                    <label for="resident-number">Resident Number</label>
                    <input type="text" id="resident-number" name="residentNumber" placeholder="Resident Number" required>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="Email" required>
                </div>

                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" placeholder="Address" required>
                </div>


                <div class="navigation-buttons">
                    <button type="button" onclick="history.back()">이전</button>
                    <button type="submit">다음</button>
                </div>
            </form>
            <a href="${contextPath}/login">Already have an account?</a>
        </div>
    </div>
    <script>
        function checkIdAvailability() {
            const id = document.querySelector('[name="id"]').value.trim();
            if (!id) {
                alert("ID를 입력하세요.");
                return;
            }
            // AJAX 요청을 통해 ID 중복 체크
            $.ajax({
            	url: "${contextPath}/checkId",
                type: "GET",
                data: { id },
                success: function (response) {
                    if (response === "available") {
                        alert("사용 가능한 ID입니다.");
                    } else {
                        alert("이미 사용 중인 ID입니다.");
                    }
                },
                error: function () {
                    alert("ID 중복 체크 중 오류가 발생했습니다.");
                },
            });
        }
    </script>
</body> --%>
<body>
    <div class="container">
        <div class="image-section"></div>
<!--  스크롤   <div class="form-section" style = "overflow:auto;   height : 500px;"> -->
        <div class="form-section" >
            <h1>Sign Up / 회원정보입력</h1>
            <form action="${contextPath}/signup" method="post" onsubmit="return validateSignUp()">
                <div class="form-group">
                    <label for="id">ID</label>
                    <div class="form-group-inline">
                        <input type="text" id="id" name="id" placeholder="ID" required>
                        <button type="button" onclick="checkIdAvailability()">ID 중복체크</button>
                    </div>
                     <span id="id-check-message" style="font-size: 14px;"></span>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Password" required>
                </div>


                 <div class="form-group">
                    <label for="name">Name</label>
                     <input type="text" id="name" name="user_name"  value="${sessionScope.certifiedName}"  readonly> 
                    <!-- <input type="text" id="name" name="user_name"  value="test18"  readonly> -->
                </div>

         
                 <div class="form-group">
                   
                    <label for="phone">Phone</label>
                   <input type="text" id="phone" name="phone_num" value="${sessionScope.certifiedPhone}" readonly> 
                   
                </div>


				<label for="birthday">ResidentNum</label>
				<div class="form-group-inline">
                	<input type="text" id="birthday" name="resident_num"  value="${sessionScope.certifiedBirthday}" readonly>
                    <input type="text" id="birthday2" name="resident_num2"  placeholder="Lastdigits of ResidentRegistrationNumber" ><br>
                </div>
				<br>	

	  	<%-- 		 <div class="form-group">
                    <label for="birthday">ResidentNum</label>
                    <input type="text" id="birthday" name="birthday"  value="${sessionScope.certifiedBirthday}" readonly>
                </div>  --%>

          		  <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="Email" required onblur="checkEmailAvailability()">
                    <span id="email-check-message" style="font-size: 14px;"></span>
                </div>

				
				<div class="form-group">
                    <label for="address">Address</label>
                    <div class="form-group-inline">
                        <input type="text" id="address" name="address" placeholder="Address(등본상주소입력필수)" required>
                        <button type="button" onclick="checkAddress()">주소 검색</button>
                        
                    </div>
                    <input type="text" id="birthday2" name="address_detail"  placeholder="AddressDetail(등본상주소입력필수)" required ><br>
                </div>
				

				<!-- <label for="address">Address</label>
				<div class="form-group-inline">
	               
					
                    <input type="text" id="address" name="address"  placeholder="Address" required> ,
                    <input type="text" id="birthday2" name="address_detail"  placeholder="AddressDetail" required ><br>
                </div>  -->
                <!-- <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" placeholder="Address" required>
                </div> -->
				<br>
                <div class="navigation-buttons">
                    <button type="button" onclick="history.back()">이전</button>
                    <button type="submit">회원가입</button>
                    
                </div>
                 
            </form>
        </div>
    </div>
      <script>
      
      /* ID중복체크  */
        function checkIdAvailability() {
            const id = document.querySelector('[name="id"]').value.trim();
            if (!id) {
                alert("ID를 입력하세요.");
                return;
            }
            // AJAX 요청을 통해 ID 중복 체크
            $.ajax({
            	url: "${contextPath}/checkId",
                type: "GET",
                data: { id },
                success: function (response) {
                    if (response === "available") {
                        alert("사용 가능한 ID입니다.");
                        showMessage("id-check-message", "사용 가능한 ID입니다.", "success-message");
                    } else {
                        alert("이미 사용 중인 ID입니다.");
                        showMessage("id-check-message", "이미 사용중인 ID입니다.", "error-message");
                    }
                },
                error: function () {
                    alert("ID 중복 체크 중 오류가 발생했습니다.");
                },
            });
        }
        
       
       /* 주소검색 */
       function checkAddress(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	         var addr=data.address;//기본주소
	         // 주소 정보를 해당 필드에 넣는다
             document.getElementById("address").value = addr;
	        }
	    }).open();
       }

       
       function checkEmailAvailability() {
    	    const email = document.querySelector('#email').value.trim();

    	    if (!email) {
    	        showMessage("email-check-message", "이메일을 입력하세요.", "error-message");
    	        return;
    	    }

    	    // AJAX 요청으로 이메일 중복 체크
    	    $.ajax({
    	        url: "${contextPath}/checkEmail",
    	        type: "GET",
    	        data: { email },
    	        success: function(response) {
    	            if (response === "available") {
    	                showMessage("email-check-message", "사용 가능한 이메일입니다.", "success-message");
    	            } else {
    	                showMessage("email-check-message", "이미 가입된 이메일이 있습니다.", "error-message");
    	            }
    	        },
    	        error: function() {
    	            showMessage("email-check-message", "이메일 중복 체크 중 오류가 발생했습니다.", "error-message");
    	        }
    	    });
    	}
       function validateSignUp() {
    	    // ID 중복 체크 메시지
    	    const idMessage = document.getElementById('id-check-message').textContent;
    	    const emailMessage = document.getElementById('email-check-message')?.textContent || '';

    	    // 유효성 검증: 중복체크 결과 확인
    	    if (idMessage !== "사용 가능한 ID입니다.") {
    	        alert("ID 중복체크를 완료해주세요.");
    	        return false;
    	    }
    	  
    	    if (emailMessage !== "사용 가능한 이메일입니다.") {
    	        alert("이메일 중복체크를 완료해주세요.");
    	        return false;
    	    }

    	    // 추가 필드 유효성 검사
    	    const password = document.getElementById('password').value.trim();
    	    const residentNum2 = document.getElementById('birthday2').value.trim();
    	    const address = document.getElementById('address').value.trim();
    	    const addressDetail = document.querySelector('[name="address_detail"]').value.trim();

    	    if (!password) {
    	        alert("비밀번호를 입력해주세요.");
    	        return false;
    	    }
    	    if (!residentNum2) {
    	        alert("주민등록번호 뒷자리를 입력해주세요.");
    	        return false;
    	    }
    	    if (!address) {
    	        alert("주소를 입력해주세요.");
    	        return false;
    	    }
    	    if (!addressDetail) {
    	        alert("상세주소를 입력해주세요.");
    	        return false;
    	    }

    	    // 모든 유효성 검사를 통과한 경우
    	    return true;
    	}
    	// 메시지 표시 함수
    	function showMessage(elementId, message, className) {
    	    const messageElement = document.getElementById(elementId);
    	    messageElement.textContent = message;
    	    messageElement.className = className;
    	}

    </script>
</body>
</html>
 
 
 
 
 
 