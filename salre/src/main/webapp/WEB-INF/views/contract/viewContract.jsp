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
    <form id="contractInput" action="${path}/contract/saveSignature">
        <c:if test="${not empty contract.contract_imgpath}">
            <img src="${path}${contract.contract_imgpath}" alt="계약서 이미지" style="width: 70%; height: 80%;">
        </c:if>
        <c:if test="${not empty errorMessage}">
            <p style="color: red;">${errorMessage}</p>
        </c:if>
        <!-- 서명 영역 -->
        <section class="section">
            <h2>서명하기</h2>
            <canvas id="signatureCanvas" width="200" height="130" style="border: 1px solid #000;"></canvas>
            <div class="button-group">
                <button type="button" class="btn btn-secondary" onclick="clearSignature()">지우기</button>
                <button type="button" class="btn btn-primary" onclick="saveAndCompleteSignature()">서명 완료</button>
            </div>
        </section>
    </form>
    <script>
        const canvas = document.getElementById('signatureCanvas');
        const ctx = canvas.getContext('2d');
        let drawing = false;

        // 서명 시작
        canvas.addEventListener('mousedown', () => {
            drawing = true;
            ctx.beginPath();
        });

        // 서명 중
        canvas.addEventListener('mousemove', (event) => {
            if (!drawing) return;
            ctx.lineTo(event.offsetX, event.offsetY);
            ctx.stroke();
        });

        // 서명 종료
        canvas.addEventListener('mouseup', () => {
            drawing = false;
        });

        // 서명 지우기
        function clearSignature() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
        }

        // 서명 저장 및 완료
        function saveAndCompleteSignature() {
            const signatureData = canvas.toDataURL('image/png'); // 서명 데이터를 Base64로 변환

            fetch("${path}/contract/landlord-sign/${contract.contract_id}", {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ signature: signatureData })
            })
            .then(response => response.json())
            .then(data => {
                if (data.imagePath) {
                    alert('서명이 성공적으로 저장되었습니다.');
                    window.location.href = "${path}/contract/viewSignContract/${contract.contract_id}"; // 서명 후 계약서 보기 페이지로 이동
                } else {
                    alert('서명 저장에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error saving signature:', error);
                alert('서명을 저장하는 중 오류가 발생했습니다.');
            });
        }
    </script>
</body>
</html>