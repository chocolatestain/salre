<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../fix/header.jsp" %>
<!DOCTYPE html>
<html>
<head>

<title>계약 입력</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/contractInput.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
    <div class="container">
        <h1 class="title">부동산 (주거용) 임대차 계약 입력</h1>
<%--         <form id="contractInput" action="${pageContext.request.contextPath}/contract/viewContract/${contract.contract_id}" method="post">
 --%>        <form id="contractInput" action="${pageContext.request.contextPath}/contract/save" method="post">
            <!-- 계약 내용 -->
            <section class="section">
                <h2>계약 내용</h2>
                <div class="form-group">
                    <label for="account">계좌번호:</label>
                    <input type="text" id="account" name="account" required value="673002-01-199754">
                </div>
                <div class="form-group">
                    <label for="deposit_INT">보증금:</label>
                    <input type="text" id="deposit" name="deposit_INT" required value="200000">
                </div>
                <div class="form-group">
                    <label for="price">계약금:</label>
                    <input type="text" id="price" name="price" required  value="200000">
                </div>
                <div class="form-group">
                    <label for="middle_payment">1차 중도금:</label>
                    <input type="text" id="middle_payment" name="middle_payment"  value="200000">
                </div>
                <div class="form-group2">
                    <label for="balance_payment">잔금:</label>
                    금 <input type="text" id="balance_payment" name="balance_payment"  value="200000"> 원정은
                    <input type="date" id="balance_payment_day" name="balance_payment_day">에 지불한다.
                </div>
                <div class="form-group">
                    <label for="contract_startdate">임대차 기간:</label>
                    <input type="date" id="contract_startdate" name="contract_startdate" required value="2024-05-01">
                    ~
                    <input type="date" id="contract_enddate" name="contract_enddate" required  value="2025-08-02" >
               </div>
                <div class="form-group">
                    <label for="contract_date">계약일:</label>
                    <input type="date" id="contract_date" name="contract_date" required  value="2025-01-02" >
                	<input type="number" id = "contract_status" name = "contract_status" hidden ="hidden" value = "2">
                </div>
            </section>

            <!-- 특약사항 -->
            <section class="section">
                <h2>특약사항</h2>
                <div class="form-group">
        <label for="contract_rule">특약사항:</label>
        <textarea id="contract_rule" name="contract_rule" rows="10" cols="50">${contract.contract_rule}</textarea>
    </div>
            </section>

            <!-- 제출 버튼 -->
            <div class="button-group">
                <button type="submit" class="btn btn-secondary">임시저장</button>
                <button type="submit" class="btn btn-primary">계약 저장</button>
            </div>
        </form>
    </div>
</body>
</html>
