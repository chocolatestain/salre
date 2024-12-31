<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>매물 등록</title>
    <style>
    /* 기본 설정 */
body {
    font-family: 'Arial', sans-serif;
    line-height: 1.6;
    margin-top: 100px;
    padding: 0;
    box-sizing: border-box;
    background-color: #f9f9f9;
    color: #333;
}

/* 헤더 스타일 */
 header {
      position: fixed; /* 항상 맨 위에 고정 */
      top: 0;
      left: 0;
      width: 100%;
      background-color: #fff;
      border-bottom: 1px solid #ddd;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 20px;
      box-sizing: border-box;
      z-index: 10;
    }

    header .logo {
      font-size: clamp(1.5rem, 2.5vw, 3rem);
      font-weight: bold;
    }

    header nav a {
      font-size: clamp(1rem, 1.5vw, 1.5rem);
      margin: 0 10px;
      text-decoration: none;
      font-weight: bold;
      color: #333;
    }

    header .auth a {
      margin-left: 15px;
      padding: 10px 20px;
      background-color: #f4a261;
      color: #fff;
      border-radius: 5px;
      text-decoration: none;
    }

/* 메인 배너 스타일 */
.main-banner { 
    background: url('../resources/images/mainpage_bg.webp') no-repeat center center/cover;
    text-align: center;
    padding: 30px 20px;
}

 


.main-banner h1 {
    font-size: 32px;
    margin-bottom: 10px;
}

.main-banner p {
    font-size: 14px;
    color: #555;
}

/* 폼 섹션 스타일 */
.form-section {
    max-width: 800px;
    margin: 20px auto;
    padding: 20px;
}

.form-section h2 {
    font-size: 40px;
    margin-bottom: 20px;
    color: #333;
    border-bottom: 2px solid #f4a261;
    padding-bottom: 5px;
}

.form-group {
	font-size : 1rem;
    margin-bottom: 15px;
}

.form-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
}

.form-group input,
.form-group select,
.form-group textarea {
    width: 100%;
    padding: 10px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
    outline: none;
    border-color: #f5f5f5;
    box-shadow: 0 0 4px rgba(108, 99, 255, 0.5);
}

.form-group input[type="radio"] {
    width: auto;
    margin-right: 5px;
}

button[type="submit"] {
    background-color: #80543E;
    color: #fff;
    padding: 10px 20px;
    font-size: 16px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
    width: 103%;
}

button[type="submit"]:hover { 
    background-color: #E1C59D;
}


