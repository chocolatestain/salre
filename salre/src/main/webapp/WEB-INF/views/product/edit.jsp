<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>매물 수정</title>
</head>
<body>
<h1>매물 수정</h1>
<form action="${pageContext.request.contextPath}/product/edit/${productDTO.product_id}" method="post">
    <input type="hidden" name="product_id" value="${productDTO.product_id}" />

    <label for="product_name">이름 :</label>
    <input type="text" name="product_name" id="product_name" value="${productDTO.product_name}" required/><br/><br/>

    <label for="payment_type">전/월세 :</label>
    <input type="text" name="payment_type" id="payment_type" value="${productDTO.payment_type}" required/><br/><br/>

    <label for="rentfee">월세 :</label>
    <input type="number" name="rentfee" id="rentfee" value="${productDTO.rentfee}" required/><br/><br/>

    <label for="deposit">보증금 :</label>
    <input type="number" name="deposit" id="deposit" value="${productDTO.deposit}" required/><br/><br/>

    <label for="area">지역 :</label>
    <input type="number" step="0.01" name="area" id="area" value="${productDTO.area}" required/><br/><br/>

    <!-- 추가된 필드 -->
    <label for="product_status">매물 상태 :</label>
    <input type="number" name="product_status" id="product_status" value="${productDTO.product_status}" required/><br/><br/>

    <label for="view_count">조회수 :</label>
    <input type="number" name="view_count" id="view_count" value="${productDTO.view_count}" readonly/><br/><br/>

    <label for="address">주소 :</label>
    <input type="text" name="address" id="address" value="${productDTO.address}" required/><br/><br/>

    <label for="address_detail">상세 주소 :</label>
    <input type="text" name="address_detail" id="address_detail" value="${productDTO.address_detail}"/><br/><br/>

    <label for="product_type">매물 유형 :</label>
    <input type="text" name="product_type" id="product_type" value="${productDTO.product_type}" required/><br/><br/>

    <label for="floor">층수 :</label>
    <input type="number" name="floor" id="floor" value="${productDTO.floor}" required/><br/><br/>

    <label for="enter_day">입주 가능일 :</label>
    <input type="date" name="enter_day" id="enter_day" value="${productDTO.enter_day}" required/><br/><br/>

    <label for="room_count">방 개수 :</label>
    <input type="number" name="room_count" id="room_count" value="${productDTO.room_count}" required/><br/><br/>

    <label for="bath_count">화장실 개수 :</label>
    <input type="number" name="bath_count" id="bath_count" value="${productDTO.bath_count}" required/><br/><br/>

    <label for="approve_day">승인일 :</label>
    <input type="date" name="approve_day" id="approve_day" value="${productDTO.approve_day}"/><br/><br/>

    <label for="park_count">주차 가능 대수 :</label>
    <input type="number" name="park_count" id="park_count" value="${productDTO.park_count}"/><br/><br/>

    <label for="manage_fee">관리비 :</label>
    <input type="number" name="manage_fee" id="manage_fee" value="${productDTO.manage_fee}"/><br/><br/>

    <label for="direction">방향 :</label>
    <input type="text" name="direction" id="direction" value="${productDTO.direction}"/><br/><br/>

    <input type="submit" value="Update Product"/>
</form>
</body>
</html>
