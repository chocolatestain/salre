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
<!-- 분기해서 임대이면 아래내용 -->


    <h2>(임대인)서명 확인</h2>
        <c:if test="${not empty contract.contract_imgpath}">
            <img src="${path}${contract.contract_imgpath}" alt="계약서 이미지" style="width: 70%; height: 80%;">
        </c:if>
        <c:if test="${not empty errorMessage}">
            <p style="color: red;">${errorMessage}</p>
        </c:if>
        <!-- 서명 영역 -->
        <section class="section">
            <div class="button-group">
                <button type="button" class="btn btn-primary" onclick="goToTenantSignature()">임차인 서명</button>
            </div>
        </section>
        <script>
        // 판매자에게 보내기
	function goToTenantSignature() {
	window.location.href =	"${path}/contract/tenant-sign/${contract.contract_id}";
	}
	</script>
	
	
	<%-- <h2>(임차인)서명 확인</h2>
        <c:if test="${not empty contract.contract_imgpath}">
            <img src="${path}${contract.contract_imgpath}" alt="계약서 이미지" style="width: 70%; height: 80%;">
        </c:if>
        <c:if test="${not empty errorMessage}">
            <p style="color: red;">${errorMessage}</p>
        </c:if>
        <!-- 서명 영역 -->
        <section class="section">
            <div class="button-group">
                <button type="button" class="btn btn-primary" onclick="goToTenantSignature()">임차인 서명</button>
            </div>
        </section>
        <script>
        // 판매자에게 보내기
	function goToTenantSignature() {
	window.location.href =	"${path}/contract/tenant-sign/${contract.contract_id}";
	}
	</script> --%>
</body>
</html>