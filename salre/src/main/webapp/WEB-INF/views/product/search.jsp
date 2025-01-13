<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>살래?</title>
    <!-- Favicon -->
	<link rel="shortcut icon" href="${contextPath}/resources/images/favicon.ico">
       <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* 메인 배너 스타일 */
        .main-banner {
            background: url('/salre/resources/images/mainpage_bg.webp') no-repeat center center/cover;
            text-align: center;
            padding: 50px 20px;
            position: relative;
            color: #fff; /* 텍스트를 흰색으로 */
        }

        .main-banner::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5); /* 어두운 오버레이 추가 */
            z-index: 1;
        }

        .main-banner h1 {
            font-size: 40px;
            margin-bottom: 15px;
            z-index: 2;
            position: relative;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.7); /* 텍스트 그림자 추가 */
        }

        .main-banner p {
            font-size: 16px;
            color: #eee; /* 텍스트 색상을 밝게 조정 */
            z-index: 2;
            position: relative;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.5); /* 텍스트 그림자 추가 */
        }

        .main-banner input {
            padding: 10px;
            width: 300px;
            margin-right: 10px;
            z-index: 2; /* z-index를 높게 설정하여 오버레이 위에 표시되도록 함 */
            position: relative; /* z-index가 작동하려면 position이 설정되어 있어야 합니다. */
        }

        .main-banner button {
            padding: 10px 20px;
            background-color: #f4a261;
            color: #fff;
            border: none;
            cursor: pointer;
            z-index: 2; /* z-index를 높게 설정하여 오버레이 위에 표시되도록 함 */
            position: relative; /* z-index가 작동하려면 position이 설정되어 있어야 합니다. */
        }
        .search-container {
            display: flex;  /* flexbox로 변경 */
            justify-content: space-between;  /* 필터와 검색 결과를 좌우로 배치 */
            width: 100%;
            padding: 20px;
        }
        .filters {
            width: 250px;
            padding: 20px;
            background-color: #fff;
            border-right: 1px solid #ddd;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }
        .filters select, .filters input {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        .filters button {
            width: 100%;
            padding: 10px;
            background-color: #f4a261;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        .search-results {
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-start;
            margin-top: 20px;
            padding: 20px;
            flex: 1;
        }
        .search button {
            padding: 10px 20px;
            background-color: #f4a261;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        .product-card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 200px;
            margin: 10px;
            padding: 15px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); 
            overflow: hidden;  
   			display: inline-block;  
        }
        .product-card img {
            border-radius: 8px;
            width: 200px;
            max-height: 200px; 
            object-fit: cover; 
            object-position: center; 
            border: 1px solid #ddd; 
  			height: auto; /* 비율 유지 */
    		transition: transform 0.3s ease; /* 확대 효과의 부드러움 설정 */
        }
        .product-card img:hover {
   		 	transform: scale(1.1); /* 마우스 오버 시 10% 확대 */
		}
        .product-card h3 {
            font-size: 18px;
            margin: 10px 0;
        }
        .product-card p {
            font-size: 16px;
            color: #666;
        }
        .product-card .price {
            font-size: 20px;
            font-weight: bold;
            color: #f4a261;
            margin-top: 10px;
        }
        .slider-tooltip {
		    background-color: #333;
		    color: #fff;
		    padding: 5px 10px;
		    border-radius: 5px;
		    font-size: 12px;
		    white-space: nowrap;
		    margin-top : 50px;
		}
        
    </style>
</head>
<body>
    <section class="main-banner">
        <form action="product" method="GET">
            <input type="text" name="search" placeholder="원하시는 지역, 건물을 입력해주세요.">
            <button type="submit">검색</button>
        </form>
    </section>

	 <div class="search-container">
    <!-- 왼쪽 필터 섹션 -->
    <section class="filters">
        <h3>필터</h3>
         <form action="/salre/product/search/filter" method="GET">
            <!-- 아코디언 필터 시작 -->
            <div class="accordion" id="filterAccordion">
                
                <!-- 지역 선택 -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingRegion">
 
                    </h2>
                    <div id="collapseRegion" class="accordion-collapse collapse show" aria-labelledby="headingRegion" data-bs-parent="#filterAccordion">
                        <div class="accordion-body">
                            <select class="form-select" name="region_id" required>
                                <option value="">지역 선택</option>
                                <option value="1">종로구</option>
                                <option value="2">중구</option>
                                <option value="3">용산구</option>
                                <option value="4">성동구</option>
                                <option value="5">광진구</option>
                                <option value="6">동대문구</option>
                                <option value="7">중랑구</option>
                                <option value="8">성북구</option>
                                <option value="9">강북구</option>
                                <option value="10">도봉구</option>
                                <option value="11">노원구</option>
                                <option value="12">은평구</option>
                                <option value="13">서대문구</option>
                                <option value="14">마포구</option>
                                <option value="15">양천구</option>
                                <option value="16">강서구</option>
                                <option value="17">구로구</option>
                                <option value="18">금천구</option>
                                <option value="19">영등포구</option>
                                <option value="20">동작구</option>
                                <option value="21">관악구</option>
                                <option value="22">서초구</option>
                                <option value="23">강남구</option>
                                <option value="24">송파구</option>
                                <option value="25">강동구</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- 결제 유형 -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingPayment">
   
                    </h2>
                    <div id="collapsePayment" class="accordion-collapse collapse show" aria-labelledby="headingPayment" data-bs-parent="#filterAccordion">
                        <div class="accordion-body">
                            <select class="form-select" name="payment_type" required>
                                <option value="">결제 유형 선택</option>
                                <option value="전세">전세</option>
                                <option value="월세">월세</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- 제품 상태 -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingStatus">
  
                    </h2>
                    <div id="collapseStatus" class="accordion-collapse collapse show" aria-labelledby="headingStatus" data-bs-parent="#filterAccordion">
                        <div class="accordion-body">
                            <select class="form-select" name="product_status" required>
                                <option value="">상태 선택</option>
                                <option value="0">거래 전</option>
                                <option value="1">거래 중</option>
                                <option value="2">거래 후</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- 방 개수 -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingRooms">
 
                    </h2>
                    <div id="collapseRooms" class="accordion-collapse collapse show" aria-labelledby="headingRooms" data-bs-parent="#filterAccordion">
                        <div class="accordion-body">
                            <select class="form-select" name="room_count" required>
                                <option value="">방 개수 선택</option>
                                <option value="1">1개</option>
                                <option value="2">2개</option>
                                <option value="3">3개</option>
                                <option value="4">4개</option>
                                <option value="5">5개</option>
                                <option value="6">6개</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- 층 수 -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingFloor"> 
                    </h2>
                    <div id="collapseFloor" class="accordion-collapse collapse show" aria-labelledby="headingFloor" data-bs-parent="#filterAccordion">
                        <div class="accordion-body">
                            <label class="filter-label" >층 수 선택</label>
                            <div class="slider-container" style="position: relative; width: 90%;">
							    <input type="range" class="form-range filter-slider" name="floor" min="-1" max="30" step="1" value="-1" style = "margin-top : 50px;" >
							    <div class="slider-tooltip" style="position: absolute; top: -30px; left: 0; transform: translateX(-50%); display: none;">
							        <span id="tooltipValue">지하</span>
							    </div>
							</div>  
                        </div>
                    </div>
                </div>
            </div>


    <script>
    $("input[name='floor']").on('input', function() {
        var value = parseInt($(this).val());
        if (value === 0) {
            $(this).val(1); // 0을 건너뛰고 1로 설정
            value = 1;
        }
        
        var floorText = value < 0 ? "지하" : (value <= 10 ? value + "층" : 
                      (value <= 15 ? "11-15층" : 
                      (value <= 20 ? "16-20층" : 
                      (value <= 30 ? "21-30층" : "30층 이상"))));
        
        var tooltip = $(this).siblings(".slider-tooltip");
        $("#tooltipValue").text(floorText);

        // 말풍선 표시 및 위치 업데이트
        var sliderWidth = $(this).width();
        var offset = (value - $(this).attr("min")) / ($(this).attr("max") - $(this).attr("min")) * sliderWidth;
        tooltip.css({ left: offset + "px", display: "block" });
    });

    </script>
            <!-- 제출 버튼 -->
            <button type="submit" class="btn btn-primary mt-3" style = "margin-top : 5px;">필터 적용</button>
        </form>
    </section> 
    <!-- 오른쪽 검색 결과 섹션 -->
    <section class="search-results" id="search-results">
        <c:if test="${not empty searchResults}">
        
            <c:forEach var="product" items="${searchResults}">
            
             <a href="/salre/product/detail/${product.product_id}" class="product-card-link">
                <div class="product-card">
                    <img class="product-image" 
                         src="resources/images/products/${product.product_id}.jpeg" 
                         alt="${product.product_name}" 
                         onerror="this.src='https://placehold.co/200x200';">
                    <h3 style="color: black;">${product.product_name}</h3>
                    <p>${product.address}, ${product.address_detail}</p>
                    <p>방 수: ${product.room_count} | 욕실 수: ${product.bath_count}</p>
                    <p>층수: ${product.floor}층 | 면적: ${product.area}㎡</p>
                   
                    <div class="price"> 
                        <c:choose>
                            <c:when test="${product.deposit >= 100000000}"> 
                                보증금
                                <c:if test="${(product.deposit % 100000000) / 10000 >= 0}">  
                                    <fmt:formatNumber pattern="####" value = "${product.deposit / 100000000}" />
                                    억
                                </c:if>
                                <c:if test="${(product.deposit / 100000000) < 1}">
                                    <fmt:formatNumber pattern="####" value = "${product.deposit}" />
                                    만
                                </c:if>
                                원 
                            </c:when>
                            <c:otherwise>
                                보증금
                                <fmt:formatNumber pattern="####" value = "${product.deposit / 10000}" />
                                만 원                             
                            </c:otherwise>
                        </c:choose>
                        <c:if test = "${product.payment_type == '월세' }">
                            / ${product.rentfee} 만 원 월세
                        </c:if>
                    </div> 
                </div>
                </a>
            </c:forEach>
        </c:if>
        <c:if test="${empty searchResults}">
            <p style="text-align: center; font-size: 20px; color: #999;">검색 결과가 없습니다.</p>
        </c:if>
    </section> 
</div>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
