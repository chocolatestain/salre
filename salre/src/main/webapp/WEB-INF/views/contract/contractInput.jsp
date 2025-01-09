<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../fix/header.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>

<title>계약 입력</title>

<link rel="stylesheet" href="${path}/resources/css/contractInput.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
    <div class="container">
        <h1 class="title">계약사항 추가 입력</h1>
		<form id="contractInput" action="${path}/contract/save" method="post">
            <!-- 계약 내용 -->
            <section class="section">
                <h2>계약 내용</h2>
                <div class="form-group">
                    <label for="account">계좌번호:</label>
                    <input type="text" id="account" name="account" required value="673002-01-199754">
                </div>
                <div class="form-group">
                    <label for="deposit_INT">보증금:</label>
                    <input type="text" id="deposit" name="deposit_INT" required oninput="formatNumber(this)">
                </div>
                <div class="form-group">
                    <label for="price">계약금:</label>
                    <input type="text" id="price" name="price" required  oninput="formatNumber(this)">
                </div>
                <div class="form-group2">
                    <label for="middle_payment">중도금:</label>
                    <input type="text" id="middle_payment" name="middle_payment" oninput="formatNumber(this)" ><br>
                    <label for="middle_payment">지급일:</label>
                    <input type="date" id="middle_payment_day" name="middle_payment_day"  value="1000-01-01">
                </div>
                <div class="form-group2">
                    <label for="balance_payment">잔금:</label>
                    <input type="text" id="balance_payment" name="balance_payment" oninput="formatNumber(this)"><br>
                    <label for="balance_payment">지급일:</label>
                    <input type="date" id="balance_payment_day" name="balance_payment_day">
                </div>
               <c:choose>
            <c:when test ="${contract.payment_type=='전세'}">
           
            </c:when> 
            <c:when test = "${product.payment_type=='월세'}">
              <div class="form-group2">
                    <label for="rent_fee_day">월세 입금일:</label>
                    <input type="number" id="rent_fee_day" name="rent_fee_day"  min="1" max="9" placeholder = "00일"><br>
                </div>
            </c:when>
     </c:choose>
                
                <div class="form-group">
                    <label for="contract_startdate">임대차 기간:</label>
                    <input type="date" id="contract_startdate" name="contract_startdate" required value="2024-05-01">
                    ~
                    <input type="date" id="contract_enddate" name="contract_enddate" required  value="2025-08-02" >
               </div>
                <div class="form-group">
                    <label for="contract_date">계약일:</label>
                    <input type="date" id="contract_date" name="contract_date" required  value="2025-01-02" >
                	</div>
            </section>

            <!-- 특약사항 -->
			<section class="section">
				<h2>특약사항</h2>
				<div class="form-group">
					<label for="contract_rule">특약사항:</label>
					<textarea id="contract_rule" name="contract_rule" rows="10"
						cols="50">${contract.contract_rule}</textarea>
				</div>
			</section>

			<section class="section">
				<!-- 증빙 서류 등록 -->
				<h2>증빙 서류 등록</h2>
				<div class="form-group">
					<label for="photo">신분증 사본 *</label> <input type="file" id="photo"
						name="identificationCard" accept="image/*" required>
				</div>
				<div class="form-group">
					<label for="photo">통장 사본 *</label> <input type="file" id="photo"
						name="bankAccount" accept="image/*" required>
				</div>
			</section>
			<!-- 제출 버튼 -->
            <div class="button-group">
                <button type="submit" class="btn btn-primary">계약사항 등록</button>
                </div>
                <input type="hidden" name = "product_id" value = "${product.product_id}">
                <input type="hidden" name = "user_id" value = "${user.user_id}">
        </form>
    </div>
    <script>
    function formatNumber(input) {
        // 입력된 값을 숫자로 변환 (숫자 외 문자 제거)
        const value = input.value.replace(/,/g, "");
        
        // 천 단위로 ',' 추가
        const formattedValue = new Intl.NumberFormat().format(value);

        // 포맷팅된 값을 다시 입력 필드에 반영
        input.value = formattedValue;
    }
    // 폼 제출 시 값을 숫자로 변환
    document.getElementById('contractInput').addEventListener('submit', function (event) {
        // 모든 숫자 입력 필드를 선택
        const numberFields = document.querySelectorAll('input[type="text"][oninput="formatNumber(this)"]');

        // 각 필드의 값을 숫자 형식으로 변환
        numberFields.forEach(field => {
            field.value = field.value.replace(/,/g, ""); // ',' 제거
        });
    });
</script>
</body>
</html>
