<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style2.css">
<title>계약서 최종확인</title>
</head>
<body>
<div class="container">
<h1 class="title">계약서 최종확인</h1>
<form id="contractInput" action="${pageContext.request.contextPath}/contract/viewContract/${contract.contract_id}" method="post">
 <!-- 회원 정보 -->
 <section class="section">
    <h2>판매자 정보</h2>
    <div class="form-group">
        <label>아이디:</label>
        <span>${user.id}</span>
    </div>
    <div class="form-group">
        <label>이름:</label>
        <span>${user.user_name}</span>
    </div>
    <div class="form-group">
        <label>전화번호:</label>
        <span>${user.phone_num}</span>
    </div>
    <div class="form-group">
        <label>이메일:</label>
        <span>${user.email}</span>
    </div>
    <div class="form-group">
        <label>판매자인증여부:</label>
        <span>${user.auth_seller}</span>
    </div>
 </section>

 <!-- 매물 정보 -->
 <section class="section">
    <h2>매물 정보</h2>
    <div class="form-group">
        <label>매물번호:</label>
        <span>${product.product_id}</span>
    </div>
    <div class="form-group">
        <label>매물명:</label>
        <span>${product.product_name}</span>
    </div>
    <div class="form-group">
        <label>주소:</label>
        <span>${product.address} ${product.address_detail}</span>
    </div>
    <c:choose>
        <c:when test="${product.payment_type == '전세'}">
            <div class="form-group">
                <label>거래유형:</label>
                <span>${product.payment_type}</span>
            </div>
            <div class="form-group">
                <label>보증금:</label>
                <span>${product.deposit}</span>
            </div>
        </c:when> 
        <c:when test="${product.payment_type == '월세'}">
            <div class="form-group">
                <label>거래유형:</label>
                <span>${product.payment_type}</span>
            </div>
            <div class="form-group">
                <label>월세:</label>
                <span>${product.rentfee}</span>
            </div>
            <div class="form-group">
                <label>보증금:</label>
                <span>${product.deposit} 원</span>
            </div>
        </c:when>
    </c:choose>
    <div class="form-group">
        <label>면적:</label>
        <span>${product.area} ㎡</span>
    </div>
 </section>

 <!-- 계약 내용 -->
 <section class="section">
    <h2>계약 내용</h2>
    <div class="form-group">
        <label>보증금:</label>
        <span>${product.deposit}</span>
    </div>
    <div class="form-group">
        <label>계약금:</label>
        <span>${contract.price}</span>
    </div>
    <div class="form-group">
        <label>1차 중도금:</label>
        <span>${contract.middle_payment}</span>
    </div>
    <div class="form-group2">
        <label>잔금:</label>
        <span>${contract.balance_payment}</span> 원정은 <span>${contract.balance_payment_day}</span>에 지불한다.
    </div>
    <div class="form-group">
        <label>임대차 기간:</label>
        <span>${product.enter_day}</span> ~ <span>${contract.contract_date}</span>
    </div>
    <div class="form-group">
        <label>계약일:</label>
        <span>${contract.contract_date}</span>
    </div>
 </section>

 <!-- 특약사항 -->
 <section class="section">
    <h2>특약사항</h2>
    <div class="contract-rule">
        <span>${contract.contract_rule}</span>
    </div>
 </section>
 <!-- 제출 버튼 -->
        <div class="button-group">
        	<button type="button" class="btn btn-secondary">취소</button>
            <button type="submit" class="btn btn-primary" onclick="makeContractPaper()">계약서 보기</button>
        </div>
</form>
</div>
<script>
    function makeContractPaper(){
    	const contextPath = "<%= request.getContextPath() %>"; // JSP에서 contextPath 추가
        window.location.href = `${contextPath}/salre/contract/viewContract/${contract.contract_id}`;
    }
   	window.makeContractPaper = makeContractPaper;
    </script> 
</body>
</html>
