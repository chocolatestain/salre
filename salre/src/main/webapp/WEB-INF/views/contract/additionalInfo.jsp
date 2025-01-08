<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>추가 정보 입력</title>
<link rel="stylesheet" href="${path}/resources/css/style2.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <h1 class="title">추가 정보 입력</h1>
        <form action="${path}/contract/saveAdditionalInfo" method="post">
            <input type="hidden" name="contract_id" value="${contract.contract_id}" />
            <div class="form-group">
                <label for="account">계좌번호:</label>
                <input type="text" id="account" name="account" required value = "673002-01-000000">
            </div>
            <div class="form-group">
                <label for="account_name">예금주:</label>
                <input type="text" id="account_name" name="account_name" required value = "임대인">
            </div>
            <div class="form-group">
                <label for="bank_name">은행명:</label>
                <input type="text" id="bank_name" name="bank_name" required value="국민은행">
            </div>
            <section class="section">
				<!-- 증빙 서류 등록 -->
				<h2>증빙 서류 등록</h2>
				<div class="form-group">
					<label for="photo">신분증 사본 *</label> <input type="file" id="photo"
						name="identificationCard" accept="image/*">
				</div>
				<div class="form-group">
					<label for="photo">통장 사본 *</label> <input type="file" id="photo"
						name="bankAccount" accept="image/*" >
				</div>
			</section>
            <div class="button-group">
                <button type="submit" class="btn btn-primary">완료</button>
            </div>
        </form>
    </div>
</body>
</html>