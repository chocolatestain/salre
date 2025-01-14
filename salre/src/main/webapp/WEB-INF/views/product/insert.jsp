<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>살래?</title>
    <!-- Favicon -->
	<link rel="shortcut icon" href="${contextPath}/resources/images/favicon.ico">
	    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=58380a7fb187c1a835fded7eee3e2c78&libraries=services"></script>
	    <!-- 외부 CSS -->
    <link rel="stylesheet" href="${contextPath}/resources/css/insert.css">
 
</head>
<body>
    <!-- 메인 배너 -->
    <section class="main-banner">
        <h1>매물 등록</h1>
        <p>
            주소를 다르게 입력한 경우 위치비교를 참고할 수 있으니 꼭 동일하게 입력 바랍니다.<br>
            * 표 처리된 항목은 반드시 입력해야 합니다.
        </p>
    </section>

    <!-- 매물 정보 -->
  	<section class="form-section">
        <h2>매물 정보</h2>
        <form action="/salre/product/insert.do" method="post" enctype="multipart/form-data" onsubmit="return handleSubmit();">
            <div class="form-group">
                <label for="product_type" >매물 유형 *</label>
                <select id="product_type" name="product_type" required>
                    <option value="원룸">원룸</option>
                    <option value="아파트">아파트</option>
                    <option value="빌라">빌라</option>
                </select>
            </div>
<div class="form-group">
    <label for="address">매물 주소 *</label>
    <br>
    <input type="text" name="address" id="address" placeholder="주소" style="width: calc(100%); padding: 10px;">
    <input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색" style="width: 30%; padding: 5px 10px; font-size: 0.9rem; display: inline-block;">
    <br>
    <div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>


    <script>
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
                center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
                level: 5, // 지도의 확대 레벨
                draggable: false
            };

        // 지도를 미리 생성
        var map = new daum.maps.Map(mapContainer, mapOption);
        // 주소-좌표 변환 객체를 생성
        var geocoder = new daum.maps.services.Geocoder();
        // 마커를 미리 생성
        var marker = new daum.maps.Marker({
            position: new daum.maps.LatLng(37.537187, 127.005476),
            map: map
        });
		daumService.getaddress
        function sample5_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var addr = data.address; // 최종 주소
                    var sigungu = data.sigungu; // 시군구 정보

                    // 주소 정보를 해당 필드에 넣는다
                    document.getElementById("address").value = addr;

                    // 지도 관련 로직
                    geocoder.addressSearch(data.address, function(results, status) {
                        if (status === daum.maps.services.Status.OK) {
                            var result = results[0]; // 첫 번째 결과
                            var coords = new daum.maps.LatLng(result.y, result.x);
                            mapContainer.style.display = "block";
                            map.relayout();
                            map.setCenter(coords);
                            marker.setPosition(coords);
                        }
                    });

                    // sigungu를 필요한 경우 다른 숨겨진 필드에 저장
                    var sigunguInput = document.getElementById("sigungu");
                    if (sigunguInput) {
                        sigunguInput.value = sigungu;
                    }
                }
            }).open();
        }
 
	    function handleSubmit() {
	        alert("매물이 등록되었습니다.");
	        return true; // 서버로 데이터 전송 허용
	    }
 
    </script>
</div>


    <form action="/salre/product/insert" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
    <!-- 상세 주소 -->
    <div class="form-group">
        <label for="address_detail">상세 주소</label>
        <input type="text" id="address_detail" name="address_detail" placeholder="상세 주소(없는 경우 비움)">
    </div>

    <!-- 매물 크기 -->
    <div class="form-group">
        <label for="area">매물 크기 *</label>
        <input type="number" id="area" name="area" placeholder="크기 입력 (㎡)" required>
    </div>

    <!-- 방 개수 -->
    <div class="form-group">
        <label for="room_count">방 개수 *</label>
        <input type="number" id="room_count" name="room_count" placeholder="방 개수" required>
    </div>

    <!-- 화장실 수 -->
    <div class="form-group">
        <label for="bath_count">화장실 수 *</label>
        <input type="number" id="bath_count" name="bath_count" placeholder="화장실 개수" required>
    </div>

    <!-- 층 -->
    <div class="form-group">
        <label for="floor">층 *</label>
        <input type="number" id="floor" name="floor" placeholder="층" required>
    </div>

    <!-- 방향 -->
    <div class="form-group">
        <label for="direction">방향 *</label>
        <input type="radio" id="direction" name="direction" value="동" required> 동
        <input type="radio" id="direction" name="direction" value="서" required> 서
        <input type="radio" id="direction" name="direction" value="남" required> 남
        <input type="radio" id="direction" name="direction" value="북" required> 북
    </div>

			
            <!-- 거래 정보 -->
          <h2>거래 정보</h2>
