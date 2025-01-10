<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>


<title>계약서</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
	<h2>계약서 보기</h2>
	<c:if test="${not empty imagePath}">
		<img src="${path}${imagePath}" alt="계약서 이미지"
			style="width: 100%; height: 80%;">
	</c:if>
	<c:if test="${not empty errorMessage}">
		<p style="color: red;">${errorMessage}</p>
	</c:if>
	<form action="${path}/contract/nextStep" method="post">
		<input type="hidden" name="contract_id" value="${contract_id}">
		<div class="button-group">
			<button type="button" class="btn btn-secondary"
				onclick="closeWindow()">닫기</button>
			<button type="button" class="btn btn-primary" onclick="goToSeller()">계약서
				확인 요청</button>
			<a href="${path}/resources/pdf/contract_sample_${contract_id}.pdf"
				class="btn btn-primary" download>PDF 다운로드</a>
		</div>
	</form>

	<script>
		// 계약서 확인 요청
		function goToSeller() {
			// 알림 보내기
			const user_id = "${product.user_id}";
			// 알림 내용 입력
			const notify_content = `계약 요청을 받았어요.<br>계약사항을 확인하고 서명을 해주세요.`;
			// 알림 클릭 시 이동할 URL
			const notify_url = "${pageContext.request.contextPath}/";

			$.ajax({
				type : "POST",
				url : `${pageContext.request.contextPath}/notify/send`,
				contentType : "application/json",
				data : JSON.stringify({
					user_id : user_id,
					notify_content : notify_content,
					notify_url : notify_url
				}),
				success : function() {
					console.log("알림 전송 성공");
				},
				error : function() {
					console.error("알림 전송 오류");
				}
			});
		};
		// 창 닫기
		function closeWindow() {
			window.close();
		}
	</script>
</body>
</html>