/* 반응형 디자인 추가 (Media Queries) */
@media (max-width: 768px) {
    /* 모바일 및 태블릿 화면 크기 */
    .main-banner h1 {
        font-size: 24px;
    }

    .form-section h2 {
        font-size: 30px;
    }

    .form-group input,
    .form-group select,
    .form-group textarea,
    button[type="submit"] {
        font-size: 14px;
    }

    header .logo {
        font-size: 2rem;
    }

    header nav {
        display: none; /* 메뉴 숨기기 */
    }

    header .auth {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    footer {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    footer div {
        margin-bottom: 20px;
    }
}

@media (max-width: 480px) {
    /* 작은 모바일 화면 */
    .main-banner h1 {
        font-size: 20px;
    }

    .form-section {
        padding: 10px;
    }

    .form-group label {
        font-size: 14px;
    }

    .form-group input,
    .form-group select,
    .form-group textarea {
        padding: 8px;
        font-size: 12px;
    }

    button[type="submit"] {
        font-size: 14px;
    }
    }
  footer {
            width:100%;
            display: flex;
            justify-content: space-around;
            background-color: #222;
            color: #fff;
            padding: 20px 0;
        }
        footer div {
            text-align: left;
        }
        footer a {
            color: #f4a261;
            text-decoration: none;
    }
  
    </style>
</head>
<body>
    <!-- 헤더 -->
   <header>
    <div class="logo" onclick="location.href='/salre'" style="cursor: pointer;">살래?</div>

    <nav>
      <a href="#">대출상품</a>
      <a href="#">채팅</a>
      <a href="#">게시판</a>
      <a href="#">매물</a>
      <a href="#">관심매물</a>
      <a href="#">방내놓기</a>
    </nav>
    <div class="auth">
      <a href="login.jsp">로그인</a>
      <a href="register.jsp">회원가입</a>
    </div>
  </header>

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
        <form action="/salre/product/insert" method="post" enctype="multipart/form-data">
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
    <input type="text" name = "address" id="address" placeholder="주소" style="width: calc(100%); padding: 10px;">
  <input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색" style="width: 30%; padding: 5px 10px; font-size: 0.9rem; display: inline-block; align: center">
    <br>
    <div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=58380a7fb187c1a835fded7eee3e2c78&libraries=services"></script>
    <script>
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
                center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
                level: 5, // 지도의 확대 레벨
                draggable: false
            };

        //지도를 미리 생성
        var map = new daum.maps.Map(mapContainer, mapOption);
        //주소-좌표 변환 객체를 생성
        var geocoder = new daum.maps.services.Geocoder();
        //마커를 미리 생성
        var marker = new daum.maps.Marker({
            position: new daum.maps.LatLng(37.537187, 127.005476),
            map: map
        });

        function sample5_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var addr = data.address; // 최종 주소 변수

                    // 주소 정보를 해당 필드에 넣는다.
                    document.getElementById("address").value = addr;
                    // 주소로 상세 정보를 검색
                    geocoder.addressSearch(data.address, function(results, status) {
                        // 정상적으로 검색이 완료됐으면
                        if (status === daum.maps.services.Status.OK) {

                            var result = results[0]; //첫번째 결과의 값을 활용

                            // 해당 주소에 대한 좌표를 받아서
                            var coords = new daum.maps.LatLng(result.y, result.x);
                            // 지도를 보여준다.
                            mapContainer.style.display = "block";
                            map.relayout();
                            // 지도 중심을 변경한다.
                            map.setCenter(coords);
                            // 마커를 결과값으로 받은 위치로 옮긴다.
                            marker.setPosition(coords)
                        }
                    });
                }
            }).open();
        }
    </script>
</div>

            <div class="form-group">
            	<label for ="address">상세 주소 </label>
            	<input type = "text" id = "address_detail" name = "address_detail" placeholder = "상세 주소(없는 경우 비움)">
            	</div>
            <div class="form-group">
                <label for="area">매물 크기 *</label>
                <input type="number" id="area" name="area" placeholder="크기 입력 (㎡)" required>
            </div>
            <div class="form-group">
                <label for="room_count">방 정보 *</label>
                <input type="number" id="room_count" name="room_count" placeholder="방 개수" required>
            </div>
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
                <input type="radio" id="rent" name="payment_type" value="월세" required> 월세
                <input type="radio" id="sell" name="payment_type" value="전세" required> 전세
            </div>
            <div class="form-group">
                <label for="deposit">보증금 *</label>
                <input type="text" id="deposit" name="deposit" required placeholder = "원">
            </div>
            <div class="form-group">
                <label for="rent">월세 </label>
                <input type="text" id="rent" name="rent" placeholder = "원">
            </div>
            <div class="form-group">
                <label for="manage_fee">관리비 *</label>
                <input type="text" id="manage_fee" name="manage_fee" placeholder="월 5만원">
            </div>
            <div class="form-group">
                <label for="enter_day">입주 가능일 *</label>
                <input type="date" id="enter_day" name="enter_day" required>
            </div>

            <!-- 사진 등록 -->
            <h2>사진 등록</h2>
            <div class="form-group">
                <label for="photo">기본 사진 *</label>
                <input type="file" id="photo" name="photo" accept="image/*" required>
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
			<div class = "form-group">
				<label for = "land_type">토지 - 지목 *</label>
					<input id = "land_type" name = "land_type" placeholder = "'전', '답', '대', '임야', '도로', '공장용지', '잡종지', '기타'" required></input>
			</div>
			
				<div class = "form-group">
					<label for = "land_area">토지 - 면적 *</label>
					<input id = "land_area" name = "land_area" placeholder = "184.1분의 12.483㎡" required></input>
				</div>
				<div class = "form-group">
					<label for = "building_structure">건물 - 구조 *</label>
					<input id = "building_structure" name = "building_structure" placeholder = "RC', 'SRC', 'S', '조적조', '목조', '경량철골조', '기타'" required></input>
				</div>
				<div class = "form-group">
					<label for = "building_usage">건물 - 용도 * </label>
					<input id = "building_usage" name = "building_usage" placeholder = "'주거용', '상업용', '공업용', '기타'" required></input>
				</div>
				<div class = "form-group">
					<label for = "rental_area">임대할 부분</label>
					<input id = "rental_area" name = "rental_area" placeholder = "'전체', '1층', '2층 일부', '사무실 한 칸'"></input>
				</div>
				<div class="form-group">
                <label for="approve_day">사용 승인일 *</label>
                <input type="date" id="approve_day" name="approve_day" required>
            </div>
				<h2>TESTTEST</h2>
				<div class = "form-group">
					<label for = "user_id">사용자 id</label>
					<input id = "user_id" name = "user_id" required></input>
				</div>
            <!-- 제출 버튼 -->          
            <button type="submit">매물 등록</button> 
        </form>
    </section>

