<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath"
	value="${pageContext.servletContext.contextPath}"></c:set>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewPort" content="width=device-width, initial-scale=1.0">
<title>나의 관심매물</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<style>
.card-container {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
	gap: 20px;
	margin-top: 20px;
}

.card img {
	height: 180px;
	object-fit: cover;
}

.heart-btn {
	background: none;
	border: none;
	color: gray;
}

.heart-btn.liked {
	color: red;
}
</style>

</head>
<body>

	<%@ include file="../common/header.jsp"%>

	<div class="container-fluid">
		<div class="row">
			<!-- Sidebar -->
			<%@ include file="../common/sidebar.jsp"%>

			<!-- Main Content -->
			<div class="col-md-9">
				<h1 class="mb-4">My Page - 나의 관심매물</h1>

				<!-- 구매자 콘텐츠 -->
				 <div id="buyer-content">
					<div class="row mb-3">
						<!-- <div class="col">
							<button class="btn btn-secondary">등록순</button>
							<button class="btn btn-secondary">거래순</button>
							<button class="btn btn-secondary">조회수 순</button>
							<button class="btn btn-secondary">평점 순</button>
						</div> -->
						<!-- <div class="col text-end">
							<input type="date" class="form-control d-inline-block w-auto"
								id="startDate"> <span>~</span> <input type="date"
								class="form-control d-inline-block w-auto" id="endDate">
						</div> -->
					</div>

					<!-- 매물 목록 -->
					<div class="card-container">
						<!--  서버에서받는거...   -->
						<c:forEach var="product" items="${favoritesList}">
							<div class="card">
								<%-- <img src="${product.image}" class="card-img-top"
									alt="${product.title}"> --%>
								<img src="https://via.placeholder.com/250x180" class="card-img-top" alt="매물1">
								<div class="card-body">
								
									
									<h5 class="card-title">${product.product_name}</h5>
									<p class="card-text">
										월세: ${product.deposit}/{product.rentfee}<br>
										${product.address}
									</p>
									<div class="d-flex justify-content-between align-items-center">
										<button onclick="toggleLike(this, '${product.product_id}')"
											class="heart-btn liked">
											<i class="bi bi-heart-fill"></i>
										</button>
										<a href="${contextPath}/product/detail/${product.product_id}"
											class="btn btn-primary">자세히 보기</a>
									</div>
								</div>
							</div>
						</c:forEach>


						<!-- <div class="card">
							<img src="https://via.placeholder.com/250x180"
								class="card-img-top" alt="매물1">
							<div class="card-body">
								<h5 class="card-title">오픈형 원룸</h5>
								<p class="card-text">
									월세: 4,000 / 25<br>서울시 강남구...
								</p>
								<div class="d-flex justify-content-between align-items-center">
									<button onclick="toggleLike(this)" class="heart-btn">
										<i class="bi bi-heart"></i>
									</button>
									<a href="#" class="btn btn-primary">자세히 보기</a>
								</div>
							</div>
						</div> --> 
						 <!-- <div class="card">
							<img src="https://via.placeholder.com/250x180"
								class="card-img-top" alt="매물2">
							<div class="card-body">
								<h5 class="card-title">투룸</h5>
								<p class="card-text">
									월세: 5,000 / 15<br>경기도 수원시...
								</p>
								<div class="d-flex justify-content-between align-items-center">
									<button onclick="toggleLike(this)" class="heart-btn">
										<i class="bi bi-heart"></i>
									</button>
									<a href="#" class="btn btn-primary">자세히 보기</a>
								</div>
							</div>
						</div> -->
					</div>
				</div>
				<!-- 판매자 콘텐츠 -->
				<div id="seller-content" style="text-align: center;">
					<h3>판매자는 관심매물을 확인할 수 없습니다.</h3>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../common/footer.jsp"%><!-- include랑..?랑 컴파일되는 시점? 동작하는원리??????? -->

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
	
	<script>
	    $(document).ready(function () {
	    	// 페이지 로드 시 기본적으로 구매자 콘텐츠만 표시
			$('#buyer-content').show();
			$('#seller-content').hide();
	
	    	
	        // 토글 스위치 동작
	        $('#toggleSwitch').on('change', function () {
	            const isChecked = $(this).is(':checked');
	            if (isChecked) {
	                // 판매자 상태
	                alert('판매자 모드로 전환되었습니다.');
	                // 원하는 추가 작업 수행
	                $('#buyer-content').hide();
	                $('#seller-content').show();
	            } else {
	                // 구매자 상태
	                alert('구매자 모드로 전환되었습니다.');
	                // 원하는 추가 작업 수행
	                $('#seller-content').hide();
	                $('#buyer-content').show();
	            }
	        });
	    });
	</script>
	
	<!-- 좋아요 기능 -->
	<script>
	
	/* function toggleLike(button, product_id) {
	    const liked = button.classList.contains("liked");

	    $.ajax({
	        url: `${contextPath}/favorites/toggleLike`,
	        type: "POST",
	        data: {
	            productId: product_id,
	            liked: is_liked
	        },
	        success: function () {
	            if (liked) {
	                button.classList.remove("liked");
	                button.querySelector("i").classList.remove("bi-heart-fill");
	                button.querySelector("i").classList.add("bi-heart");
	            } else {
	                button.classList.add("liked");
	                button.querySelector("i").classList.remove("bi-heart");
	                button.querySelector("i").classList.add("bi-heart-fill");
	            }
	        },
	        error: function () {
	            alert("오류가 발생했습니다. 다시 시도해주세요.");
	        }
	    });
	} */
	function toggleLike(button, product_id) {
	    // 현재 liked 상태 확인
	    const liked = button.classList.contains("liked");
	    const is_liked = !liked; // 현재 상태의 반대 값을 서버로 보냄

	    $.ajax({
	        url: `${contextPath}/favorites/toggleLike`,
	        type: "POST",
	        data: {
	            productId: product_id,
	            liked: is_liked
	        },
	        success: function () {
	            // 요청 성공 시에만 상태 업데이트
	            if (liked) {
	                button.classList.remove("liked");
	                button.querySelector("i").classList.remove("bi-heart-fill");
	                button.querySelector("i").classList.add("bi-heart");
	            } else {
	                button.classList.add("liked");
	                button.querySelector("i").classList.remove("bi-heart");
	                button.querySelector("i").classList.add("bi-heart-fill");
	            }
	        },
	        error: function () {
	            // 오류 메시지 표시
	            alert("오류가 발생했습니다. 다시 시도해주세요.");
	        }
	    });
	}

	</script>
</body>
</html>





