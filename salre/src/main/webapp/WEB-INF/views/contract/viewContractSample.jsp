<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>


<title>계약서</title>


</head>
<body>
	<h2>계약서 보기</h2>
	<c:if test="${not empty imagePath}">
		<img src="${path}${imagePath}" alt="계약서 이미지" style="width: 100%; height: 80%;">
	</c:if>
	<c:if test="${not empty errorMessage}">
		<p style="color: red;">${errorMessage}</p>
	</c:if>
	<form action="${path}/contract/nextStep" method="post">
        <input type="hidden" name="contract_id" value="${contract_id}">
	<div class="button-group">
		<button type="button" class="btn btn-secondary"onclick="closeWindow()">닫기</button>
		<button type="button" class="btn btn-primary" onclick="goToSeller()">판매자에게 보내기</button>
		  <a href="${path}/resources/pdf/contract_sample_${contract_id}.pdf" class="btn btn-primary" download>PDF 다운로드</a>
	</div>
	</form>
	
	<script>
	// 판매자에게 보내기
	function goToSeller() {
	window.location.href =	"${path}/contract/dealcheck/${contract.contract_id}";
	}
	 // 창 닫기
    function closeWindow() {
        window.close();
    }
	</script>
	</body>
</html>