<section class="form-section">
    <h2>입력된 정보 확인</h2>
    <button type="button" onclick="previewData()">보기</button>
    <div id="preview" style="display:none; margin-top: 20px;">
        <h3>입력된 정보</h3>
        <ul id="previewList"></ul>
        <button type="button" onclick="submitForm()">전송</button>
    </div>
</section>

<script>

    function previewData() {
        var previewContainer = document.getElementById("preview");
        var previewList = document.getElementById("previewList");
        previewList.innerHTML = ''; 
        
        var formData = {
            '매물 유형': document.getElementById("product_type").value,
            '매물 주소': document.getElementById("address").value,
            '상세 주소': document.getElementById("address_detail").value,
            '매물 크기': document.getElementById("area").value + "㎡",
            '방 개수': document.getElementById("room_count").value,
            '거래 종류': document.querySelector('input[name="payment_type"]:checked') ? document.querySelector('input[name="payment_type"]:checked').value : '',
            '보증금': document.getElementById("deposit").value + "원",
            '월세': document.getElementById("rent").value ? document.getElementById("rent").value + "원" : '없음',
            '관리비': document.getElementById("manage_fee").value + "원",
            '입주 가능일': document.getElementById("enter_day").value,
            '제목': document.getElementById("product_name").value,
            '상세 설명': document.getElementById("description").value,
            '토지 - 지목': document.getElementById("land_type").value,
            '토지 - 면적': document.getElementById("land_area").value,
            '건물 - 구조': document.getElementById("building_structure").value,
            '건물 - 용도': document.getElementById("building_usage").value,
            '임대할 부분': document.getElementById("rental_area").value,
            '사용자 id': document.getElementById("user_id").value
        };

        for (var key in formData) {
            if (formData[key]) { 
                var listItem = document.createElement("li");
                listItem.textContent = key + ": " + formData[key];
                previewList.appendChild(listItem);
            }
        }
        
        previewContainer.style.display = "block";
        console.log(formData);
    }
	
    function submitForm() {
        var form = document.querySelector("form");
        form.submit(); 
    }
</script>

    <!-- 푸터 -->
<footer>
  <div>
      <h3>형태 별 검색</h3>
      <p>전세<br>월세<br>아파트<br>빌라<br>상가</p>
  </div>
  <div>
      <h3>고객 지원</h3>
      <a href="#">자주 묻는 질문(FAQ)</a><br>
      <a href="#">Android</a><br>
      <a href="#">iOS</a>
  </div>
  <div>
      <h3>저희 회사는</h3>
      <a href="#">회사소개</a><br>
      <a href="#">오시는 길</a><br>
      <a href="#">제휴문의</a><br>
      <a href="#">채용</a><br>
  </div>
</footer>
</body>
</html>
