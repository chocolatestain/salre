<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>게시판 상세보기</title>
	
	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
							<span class="me-3 small">${boardDTO.writer}</span><span class="me-3 small">${boardDTO.created_at}</span><span class="me-3 small">조회 ${boardDTO.click_cnt}</span><span class="small float-end">댓글 수 "추가"</span>
						</div>
						<!-- Card body START -->
						<div class="card-body">
						
							<!-- 게시글 내용 -->
							<div class="bg-body border rounded-bottom h-400px overflow-y-auto p-2">
								${boardDTO.board_content}
							</div>
							
							<!-- 댓글 -->
							<div class="mt-4">
								<div class="mb-3 d-sm-flex justify-content-sm-between align-items-center">
									<!-- Title -->
									<div>
										<h6 class="m-0">Frances Guerrero</h6>
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
											<textarea id="comment_content" class="form-control mb-0" placeholder="댓글을 남겨보세요" rows="2" spellcheck="false"></textarea>
											<button onclick="doCheck(commentRegister)" class="btn btn-sm btn-primary-soft ms-2 px-4 mb-0 flex-shrink-0"><i class="fas fa-paper-plane fs-5"></i></button>
										</div>
									</div>
								</div>
							</div>
							
							<!-- Button -->
							<div class="d-flex justify-content-end mt-4">
								<a href="${contextPath}/board/list" class="btn btn-primary">목록</a>
								<a href="${contextPath}/board/update?board_id=${boardDTO.board_id}" class="btn btn-success ms-2">수정</a>
								<button onclick="javascript:doDelete(${boardDTO.board_id})" class="btn btn-danger ms-2">삭제</button>
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
	
	<!-- 게시글 삭제 -->
	<script type="text/javascript">
		function doDelete(board_id) {
			const msg = confirm("작성한 글을 삭제하시겠습니까?");
			
			if (msg == true) { // 확인 누를 경우
				location.href = "${contextPath}/board/delete?board_id=" + board_id;
			} else {
				return false; // 삭제 취소
			}
		}
	</script>
	
	<!-- 댓글 등록 -->
	<script type="text/javascript">
		// 콜백 함수로 댓글 등록 함수 호출
		function doCheck(callback) {
			/* let content = document.querySelector("#comment_content").value; */
			let comment_content = $('#comment_content').val();
			
			if (comment_content == "") {
				alert("댓글 내용을 입력하시기 바랍니다.");
				$('#comment_content').focus();
				return false;
			}
			
			if (calBytes(comment_content) > 255) {
	            alert("최대 255Bytes까지 입력 가능합니다.");
	            $('#comment_content').focus();
	            return false;
	        }
			
			callback(); // 유효성 검사 후 댓글 등록
		}
		
		// 글자 길이 바이트 단위로 체크하기(바이트값 전달)
        function calBytes(str) {
		    let tcount = 0;  // 최종 바이트 수를 저장할 변수
		    let strCnt = str.length;  // 문자열의 길이 (문자 수)
		
		    let onechar;  // 개별 문자를 저장할 변수
		    for (let i = 0; i < strCnt; i++) {
		        onechar = str.charAt(i);  // 문자열에서 i번째 문자 추출
		
		        // encodeURIComponent를 사용하여 해당 문자의 URL 인코딩된 문자열 길이를 확인
		        // encodeURIComponent로 인코딩된 문자열 길이가 3보다 크면 2바이트 이상으로 인코딩된 문자임
		        if (encodeURIComponent(onechar).length > 1) {
		            tcount += 2;  // 2바이트 이상인 문자로 계산
		        } else {
		            tcount += 1;  // 1바이트 문자로 계산
		        }
		    }
		
		    return tcount;  // 총 바이트 수 반환
		}
		
		// 댓글 등록 함수
		function commentRegister() {
			const board_id = "${boardDTO.board_id}";
			/* const comment_writer = Session 값에서 id 값 */
			/* let content = document.querySelector("#comment_content").value; */
			let comment_content = $('#comment_content').val();
			
			$.ajax({
				url: "${contextPath}/comment/register",
				type: "POST",
				contentType: "application/json",
				data: JSON.stringify({
					board_id: board_id,
					/* comment_writer: comment_writer, */
					comment_content: comment_content
				}),
				success: function(commentDTOList) {
					console.log(commentDTOList);
				},
				error: function(err) {
					alert(err);
				}
			});
		}
	</script>
</body>
</html>