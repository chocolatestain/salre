<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
	<title>판매자정보</title>
	<style>
/* 테이블 스타일 */
.table {
    width: 100%;
    margin-bottom: 1rem;
    background-color: #fff;
    border-collapse: collapse;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.table th, .table td {
    padding: 15px;
    text-align: left;
    border: 1px solid #dee2e6;
}

.table thead th {
    background-color: #007bff;
    color: white;
    text-transform: uppercase;
    font-weight: bold;
}

.table tbody tr:nth-child(odd) {
    background-color: #f2f2f2;
}
</style>
</head>
<body>
<h1>
	판매자정보
</h1>
<form id="testForm" action="/user/makePaper.do" method="post">
		<div class="container">
			<div class="row border-bottom mb-3">
				<div class="col-12">
					<p class="h1"></p>
					<table class="table" >
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
				</div>
			</div>

</body>
</html>
