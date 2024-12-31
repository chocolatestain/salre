<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품 검색 결과</title>
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
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            background-color: #fff;
            border-bottom: 1px solid #ddd;
            width: 100%;
        }
        header .logo {
            font-size: 24px;
            font-weight: bold;
        }
        header nav a {
            margin: 0 10px;
            text-decoration: none;
            color: #333;
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
        .search{
			padding: 60px 20px;
        	text-align: center; 
        	margin : 30px;
        }
        .search input {
            padding: 10px;
            width: 300px;
            margin-right: 10px;
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
 
        footer {
            display: flex;
            justify-content: space-around;
            background-color: #222;
            color: #fff;
            padding: 20px 0;
        } 
        footer a {
            color: #f4a261;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">
            <a href="/salre" style="text-decoration: none; color: inherit;">살래?</a>
        </div>
        <nav>
            <a href="#">대출상품</a>
            <a href="#">채팅</a>
            <a href="#">게시판</a>
            <a href="#">매물</a>
            <a href="#">관심매물</a>
            <a href="insert">방내놓기</a>
        </nav>
    </header>

    <div class="search">
        <form action="search" method="GET">
            <input type="text" name="search" placeholder="원하시는 지역, 건물을 입력해주세요.">
            <button type="submit">검색</button>
        </form> 
    </div>

	 <div class="search-container">
    <!-- 왼쪽 필터 섹션 -->
    <section class="filters">
        <h3>필터</h3>
        <form action="filterSearch" method="GET">
            <!-- 매물 종류 -->
            <label for="property-type">매물 종류:</label>
            <select name="propertyType" id="property-type">
                <option value="all">전체</option>
                <option value="apartment">아파트</option>
                <option value="oneroom">원룸</option>
                <option value="villa">빌라</option>
                <option value="officetel">오피스텔</option>
            </select>

            <!-- 거래 유형 -->
            <label for="transaction-type">거래 유형:</label>
            <select name="transactionType" id="transaction-type">
                <option value="all">전체</option>
                <option value="jeonse">전세</option>
                <option value="wolse">월세</option>
            </select>

            <!-- 평수 -->
            <label for="area-size">평수:</label>
            <select name="areaSize" id="area-size">
                <option value="all">전체</option>
                <option value="30">30㎡ 이하</option>
                <option value="35">35㎡</option>
                <option value="40">40㎡</option>
                <option value="45">45㎡</option>
                <option value="50">50㎡</option>
                <option value="50plus">50㎡ 이상</option>
            </select>

            <!-- 층수 -->
            <label for="floor">층수:</label>
            <select name="floor" id="floor">
                <option value="all">전체</option>
                <option value="semi-basement">반지하</option>
                <option value="first-floor">1층</option>
                <option value="2-6">2~6층</option>
                <option value="6-10">6~10층</option>
                <option value="10plus">10층 이상</option>
            </select>

            <button type="submit">필터 적용</button>
        </form>
    </section> 
    <!-- 오른쪽 검색 결과 섹션 -->
    <section class="search-results" id="search-results">
        <c:if test="${not empty searchResults}">
            <c:forEach var="product" items="${searchResults}">
             <a href="product/detail/${product.product_id}" class="product-card-link">
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
