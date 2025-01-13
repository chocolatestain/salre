<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/header.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>

<title>살래?</title>

<link rel="stylesheet" href="${path}/resources/css/contractInput.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
	<div class="container">
		<h1 class="title">계약사항 추가 입력</h1>
		<form id="contractInput" action="${path}/contract/save" method="post">
			<!-- 계약 내용 -->

			<section class="section">
				<h2>계약 내용</h2>

				<div class="form-group">
					<label for="price">계약금 *</label>
					<div class="input-group">
						<input type="text" id="price" name="price" required
							oninput="formatNumber(this)" /> <span class="unit">원</span>
					</div>
				</div>

				<div class="form-group2">
					<label for="middle_payment">중도금:</label>
					<div class="input-group">
						<input type="text" id="middle_payment" name="middle_payment"
							oninput="formatNumber(this)" /> <span class="unit">원</span>
					</div>
					<label for="middle_payment_day">지급일:</label> <input type="date"
						id="middle_payment_day" name="middle_payment_day">
				</div>

				<div class="form-group2">
					<label for="balance_payment">잔금:</label>
					<div class="input-group">
						<input type="text" id="balance_payment" name="balance_payment"
							oninput="formatNumber(this)" /> <span class="unit">원</span>
					</div>
					<label for="balance_payment_day">지급일:</label> <input type="date"
						id="balance_payment_day" name="balance_payment_day">
				</div>

				<c:choose>
					<c:when test="${product.payment_type=='월세'}">
						<div class="form-group2">
							<label for="rent_fee_day">월세 입금일 *</label> <input type="number"
								id="rent_fee_day" name="rent_fee_day" min="1" max="9"
								placeholder="매달 0일"><br>
						</div>
					</c:when>
				</c:choose>

				<div class="form-group">
					<label for="contract_startdate">임대차 기간 *</label> <input type="date"
						id="contract_startdate" name="contract_startdate" required
						> ~ <input type="date"
						id="contract_enddate" name="contract_enddate" required
						>
				</div>
				<div class="form-group">
					<label for="contract_date">계약일 *</label>
					 <input type="date"	id="contract_date" name="contract_date" required>
				</div>
			</section>

			<!-- 특약사항 -->
			<section class="section2">
				<div style="display: flex; justify-content: space-between; align-items: center;">
					<h2 style="margin: 0;">특약사항</h2>
					<div style="display: flex; align-items: center; gap: 10px;">
					 <p style="display: flex; align-items:center; gap:10px;">자주쓰는 특약사항</p>
					<button id="fab-btn" class="fab" type="button" title="자주 쓰는 특약사항">
						💡</button>
						
				</div>
				</div>
				</section>
				<section>
				<div class="special-terms" style="margin-top: 15px;">
					<textarea id="contract_rule" name="contract_rule" rows="10"
						cols="50" placeholder="특약사항을 작성하세요..." style="width: 100%;"></textarea>
				</div>

	<div id="terms-container" style="display: none; margin-top: 10px;">
		<select id="terms-select"
			style="margin-left: 10px; padding: 5px; width: 100%;">
			<option value="">선택하세요...</option>
			<option value="- 임대차 계약 만료일에 새 임차인 여부와 상관없이 보증금을 즉시 반환한다.">임대차
				계약 만료일에 새 임차인 여부와 상관없이 보증금을 즉시 반환한다.</option>
			<option value="- 전세보증금 반환보증 가입을 조건으로 한다.">전세보증금 반환보증 가입을 조건으로
				한다.</option>
			<option value="- 임차인이 주택에 입주할 때까지 저당권 등 권리 설정을 하지 않는다">임차인이
				주택에 입주할 때까지 저당권 등 권리 설정을 하지 않는다</option>
			<option value="- 잔금 지급일 익일까지 현재의 등기부등본을 유지한다.">잔금 지급일 익일까지 현재의
				등기부등본을 유지한다.</option>
			<option
				value="- 계약 만료 후 임대차 연장이 불가할 경우, 임대인은 최소 3개월 전에 계약 종료 의사를 통보한다..">계약
				만료 후 임대차 연장이 불가할 경우, 임대인은 최소 3개월 전에 계약 종료 의사를 통보한다.</option>
		</select>
	</div>
	</section>


	<section class="section">
		<!-- 증빙 서류 등록 -->
		<h2>증빙 서류 등록</h2>
		<div class="form-group">
			<label for="photo">신분증 사본 *</label> <input type="file" id="photo"
				name="identificationCard" accept="image/*" required>
		</div>
		<div class="form-group">
			<label for="photo">통장 사본 *</label> <input type="file" id="photo"
				name="bankAccount" accept="image/*" required>
		</div>
	</section>
	<!-- 제출 버튼 -->
	<div class="button-group">
		<button type="submit" class="btn btn-primary">계약사항 등록</button>
	</div>
	<input type="hidden" name="product_id" value="${product.product_id}">
	<input type="hidden" name="user_id" value="${user.user_id}">
	<input type="hidden" name="account" value="0000-0000-00000">
	</form>
	</div>
	<script>
	document.getElementById('fab-btn').addEventListener('click', (event) => {
	    event.preventDefault(); // 버튼의 기본 동작(폼 제출)을 막음
	    const termsContainer = document.getElementById('terms-container');
	    termsContainer.style.display = termsContainer.style.display === 'none' ? 'block' : 'none';
	});

