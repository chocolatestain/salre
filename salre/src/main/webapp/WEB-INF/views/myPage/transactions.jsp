<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath"
	value="${pageContext.servletContext.contextPath}"></c:set>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>나의 거래현황</title>
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
	width: 100%;
	margin-top: 20px;
}

.card img {
	height: 180px;
	object-fit: cover;
}

.badge-status {
	position: absolute;
	top: 10px;
	right: 10px;
	font-size: 12px;
	padding: 5px 10px;
	border-radius: 10px;
	color: white;
}

.col-md-9 {
	display: block;
	width: 100%;
}
</style>

<!-- CSS -->
<style>
/* 문구가 표시될 컨테이너 */
.moving-text-container {
	position: absolute;
	bottom: 10px;
	left: 0;
	width: 100%;
	overflow: hidden;
	white-space: nowrap;
	background-color: black;
	color: white;
	padding: 5px;
	font-size: 14px;
	box-sizing: border-box;
}

/* 애니메이션이 적용된 텍스트 */
.moving-text {
	display: inline-block;
	padding-left: 100%;
	animation: moveText 5s linear infinite;
}

/* 애니메이션 정의 */
@keyframes moveText {
    0% {
        transform: translateX(100%);
    }
    100% {
        transform: translateX(-100%);
    }
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
				<h1 class="mb-4">My Page - 나의 거래현황</h1>

				<!-- 구매자 콘텐츠 -->
				<!-- <div id="buyer-content">
					<div class="row mb-3">
						<div class="col">
							<button class="btn btn-secondary">등록순</button>
							<button class="btn btn-secondary">거래순</button>
							<button class="btn btn-secondary">조회수 순</button>
							<button class="btn btn-secondary">평점 순</button>
						</div>
						<div class="col text-end">
							<input type="date" class="form-control d-inline-block w-auto"
								id="startDate"> <span>~</span> <input type="date"
								class="form-control d-inline-block w-auto" id="endDate">
						</div>
					</div> -->


					<!-- 거래 매물 목록 -->
					<div class="card-container">

				   <c:forEach var="item" items="${transactionItems}">
                    <div class="card">
                        <div class="position-relative">
                            <img src="${item.image}" class="card-img-top" alt="${item.title}">
                            <!-- 상태 배지 -->
                            <c:choose>
                                <c:when test="${item.status == '거래중'}">
                                    <span class="badge-status bg-danger">거래중</span>
                                </c:when>
                                <c:when test="${item.status == '거래완료'}">
                                    <span class="badge-status bg-secondary">거래완료</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge-status bg-success">거래가능</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">${item.title}</h5>
                            <p class="card-text">
                                월세: ${item.monthlyRent} / ${item.deposit}<br>
                                ${item.description}
                            </p>
                            <div class="d-flex justify-content-between align-items-center">
                                <a href="${contextPath}/item/detail?id=${item.id}" class="btn btn-primary">자세히 보기</a>
                                <button class="btn btn-outline-danger">리뷰작성</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>

						<!-- 예시 데이터 -->
						<div class="card">
							<div class="position-relative">
								<img src="https://via.placeholder.com/250x180"
									class="card-img-top" alt="매물1"> <span
									class="badge-status bg-danger">거래중</span>
								<!-- 입주일 문구 -->
								<div class="moving-text-container">
									<span class="moving-text">입주일까지 17일 남았습니다.</span>
								</div>
							</div>
							<div class="card-body">
								<h5 class="card-title">오픈형 원룸</h5>
								<p class="card-text">
									월세: 4,000 / 25<br>서울시 강남구...
								</p>
								<div class="d-flex justify-content-between align-items-center">
									<a href="#" class="btn btn-primary">자세히 보기</a>

								</div>
							</div>
						</div>

						<div class="card">
							<div class="position-relative">
								<img src="https://via.placeholder.com/250x180"
									class="card-img-top" alt="매물2"> <span
									class="badge-status bg-secondary">거래완료</span>
							</div>
							<div class="card-body">
								<h5 class="card-title">투룸</h5>
								<p class="card-text">
									월세: 5,000 / 15<br>경기도 수원시...
								</p>
								<div class="d-flex justify-content-between align-items-center">
									<a href="#" class="btn btn-primary">자세히 보기</a>
									<button class="btn btn-outline-danger" 
							            data-bs-toggle="modal" 
							            data-bs-target="#reviewModal" 
							        >리뷰작성
							    </button>
								</div>
							</div>
						</div>
 
					</div>
				</div>
 
				
				<!-- 판매자 콘텐츠 -->
				<div id="seller-content" style="text-align: center;">
						<div class="row mb-3">
						<div class="col">
							<button class="btn btn-secondary">등록순</button>
							<button class="btn btn-secondary">거래순</button>
							<button class="btn btn-secondary">조회수 순</button>
							<button class="btn btn-secondary">평점 순</button>
						</div>
						<div class="col text-end">
							<input type="date" class="form-control d-inline-block w-auto"
								id="startDate"> <span>~</span> <input type="date"
								class="form-control d-inline-block w-auto" id="endDate">
						</div>
					</div>


					<!-- 거래 매물 목록 -->
					<div class="card-container">
 				 <c:forEach var="item" items="${transactionItems}">
                    <div class="card">
                        <div class="position-relative">
                            <img src="${item.image}" class="card-img-top" alt="${item.title}">
                            <!-- 상태 배지 -->
                            <c:choose>
                                <c:when test="${item.status == '거래중'}">
                                    <span class="badge-status bg-danger">거래중</span>
                                </c:when>
                                <c:when test="${item.status == '거래완료'}">
                                    <span class="badge-status bg-secondary">거래완료</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge-status bg-success">거래가능</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">${item.title}</h5>
                            <p class="card-text">
                                월세: ${item.monthlyRent} / ${item.deposit}<br>
                                ${item.description}
                            </p>
                            <div class="d-flex justify-content-between align-items-center">
                                <a href="${contextPath}/item/detail?id=${item.id}" class="btn btn-primary">자세히 보기</a>
                                <button class="btn btn-outline-danger">리뷰작성</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>

						<!-- 예시 데이터 -->
						<div class="card">
							<div class="position-relative">
								<img src="https://via.placeholder.com/250x180"
									class="card-img-top" alt="매물1"> <span
									class="badge-status bg-danger">거래중</span>
								<!-- 입주일 문구 -->
								<div class="moving-text-container">
									<span class="moving-text">입주일까지 17일 남았습니다.</span>
								</div>
							</div>
							<div class="card-body">
								<h5 class="card-title">오픈형 원룸</h5>
								<p class="card-text">
									월세: 4,000 / 25<br>서울시 강남구...
								</p>
								<div class="d-flex justify-content-between align-items-center">
									<a href="#" class="btn btn-primary">자세히 보기</a>

								</div>
							</div>
						</div>

						<div class="card">
							<div class="position-relative">
								<img src="https://via.placeholder.com/250x180"
									class="card-img-top" alt="매물2"> <span
									class="badge-status bg-secondary">거래완료</span>
							</div>
							<div class="card-body">
								<h5 class="card-title">투룸</h5>
								<p class="card-text">
									월세: 5,000 / 15<br>경기도 수원시...
								</p>
								<div class="d-flex justify-content-between align-items-center">
									<a href="#" class="btn btn-primary">자세히 보기</a>
									
								</div>
							</div>
						</div>

						<div class="card">
							<div class="position-relative">
								<img src="https://via.placeholder.com/250x180"
									class="card-img-top" alt="매물3"> <span
									class="badge-status bg-success">거래가능</span>
							</div>
							<div class="card-body">
								<button class="btn btn-danger">수정하기</button>
								<h5 class="card-title">스튜디오</h5>
								<p class="card-text">
									월세: 3,000 / 20<br>부산시 해운대구...
								</p>
								<div class="d-flex justify-content-between align-items-center">
									<a href="#" class="btn btn-primary">자세히 보기</a>
								</div>
							</div>
						</div>

						<!-- 더미 데이터 추가 -->
						<div class="card">
							<img src="https://via.placeholder.com/250x180"
								class="card-img-top" alt="매물4"><span
								class="badge-status bg-warning">방내놓기</span>
							<div class="card-body">
								<h5 class="card-title"> </h5>
								<p class="card-text">
													<br>
								</p>
								<div class="d-flex justify-content-between align-items-center">
									<!-- <a href="#" class="btn btn-primary">자세히 보기</a> -->
								</div>
							</div>
						</div>
 
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<%@ include file="../common/footer.jsp"%>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>


<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!-- Review Registration Modal -->
<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateModalLabel">후기 작성</h5>

                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="reviewForm">
                    <input type="hidden" id="review_id" name="review_id">
                    <div class="mb-3">
                        <h7>거래는 어떠셨나요? </h7><br>
                        <h7>판매자에 대한 후기를 남겨주세요.</h7><br><br>
                        
                        <label for="review_rate" class="form-label">평점</label>
                        <select id="review_rate" class="form-select" required>
                            <option value="1">★</option>
                            <option value="2">★★</option>
                            <option value="3">★★★</option>
                            <option value="4">★★★★</option>
                            <option value="5">★★★★★</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="review_content" class="form-label">후기 내용</label>
                        <textarea id="review_content" class="form-control" rows="3" required></textarea>
                    </div>
                    <button type="button" class="btn btn-primary" id="submitReview">저장</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    
                </form>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
	<script>
	   // 모달 초기화
    const updateModal = document.getElementById('reviewModal');
    updateModal.addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget; // Trigger 버튼
        const review_id = button.getAttribute('data-review-id');
/*         const reviewRate = button.getAttribute('data-review-rate');
        const reviewContent = button.getAttribute('data-review-content'); */

    // 리뷰 등록 시 review_id는 필요 없으므로 초기화
        document.getElementById('review_id').value = reviewId||''; 
        document.getElementById('review_rate').value = '';
        document.getElementById('review_content').value = '';
    });

 	// 저장 버튼 클릭 이벤트
    document.getElementById('submitReview').addEventListener('click', function () {
        /* const review_id = document.getElementById('review_id').value;  */
        const review_rate = document.getElementById('review_rate').value;
        const review_content = document.getElementById('review_content').value;
        console.log(review_rate);
        console.log(review_content);

        // AJAX 요청
        $.ajax({
            url: `${contextPath}/transactions/registerReview`,
            type: 'POST',
            data: {
            	/* review_id: review_id, */
                review_rate: review_rate,
                review_content: review_content
            },
            success: function (response) {
                if (response.success) {
                    alert('후기가 성공적으로 등록되었습니다.');
                    location.reload(); // 페이지 새로고침
                } else {
                    alert(response.message|| '후기 등록에 실패하였습니다.');
                }
            },
            error: function () {
                alert('서버 오류가 발생했습니다.');
            }
        });
    });
   
	/* 토글스위치 동작(구매자-판매자) */
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
	
</body>
</html>
