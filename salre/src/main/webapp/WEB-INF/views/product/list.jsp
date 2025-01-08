<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>매물 목록</title>
</head>
<body>
<h1>매물 목록</h1>
<table border="1">
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
        <c:forEach var="product" items="${products}">
            <tr>
                <td>${product.product_name}</td>
                <td>${product.payment_type}</td>
                <td>${product.rentfee}</td>
                <td>${product.deposit}</td>
                <td>${product.area}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/product/edit/${product.product_id}">Edit</a> |
                    <a href="${pageContext.request.contextPath}/product/delete/${product.product_id}" onclick="return confirm('정말 삭제하시겠습니까?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<br/>
<a href="${pageContext.request.contextPath}/product/insert">매물 등록</a>
</body>
</html>
