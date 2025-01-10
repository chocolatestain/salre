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
	<!-- 분기해서 임대이면 아래내용 -->


	<h2>(임대인)서명 확인</h2>
	<c:if test="${not empty contract.contract_imgpath}">
		<img src="${path}${contract.contract_imgpath}" alt="계약서 이미지"
			style="width: 70%; height: 80%;">
	</c:if>
	<c:if test="${not empty errorMessage}">
		<p style="color: red;">${errorMessage}</p>
	</c:if>
	<!-- 서명 영역 -->
	<section class="section">
		<div class="button-group">
			<button type="button" class="btn btn-primary"	onclick="goToTenantSignature()">서명요청</button>
			<button type="button" class="btn btn-basic" onclick="closeWindow()">닫기</button>
		</div>
	</section>

	<script>
		// 판매자에게 보내기
		function goToTenantSignature() {
			// 알림 보내기
			const user_id = 16; //임차인
			// 알림 내용 입력
			const notify_content = `임대인이 서명을 완료했어요.<br>서명을 완료해주세요.`;
			// 알림 클릭 시 이동할 URL
			const notify_url = "${pageContext.request.contextPath}/contract/signTenantContract/${contract.contract_id}";
			
			console.log(notify_url);

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