<div class="form-group">
    <label for="payment_type">거래 종류 *</label>
    <input type="radio" id="rent" name="payment_type" value="월세" required onclick="toggleRentField()"> 월세
    <input type="radio" id="sell" name="payment_type" value="전세" required onclick="toggleRentField()"> 전세
</div>
 <!-- 보증금 -->
    <div class="form-group">
        <label for="deposit">보증금 *</label>
        <input type="text" id="deposit" name="deposit" required placeholder="원">
    </div>

    <!-- 월세 -->
    <div class="form-group" id="rentField">
        <label for="rent">월세</label>
        <input type="number" id="rentfee" name="rentfee" placeholder="원">
    </div>

<script>
    // 페이지 로드 시 초기 상태 설정
    document.addEventListener("DOMContentLoaded", function() {
        toggleRentField();
    });

    // 라디오 버튼 선택에 따라 월세 필드 보이기/숨기기
    function toggleRentField() {
        var rentField = document.getElementById("rentField");
        var rentRadio = document.getElementById("rent");
        if (rentRadio.checked) {
            rentField.style.display = "block"; // 월세 보이기
        } else {
            rentField.style.display = "none"; // 월세 숨기기
        }
    }
    
    
    function toggleRentField() {
        const rentField = document.getElementById("rentField");
        const rentInput = document.getElementById("rentfee");
        const isRent = document.getElementById("rent").checked;

        if (isRent) {
            // 월세가 선택되었을 때 월세 입력 필드 활성화
            rentField.style.display = "block";
            rentInput.value = ""; // 월세 입력 필드를 비움
            rentInput.required = true; // 필수 입력 설정
        } else {
            // 전세가 선택되었을 때 월세 입력 필드 숨김
            rentField.style.display = "none";
            rentInput.value = 0; // rentfee 값을 0으로 설정
            rentInput.required = false; // 필수 입력 해제
        }
    }
    window.onload = function () {
        toggleRentField();
    };