// 콤보박스에서 선택한 항목을 특약사항에 추가
document.getElementById('terms-select').addEventListener('change', (event) => {
    const selectedTerm = event.target.value;
    const textArea = document.getElementById('contract_rule');
    if (selectedTerm) {
        // 중복 추가 방지
        if (!textArea.value.includes(selectedTerm)) {
            textArea.value += (textArea.value ? '\n' : '') + selectedTerm;
        }
    }
    // 선택 초기화
    event.target.value = "";
});
    function formatNumber(input) {
        // 입력된 값을 숫자로 변환 (숫자 외 문자 제거)
        const value = input.value.replace(/,/g, "");
        if(value ===""){
        	input.value ="";
        	return;
        }
        // 천 단위로 ',' 추가
        const formattedValue = new Intl.NumberFormat().format(value);

        // 포맷팅된 값을 다시 입력 필드에 반영
        input.value = formattedValue;
    }
    // 폼 제출 시 값을 숫자로 변환
    document.getElementById('contractInput').addEventListener('submit', function (event) {
        // 모든 숫자 입력 필드를 선택
        const numberFields = document.querySelectorAll('input[type="text"][oninput="formatNumber(this)"]');

        // 각 필드의 값을 숫자 형식으로 변환
        numberFields.forEach(field => {
            field.value = field.value.replace(/,/g, ""); // ',' 제거
        });
    });
    

    // 요소 가져오기
    const startDateInput = document.getElementById("contract_startdate");
    const endDateInput = document.getElementById("contract_enddate");
    const contractDateInput = document.getElementById("contract_date");
	
    // 날짜 검증 함수
    function validateDates() {
        const startDate = new Date(startDateInput.value);
        const endDate = new Date(endDateInput.value);
        const contractDate = new Date(contractDateInput.value);

        // 종료일은 시작일보다 이후여야 함
        if (endDate <= startDate) {
            alert("종료일은 시작일 이후여야 합니다.");
            endDateInput.value = ""; // 종료일 초기화
        }

        // 계약일은 시작일과 같거나 그 이전이어야 함
        if (contractDate > startDate) {
            alert("계약일은 임대차 시작일과 같거나 그 이전이어야 합니다.");
            contractDateInput.value = ""; // 계약일 초기화
        }
    }

    // 이벤트 리스너 추가
    startDateInput.addEventListener("change", validateDates);
    endDateInput.addEventListener("change", validateDates);
    contractDateInput.addEventListener("change", validateDates);
</script>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
