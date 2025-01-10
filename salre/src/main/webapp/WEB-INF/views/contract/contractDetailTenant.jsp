<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>계약서 조회</title>
<link rel="stylesheet" href="${path}/resources/css/style2.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
 <div class="container">
        <h1 class="title">부동산 정보확인</h1>
        <!-- 계약 정보 -->
        <section class="section">
 
            <div class="form-group">
                <label>회원번호:</label>
                <span>${P_user.id}</span>
            </div>
            <div class="form-group">
                <label>매물번호:</label>
                <span>${product.product_id}</span>
            </div>        
        </section>

        <!-- 회원 정보 -->
        <section class="section">
            <h2>판매자 정보</h2>
            <div class="form-group">
                <label>아이디:</label>
                <span>${P_user.user_id}</span>
            </div>
            <div class="form-group">
                <label>이름:</label>
                <span>${P_user.user_name}</span>
            </div>
            <div class="form-group">
                <label>전화번호:</label>
                <span>${P_user.phone_num}</span>
            </div>
            <div class="form-group">
                <label>이메일:</label>
                <span>${P_user.email}</span>
            </div>
        </section>

        <!-- 매물 정보 -->
        <section class="section">
            <h2>매물 정보</h2>
            <div class="form-group">
                <label>매물번호:</label>
                <span>${product.product_id}</span>
            </div>
            <div class="form-group">
                <label>매물명:</label>
                <span>${product.product_name}</span>
            </div>
            <div class="form-group">
                <label>주소:</label>
                <span>${product.address}
                ${product.address_detail}
            </span>
            </div>
            <!-- 거래유형 출력 조건 -->
            <c:choose>
            <c:when test ="${product.payment_type=='전세'}">
            <div class="form-group">
                <label>거래유형:</label>
                <span>${product.payment_type}</span>
            </div>
            <div class="form-group">
                <label>보증금:</label>
                <span>${product.deposit}</span>
            </div>
            </c:when> 
            <c:when test = "${product.payment_type=='월세'}">
            <div class="form-group">
                <label>거래유형:</label>
                <span>${product.payment_type}</span>
            </div>
            <div class="form-group">
                <label>월세:</label>
                <span>${product.rentfee}</span>
            </div>
            <div class="form-group">
                <label>보증금:</label>
                <span>${product.deposit} 원</span>
            </div>
            </c:when>
     </c:choose>
            <div class="form-group">
                <label>면적:</label>
                <span>${product.area} ㎡</span>
            </div>
        </section>

        <!-- 특약사항 입력 -->
        <section class="section">
            <h2>매물 사진</h2>
            <div class="form-group">
                <label for="image"> </label>
               </div>
            
            
            <div id="imagePreviewContainer" class="image-preview-container">
        <!-- 이미지 미리보기 영역 -->
    </div>
        </section>

        <!-- 제출 버튼 -->
        <div class="button-group">
        	
        	<form action="${path}/contract/inputContract" method = "post">
        	<button type="button" class="btn btn-secondary">취소</button>
        	   <input type="submit" class="btn btn-primary"  value="다음" />
        	   <input type="hidden" name="product_id" value="${product.product_id}">
        	   <input type="hidden" name="user_id" value="${P_user.user_id}">
        	</form>
            
            
        </div>
    </div>
 
</body>
</html>
