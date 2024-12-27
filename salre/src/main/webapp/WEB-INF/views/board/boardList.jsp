<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>게시판 목록</title>
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
			
					<!-- Card START -->
					<div class="card border bg-transparent rounded-3">
						<!-- Card header START -->
						<div class="card-header bg-transparent border-bottom">
							<h3 class="mb-0">공지사항</h3>
						</div>
						<!-- Card header END -->
			
						<!-- Card body START -->
						<div class="card-body">
			
							<!-- Search and select START -->
							<div class="row g-3 align-items-center justify-content-between mb-4">
								<!-- Search -->
								<div class="col-md-8">
									<form class="rounded position-relative">
										<input class="form-control pe-5 bg-transparent" type="search" placeholder="Search" aria-label="Search">
										<button class="bg-transparent p-2 position-absolute top-50 end-0 translate-middle-y border-0 text-primary-hover text-reset" type="submit">
									<i class="fas fa-search fs-6 "></i>
								</button>
									</form>
								</div>
			
								<!-- Select option -->
								<div class="col-md-3">
									<!-- Short by filter -->
									<form>
										<select class="form-select js-choice border-0 z-index-9 bg-transparent" aria-label=".form-select-sm">
											<option value="">Sort by</option>
											<option>Free</option>
											<option>Newest</option>
											<option>Oldest</option>
										</select>
									</form>
								</div>
							</div>
							<!-- Search and select END -->
			
							<!-- Order list table START -->
							<div class="table-responsive border-0">
								<!-- Table START -->
								<table class="table table-dark-gray align-middle p-4 mb-0 table-hover">
									<!-- Table head -->
									<thead>
										<tr>
											<th scope="col" class="border-0 rounded-start">제목</th>
											<th scope="col" class="border-0">작성자</th>
											<th scope="col" class="border-0">작성일</th>
											<th scope="col" class="border-0">댓글 수</th>
											<th scope="col" class="border-0 rounded-end">조회수</th>
										</tr>
									</thead>
			
									<!-- Table body START -->
									<tbody>
										<c:forEach items="${boardList}" var="board">
											<!-- Table item -->
											<tr>
												<!-- Table data -->
												<td>
													<h6 class="table-responsive-title mt-2 mt-lg-0 mb-0"><a href="${contextPath}/board/detail?board_id=${board.board_id}">${board.board_title}</a></h6>
												</td>
												<!-- Table data -->
												<td class="text-center text-sm-start text-primary-hover">
													<a href="#" class="text-body"><u>${board.writer}</u></a>
												</td>
				
												<!-- Table data -->
												<td>${board.created_at}</td>
				
												<!-- Table data -->
												<td>댓글 수</td>
				
												<!-- Table data -->
												<td>${board.click_cnt}</td>
											</tr>
										</c:forEach>
									</tbody>
									<!-- Table body END -->
								</table>
								<!-- Table END -->
							</div>
							<!-- Order list table END -->
			
							<!-- Pagination START -->
							<div class="d-sm-flex justify-content-sm-between align-items-sm-center mt-4 mt-sm-3">
								<!-- Content -->
								<p class="mb-0 text-center text-sm-start">Showing 1 to 8 of 20 entries</p>
								<!-- Pagination -->
								<nav class="d-flex justify-content-center mb-0" aria-label="navigation">
									<ul class="pagination pagination-sm pagination-primary-soft d-inline-block d-md-flex rounded mb-0">
										<li class="page-item mb-0"><a class="page-link" href="#" tabindex="-1"><i class="fas fa-angle-left"></i></a></li>
										<li class="page-item mb-0"><a class="page-link" href="#">1</a></li>
										<li class="page-item mb-0 active"><a class="page-link" href="#">2</a></li>
										<li class="page-item mb-0"><a class="page-link" href="#">3</a></li>
										<li class="page-item mb-0"><a class="page-link" href="#"><i class="fas fa-angle-right"></i></a></li>
									</ul>
								</nav>
							</div>
							<!-- Pagination END -->
							
							<a class="list-item" href="${contextPath}/board/insert"><i class="bi bi-pencil-square fa-fw me-2"></i>글쓰기</a>
						</div>
						<!-- Card body END -->
					</div>
						<!--Card END  -->
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