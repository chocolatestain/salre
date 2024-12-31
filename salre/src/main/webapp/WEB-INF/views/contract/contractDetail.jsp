<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>


<title>계약서 조회</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/table1.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		console.log(${pageContext.request.contextPath})
		$("#testForm").submit(function(event) {
			event.preventDefault(); // 기본 제출 동작 방지
			var url = $(this).attr("action");
			var data = $(this).serialize();

			$.post(url, data).done(function(response) {
				alert("제출 성공: " + response);
			}).fail(function(error) {
				alert("제출 실패!");
				console.error(error);
			});
		});
	});
	
</script>
</head>
<body>
	<form id="checkForm"
		action="${pageContext.request.contextPath}/contract/submitContract"
		method="post">
		<h1>계약 조회</h1>
		<!-- 계약 정보 테이블 -->
		<table class="table">
			<thead>
				<tr>
					<th>계약번호</th>
					<th>회원번호</th>
					<th>매물번호</th>
					<th>거래금액</th>
					<th>계좌번호</th>
					<th>거래상태</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${contractP.contract_id}</td>
					<td>${contractP.user_id}</td>
					<td>${contractP.product_id}</td>
					<td>${contractP.price}</td>
					<td>${contractP.account}</td>
					<td>${contractP.contract_status}</td>
				</tr>
			</tbody>
		</table>

		<h2>회원 정보</h2>
		<!-- 회원 정보 테이블 -->
		<table class="table">
			<thead>
				<tr>
					<th>회원번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>이메일</th>
					<th>판매자인증여부</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${user.user_id}</td>
					<td>${user.id}</td>
					<td>${user.user_name}</td>
					<td>${user.phone_num}</td>
					<td>${user.email}</td>
					<td>${user.auth_seller}</td>
				</tr>
			</tbody>
		</table>
		<h2>매물 정보</h2>
		<!-- 매물 정보 테이블 -->
		<table class="table">
			<thead>
				<tr>
					<th>이름</th>
					<th>전/월세</th>
					<th>월세</th>
					<th>보증금</th>
					<th>지역</th>
					<th>액션</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${contractP.product_name}</td>
					<td>${contractP.payment_type}</td>
					<td>${contractP.rentfee}</td>
					<td>${contractP.deposit}</td>
					<td>${contractP.area}</td>
				</tr>
			</tbody>
		</table>

		<h2>특약사항 입력</h2>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text">특약사항</span>
			</div>
			<input type="text" name="contract_rule" class="form-control" required>
		</div>

		<div>
			<button type="submit" class="btn btn-primary">다음</button>
		</div>
	</form>
</body>
</html>