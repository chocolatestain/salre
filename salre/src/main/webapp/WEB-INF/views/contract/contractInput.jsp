<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../fix/header.jsp" %>
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
                    <label for="deposit_INT">보증금:</label>
                    <input type="text" id="deposit_INT" name="deposit_INT" required value="200000">
                </div>
                <div class="form-group">
                    <label for="contractAmount">계약금:</label>
                    <input type="text" id="contractAmount" name="contractAmount" required  value="200000">
                </div>
                <div class="form-group">
                    <label for="middle_payment">1차 중도금:</label>
                    <input type="text" id="middle_payment" name="middle_payment"  value="200000">
                </div>
                <div class="form-group2">
                    <label for="balance_payment">잔금:</label>
                    금 <input type="text" id="balance_payment" name="balance_payment"  value="200000"> 원정은<input type="text" id="balance_payment_day" name="balance_payment_day">에 지불한다.
                </div>
                <div class="form-group">
                    <label for="enter_day">임대차 기간:</label>
                    <input type="date" id="enter_day" name="enter_day" required value="2024-05-01">
                    ~
                    <input type="date" id="contract_date" name="contract_date" required  value="2025-08-02">
               </div>
                <div class="form-group">
                    <label for="contract_date">계약일:</label>
                    <input type="date" id="contract_date" name="contract_date" required  value="2024-12-31">
                </div>
            </section>

            <!-- 특약사항 -->
            <section class="section">
                <h2>특약사항</h2>
                <div class="form-group">
                    <label for="contract_rule1">특약사항:</label>
                    <textarea id="contract_rule1" name="contract_rule1" rows="10" placeholder="특약사항 입력"  value="1. 잘되게 해주세요 
                    2. 돈떼먹지 마세요"></textarea>
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
