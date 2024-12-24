<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.salre.main.product.ProductDTO" %>

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
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            background-color: #fff;
            border-bottom: 1px solid #ddd;
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
        .search-results {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin-top: 20px;
            padding: 20px;
        }
        .product-card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 300px;
            margin: 10px;
            padding: 15px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .product-card img {
            width: 100%;
            height: auto;
            border-radius: 8px;
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
            justify-content: center;
            align-items: center;
            background-color: #222;
            color: #fff;
            padding: 20px;
            margin-top: 30px;
        }
        footer a {
            color: #f4a261;
            text-decoration: none;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        <div class="logo">살래?</div>
        <nav>
            <a href="#">대출상품</a>
            <a href="#">채팅</a>
            <a href="#">게시판</a>
            <a href="#">매물</a>
            <a href="#">관심매물</a>
            <a href="#">방내놓기</a>
        </nav>
    </header>

    <!-- Search Results Section -->
    <section class="search-results">
      	 	 <% 
            // searchResults 리스트에서 검색 결과 가져오기
            List<ProductDTO> searchResults = (List<ProductDTO>) request.getAttribute("searchResults"); 
            
            if (searchResults != null && !searchResults.isEmpty()) { // nullpointerexception 방지
                for (ProductDTO product : searchResults) {
     	   %>
            <div class="product-card">
                <!-- 제품 이미지 -->
             <%=product.getProduct_id() %>
			<img src="resources/images/products/${product.product_id}.jpeg" 
			     alt="${product.product_name}" 
			     onload="console.log('로딩 성공 , 주소 : ' + this.src + ');"
<!-- 			     onerror="console.log('로딩 실패 : ' + this.src); this.onerror=null; this.src='https://placehold.co/320x200';"> -->
>
                <h3><%= product.getProduct_name() %></h3>

                <!-- 제품 상세 정보 -->
                <p><%= product.getAddress() %>, <%= product.getAddress_detail() %></p>
                <p>방 수: <%= product.getRoom_count() %> | 욕실 수: <%= product.getBath_count() %></p>
                <p>층수: <%= product.getFloor() %>층 | 면적: <%= product.getArea() %>㎡</p>
                
                <!-- 가격 정보 -->
                <div class="price">
                    <%= product.getDeposit() %>원 보증금 / <%= product.getRentfee() %>원 월세
                </div>
            </div>
        <% 
                }
            } else {
        %>
            <p>검색 결과가 없습니다.</p>
        <% 
            }
        %>
    </section>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 살래? All rights reserved.</p>
    </footer>

</body>
</html>
