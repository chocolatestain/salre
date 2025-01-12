<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<title>송금 확인</title>
	<link rel="stylesheet" href="${path}/resources/css/style2.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="container">
		<h1 class="title">송금내역을 확인 바랍니다.</h1>
	  <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>
        <c:if test="${not empty contract}">
      <section class="section">
          <div class="form-group">
           <label>은행명:</label><span>${contract.bank_name}</span> 
            </div>
          <div class="form-group">
           <label>은행명:</label><span>${contract.account}</span> 
            </div>
          <div class="form-group">
           <label>은행명:</label><span>${contract.account_name}</span> 
            </div>
          <div class="form-group">
           <label>송금액:</label><span><fmt:formatNumber value="${contract.price}" type="number" groupingUsed="true"/>원</span> 
            </div>
          <div class="form-group">
           <label>송금 시간:</label><span>2025-01-13 13:53</span> 
            </div>
        </section>
        </c:if>
  <div class="button-group">
		<button type="button" class="btn btn-primary" onclick="successPayment(${contract.contract_id})">송금확인</button>
   		 <button type="button" class="btn btn-secondary" onclick="closeWindow()">닫기</button>
  </div>
</div>
	<script>
		//송금완료 시 계약 상태값 변경
		function successPayment(contractId) {
			console.log(${contract.contract_id});
			//계약상태값 6-판매자 송금확인
			const contractStatus = 6;
			$.ajax({
				type:"POST",
				url:"${path}/contract/updateStatus",
				contentType: "application/json",
				data: JSON.stringify({
					contract_id : contractId,
					contract_status : contractStatus
				}),
			success: function () {
				alert("송금 확인이 완료되었습니다.")
				console.log("상태 업데이트 성공");
			},
			error: function() {
				console.error("상태 업데이트 오류");
			}
			});
		}
		// 창 닫기
		function closeWindow() {
			 window.location.href = "${path}/transactions";
		}	
	</script>
</body>
</html>
