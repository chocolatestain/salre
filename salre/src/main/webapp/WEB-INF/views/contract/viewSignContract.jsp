<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<!-- 송금 정보 모달 -->
<div id="paymentInfoModal" class="payment-modal">
    <div class="payment-modal-content">
        <span class="payment-close" onclick="closePaymentModal()">&times;</span>
        <h2>송금 정보</h2>
        <p>계좌번호: ${contract.account}</p>
        <p>예금주: ${contract.account_name}</p>
        <p>은행명: ${contract.bank_name}</p>
        <p>계약금: <fmt:formatNumber value="${contract.price}" type="number" groupingUsed="true"/>원</p>
       
        <button type="button" class="btn btn-primary" onclick="successPayment(${contract.contract_id})">송금완료</button>
   		 <button type="button" class="btn btn-secondary" onclick="closePaymentModal()">닫기</button>
    </div>
</div>


	<script>
	function successPayment(contractId) {
	    // 계약 상태값 5 - 구매자 송금 완료
	    const contractStatus = 5;

	    $.ajax({
	        type: "POST",
	        url: "${path}/contract/updateStatus",
	        contentType: "application/json",
	        data: JSON.stringify({
	            contract_id: contractId,
	            contract_status: contractStatus
	        }),
	        success: function () {
	            console.log("상태 업데이트 성공");

	            // 상태 업데이트 성공 시 송금 확인 요청 실행
	            checkPaymentToLandlord();
	        },
	        error: function () {
	            console.error("상태 업데이트 오류");
	        }
	    });
	}
	// 임대인에게 송금 확인 요청 보내기
	function checkPaymentToLandlord() {
		// 알림 보내기
		const user_id = "${product.user_id}";
		// 송금완료 누른 날짜
		 const notify_time = new Date().toISOString().split("T")[0]; // YYYY-MM-DD 형식
		// 알림 내용 입력
		const notify_content = `임차인이 송금을 완료 했어요.<br>${contract.bank_name}은행의 ${contract.account}계좌를 
		확인해주세요.<br> 보내신 금액은 ${contract.price}원 입니다.<br> 송금일: \${notify_time}`;
		console.log(notify_content);
		// 알림 클릭 시 이동할 URL
		const notify_url = "${path}/contract/payCheck/${contract.contract_id}";
		
		$.ajax({
			type : "POST",
			url : "${path}/notify/send",
			contentType : "application/json",
			data : JSON.stringify({
				user_id : user_id,
				notify_content : notify_content,
				notify_url : notify_url,
				notify_time : notify_time
			}),
			success : function() {
				alert("송금 확인 요청 알림이 성공적으로 전송되었습니다.");
				console.log("알림 전송 성공");
			},
			error : function() {
				alert("송금 확인 요청 알림 전송에 실패했습니다.");
				console.error("알림 전송 오류");
			}
		});
	};	
		
		// 창 닫기
		function closeWindow() {
			 window.location.href = "${path}/transactions";
		}
		
		//계약서 이미지 모달 
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
	        
	     // 송금 정보
	     //모달 열기
	        function accountInfo() {
	            const paymentModal = document.getElementById('paymentInfoModal');
	            paymentModal.style.display = "flex";
	        }

	        // 송금 정보 모달 닫기
	        function closePaymentModal() {
	            const paymentModal = document.getElementById('paymentInfoModal');
	            paymentModal.style.display = "none";
	        }
	</script>
</body>
</html>
