<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - 본인인증</title>
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


        .form-section p { /*  */
            font-size: 14px;
            margin-bottom: 20px;
            color: #666;
        }

        .form-section button {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-bottom: 15px;
        }

        .form-section button:hover {
            background-color: #0056b3;
        }

        .form-section .actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .form-section .actions button {
            flex: 1;
            margin: 0 5px;
            background: transparent;
            border: 1px solid #007bff;
            color: #007bff;
            border-radius: 4px;
            cursor: pointer;
        }

        .form-section .actions button:hover {
            background-color: #007bff;
            color: white;
        }
    </style>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <script src=" https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        // 포트원 본인인증 초기화
        IMP.init("imp74358381");

        function requestCertification() {
            IMP.certification({
            	// param
                channelKey: "{channel-key-338d3c61-d13e-4639-9997-033ab26725cd}",
                merchant_uid: "ORD" + new Date().getTime(),
                popup: true,
            }, function (rsp) {
            	  // callback//본인인증 완료 후 호출되는 콜백 함수. 본인인증 요청의 결과가 담긴 객체가 rsp로 전달됨.
                if (rsp.success) {
                	// 인증 성공 시 로직
                    alert("본인인증 성공: " + rsp.imp_uid);
                    
                    $.ajax({
                 	   url:"${contextPath}/rspTest",
                 	   type:"post", 
                 	   data : { imp_uid:`\${rsp.imp_uid}`},
                 	   success: function(responseData){
                 		   var myInfo = JSON.parse(responseData); // 응답 데이터를 객체로 파싱
                 		   
                 		   console.log(myInfo);
                 		   /* if (myInfo.response) {
                 	            // 각 입력 필드를 선택
                 	            var phoneInput = document.querySelector('[name="phone_num"]');
                 	            var nameInput = document.querySelector('[name="user_name"]');
                 	            var residentInput = document.querySelector('[name="resident_num"]');

                 	            // 필드 값 설정
                 	            phoneInput.value = myInfo.response.phone;
                 	            nameInput.value = myInfo.response.name;
                 	            residentInput.value = myInfo.response.birthday;

                 	            // 필드를 읽기 전용으로 설정
                 	            phoneInput.readOnly = true;
                 	            nameInput.readOnly = true;
                 	            residentInput.readOnly = true; */
                 	        }
                 	  });
                    document.getElementById("next-button").disabled = false; // 다음 버튼 활성화
                } else {
                    alert("본인인증 실패: " + rsp.error_msg);
                }
               }
          );
        }
    </script>
</head>
<body>
    <div class="container">
        <!-- 좌측 이미지 섹션 -->
        <div class="image-section">
        </div>

        <!-- 우측 폼 섹션 -->
        <div class="form-section">
            <h1>Sign Up / 본인인증</h1>
            <p>
                회원님의 소중한 개인정보 보호를 위해 본인확인이 필요합니다.<br>
                아래 버튼을 눌러 본인인증을 진행해주세요.<br>
                
            </p>
            <button type="button" onclick="requestCertification()">본인인증</button>
            <div class="actions">
                <button type="button" onclick="history.back()">이전</button> <!-- 뒤로가기 history.back 쓰기 -->
                <button id="next-button" type="button" onclick="location.href='${contextPath}/signUpInfo'" >다음</button> <!-- disabled? -->
            </div>
        </div>
    </div>
</body>
</html>
 