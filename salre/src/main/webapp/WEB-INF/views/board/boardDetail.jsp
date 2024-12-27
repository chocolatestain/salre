<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>게시판 상세보기</title>
</head>
<body>
	<!-- =======================
	Page content START -->
	<section class="pt-0">
		<div class="container">
			<div class="row">
				<!-- Left sidebar START -->
				<div class="col-xl-3">
					<!-- Responsive offcanvas body START -->
					<div class="offcanvas-xl offcanvas-end" tabindex="-1" id="offcanvasSidebar">
						<!-- Offcanvas header -->
						<div class="offcanvas-header bg-light">
							<h5 class="offcanvas-title" id="offcanvasNavbarLabel">My profile</h5>
							<button  type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-target="#offcanvasSidebar" aria-label="Close"></button>
						</div>
						<!-- Offcanvas body -->
						<div class="offcanvas-body p-3 p-xl-0">
							<div class="bg-dark border rounded-3 pb-0 p-3 w-100">
								<!-- Dashboard menu -->
								<div class="list-group list-group-dark list-group-borderless">
									<a class="list-group-item" href="${contextPath}/board/list"><i class="bi bi-pencil-square fa-fw me-2"></i>공지사항</a>
									<a class="list-group-item" href=""><i class="bi bi-pencil-square fa-fw me-2"></i>자유게시판</a>
								</div>
							</div>
						</div>
					</div>
					<!-- Responsive offcanvas body END -->
				</div>
				<!-- Left sidebar END -->
				
				<!-- Main content START -->
				<div class="col-xl-9">
					<!-- 게시판 상세보기 START -->
					<div class="card bg-transparent border rounded-3">
						<!-- Card header -->
						<div class="card-header bg-transparent border-bottom">
							<h3 class="card-header-title mb-0">${boardDTO.board_title}</h3>
							<span class="me-3 small">작성자</span><span class="me-3 small">${boardDTO.created_at}</span><span class="me-3 small">조회 ${boardDTO.click_cnt}</span><span class="small float-end">댓글 수</span>
						</div>
						<!-- Card body START -->
						<div class="card-body">
						
							<!-- 게시글 내용 -->
							<div class="bg-body border rounded-bottom h-400px overflow-hidden p-2">
								${boardDTO.board_content}
							</div>
							
							<!-- 댓글 -->
							<div class="mt-4">
								<div class="mb-3 d-sm-flex justify-content-sm-between align-items-center">
									<!-- Title -->
									<div>
										<h5 class="m-0">Frances Guerrero</h5>
										<span class="me-3 small">June 11, 2021 at 6:01 am </span>
									</div>
								</div>
								<!-- Content -->
								<h6><span class="text-body fw-light">Review on:</span> How to implement sitemap on sass</h6>
								<p>Satisfied conveying a dependent contented he gentleman agreeable do be. Warrant private blushes removed an in equally totally if. Delivered dejection necessary objection do Mr prevailed. Mr feeling does chiefly cordial in do. </p>
								<!-- Button -->
								<div class="text-end">
									<a class="btn btn-sm btn-light mb-0" data-bs-toggle="collapse" href="#collapseComment" role="button" aria-expanded="false" aria-controls="collapseComment">
										댓글 달기
									</a>
									<!-- 댓글 등록 -->
									<div class="collapse show" id="collapseComment">
										<div class="d-flex mt-3">
											<textarea class="form-control mb-0" placeholder="댓글을 남겨보세요" rows="2" spellcheck="false"></textarea>
											<button class="btn btn-sm btn-primary-soft ms-2 px-4 mb-0 flex-shrink-0"><i class="fas fa-paper-plane fs-5"></i></button>
										</div>
									</div>
								</div>
							</div>
							
							<!-- Button -->
							<div class="d-flex justify-content-end mt-4">
								<a href="${contextPath}/board/list" class="btn btn-primary">목록</a>
								<a href="" class="btn btn-success ms-2">수정</a>
								<a href="${contextPath}/board/delete?board_id=${boardDTO.board_id}" class="btn btn-danger ms-2">삭제</a>
							</div>
						</div>
						<!-- Card body END -->
					</div>
					<!-- 게시판 상세보기 END -->
				</div>
				<!-- Main content END -->
			</div>
			<!-- Row END -->
		</div>
	</section>
	<!-- =======================
	Page content END -->
	
	<!-- Back to top -->
	<div class="back-top"><i class="bi bi-arrow-up-short position-absolute top-50 start-50 translate-middle"></i></div>
	
	<!-- Bootstrap JS -->
	<script src="${contextPath}/resources/bootstrap/assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- Vendors -->
	<script src="${contextPath}/resources/bootstrap/assets/vendor/choices/js/choices.min.js"></script>
	
	<!-- Template Functions -->
	<script src="${contextPath}/resources/bootstrap/assets/js/functions.js"></script>
</body>
</html>