</script>
         <!-- 관리비 -->
    <div class="form-group">
        <label for="manage_fee">관리비 *</label>
        <input type="text" id="manage_fee" name="manage_fee" placeholder="월 5만원">
    </div>

    <!-- 입주 가능일 -->
    <div class="form-group">
        <label for="enter_day">입주 가능일 *</label>
        <input type="date" id="enter_day" name="enter_day" required>
    </div>

          
    <!-- 사진 등록 -->
    <h2>사진 등록</h2>
    <div class="form-group">
        <label for="photo">기본 사진 *</label>
        <input type="file" id="photo" name="photo" accept="image/*" required onchange="return validateImageFile(this);">
    </div>
             <!-- 기본 정보 -->
    <h2>기본 정보</h2>
    <div class="form-group">
        <label for="product_name">제목 *</label>
        <input type="text" id="product_name" name="product_name" placeholder="예: 역세권 원룸 매물" required>
    </div>
    <div class="form-group">
        <label for="description">상세 설명 *</label>
        <textarea id="description" name="description" rows="5" placeholder="매물에 대한 상세 정보를 입력해주세요." required></textarea>
    </div>

    <h2>건설 정보</h2>
    <div class="form-group">
        <label for="land_type">토지 - 지목 *</label>
        <input id="land_type" name="land_type" placeholder="'전', '답', '대', '임야', '도로', '공장용지', '잡종지', '기타'" required>
    </div>

    <div class="form-group">
        <label for="land_area">토지 - 면적 *</label>
        <input id="land_area" name="land_area" placeholder="184.1분의 12.483㎡" required>
    </div>

    <div class="form-group">
        <label for="building_structure">건물 - 구조 *</label>
        <input id="building_structure" name="building_structure" placeholder="RC', 'SRC', 'S', '조적조', '목조', '경량철골조', '기타'" required>
    </div>

    <div class="form-group">
        <label for="building_usage">건물 - 용도 *</label>
        <input id="building_usage" name="building_usage" placeholder="'주거용', '상업용', '공업용', '기타'" required>
    </div>

    <div class="form-group">
        <label for="rental_area">임대할 부분</label>
        <input id="rental_area" name="rental_area" placeholder="'전체', '1층', '2층 일부', '사무실 한 칸'">
    </div>

    <!-- 사용 승인일 -->
    <div class="form-group">
        <label for="approve_day">사용 승인일 *</label>
        <input type="date" id="approve_day" name="approve_day" required>
    </div>

	 			<script>console.log("유저 id : " ${sessionScope.loggedInUser.user_id})
	 			console.log("유저 id : " ${sessionScope.loggedInUser.user_id})</script>
			 
				
 
					
            <!-- 제출 버튼 -->          
            <button type="submit">매물 등록</button> 
                    <input type="hidden" id="sigungu" name="sigungu">
                    <input type="hidden" id="product_status" name="product_status" value="0">
    <input type="hidden" id="user_id" name="user_id" value="${sessionScope.loggedInUser.user_id}" required>
                    
        </form>
        
        <script>
    // 이미지 파일 검증 (크기 및 형식)
    function validateImageFile(input) {
        const file = input.files[0];
        const allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
        const maxSize = 5 * 1024 * 1024; // 5MB

        if (!file) {
            alert("파일을 선택해주세요.");
            return false;
        }

        // 파일 크기 체크
        if (file.size > maxSize) {
            alert("파일 크기는 5MB를 초과할 수 없습니다.");
            input.value = ''; // 파일 초기화
            return false;
        }

        // 파일 형식 체크
        if (!allowedTypes.includes(file.type)) {
            alert("허용되지 않는 파일 형식입니다. (허용: JPG, PNG, GIF)");
            input.value = ''; // 파일 초기화
            return false;
        }

        return true;
    }

    // 숫자 입력 검증
    function validateNumbers() {
        const area = document.getElementById("area").value;
        const roomCount = document.getElementById("room_count").value;
        const bathCount = document.getElementById("bath_count").value;
        const floor = document.getElementById("floor").value;
        const deposit = document.getElementById("deposit").value;
        const rentfee = document.getElementById("rentfee").value;
        const manageFee = document.getElementById("manage_fee").value;
        const landArea = document.getElementById("land_area").value;

        // 음수 체크
        if (area <= 0 || roomCount <= 0 || bathCount <= 0 || floor <= 0 || deposit <= 0 || rentfee < 0 || manageFee < 0 || landArea <= 0) {
            alert("숫자는 0보다 커야 합니다.");
            return false;
        }

        return true;
    }

    // 날짜 입력값 검증
    function validateDates() {
        const enterDay = document.getElementById("enter_day").value;
        const approveDay = document.getElementById("approve_day").value;

        const today = new Date();
        const enterDate = new Date(enterDay);
        const approveDate = new Date(approveDay);

        // 입주 가능일과 사용 승인일이 오늘 이후여야 한다
        if (enterDate < today) {
            alert("입주 가능일은 오늘 이후여야 합니다.");
            return false;
        }

        if (approveDate < today) {
            alert("사용 승인일은 오늘 이후여야 합니다.");
            return false;
        }
        return true;
    }

    // 전체 유효성 검사
    function validateForm() {
        if (!validateNumbers()) {
            return false;
        }

        if (!validateDates()) {
            return false;
        }

        return true;
    }
</script>
    </section> 
    <%@ include file="../common/footer.jsp" %>
</body>
</html>
