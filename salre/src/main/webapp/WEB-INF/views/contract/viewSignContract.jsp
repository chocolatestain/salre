<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<title>계약서</title>
	<link rel="stylesheet" href="${path}/resources/css/contract.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="container">
		<h1 class="title">계약서 작성이 완료되었습니다.</h1>
		<h2>송금정보를 확인후 지정된 입금일자까지 송금을 완료해주세요</h2>
		<!-- 임차인 서명 확인 -->
		<!-- 계약서 이미지 -->
		<c:if test="${not empty contract.contract_imgpath}">
			<div class="contract-image-container">
					<img src="${path}${contract.contract_imgpath}" alt="계약서 이미지"
						class="contract-image" onclick="openModal(this.src)">
				</div>
				<div id="imageModal" class="image-modal" onclick="closeModal()">
					<span class="close">&times;</span> <img id="modalImage"
						class="modal-content">
				</div>
		</c:if>
		
		<!-- 에러 메시지 -->
		<c:if test="${not empty errorMessage}">
			<p class="error-message">${errorMessage}</p>
		</c:if>

		<!-- 서명 요청 버튼 -->
		<section class="section">
			<div class="button-group">
				<button type="button" class="btn btn-primary" onclick="accountInfo()">송금 정보 확인</button>
				<button type="button" class="btn btn-secondary" onclick="closeWindow()">닫기</button>
			</div>
		</section>
	</div>

	<script>
		
		// 창 닫기
		function closeWindow() {
			 window.location.href = "${path}/transactions";
		}
		//모달 
		  function openModal(imageSrc) {
	            const modal = document.getElementById('imageModal');
	            const modalImage = document.getElementById('modalImage');

	            modal.style.display = "flex"; // 모달 창 표시
	            modalImage.src = imageSrc; // 클릭한 이미지 경로 설정
	        }

	        function closeModal() {
	            const modal = document.getElementById('imageModal');
	            modal.style.display = "none"; // 모달 창 숨김
	        }
	</script>
</body>
</html>
