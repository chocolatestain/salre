<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"></c:set>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>나의 거래후기</title>
<!-- Bootstrap CSS -->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
    rel="stylesheet">
<style>
/* 전체 배경 */
body {
    background-color: #f8f9fa;
}

/* 테이블 컨테이너 */
.table-container {
    background-color: #ffffff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    margin-top: 20px;
}

/* 테이블 헤더 스타일 */
.table th {
    background-color: #f1f1f1;
    color: #333;
    text-align: center;
    font-weight: bold;
}

/* 테이블 본문 스타일 */
.table tbody tr:hover {
    background-color: #f5f5f5;
    cursor: pointer;
}

/* 테이블 본문 텍스트 정렬 */
.table td {
    text-align: center;
    vertical-align: middle;
}

/* 버튼 스타일 */
.table .btn-primary {
    background-color: #007bff;
    border-color: #007bff;
}

.table .btn-primary:hover {
    background-color: #0056b3;
    border-color: #0056b3;
}
</style>
</head>
<body>

<%@ include file="../common/header.jsp" %>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <%@ include file="../common/sidebar.jsp" %>

        <!-- Main Content -->
        <div class="col-md-9">
            <h1 class="mb-4">My Page - 나의 거래후기</h1>
            <br>
            
            <h2>내가 작성한 후기</h2>

            <!-- 작성한 글 테이블 -->
            <div class="table-container">
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>매물번호</th>
                            <th>판매자 ID</th>
                            <th>평점</th>
                            <th>후기내용</th>
                            <th>수정</th>
                            <th>삭제</th>
                       
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 서버에서 데이터를 받아오는 부분 -->
                        <c:forEach var="post" items="${postList}">
                            <tr onclick="redirectToDetail('${contextPath}/post/detail?id=${post.id}')">
                                <td>${post.id}</td>
                                <td>${post.title}</td>
                                <td>${post.content}</td>
                                <td>${post.date}</td>
                                <td>
                                    <a href="${contextPath}/post/detail?id=${post.id}" class="btn btn-primary btn-sm">View</a>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <!-- 더미 데이터 (테스트용) -->
                        <tr onclick="redirectToDetail('#')">
                            <td>20241010</td>
                            <td>치와와</td>
                            <td>별별별별별</td>
                            <td>월세를 깎아주셔서 감사했어요.</td>
                            
                             <td>
                                <a href="#" class="btn btn-primary btn-sm">수정</a>
                            </td>
                            <td>
                                <a href="#" class="btn btn-danger btn-sm">삭제</a>
                            </td>
                            
                             <!-- 더미 데이터 (테스트용) -->
                        <tr onclick="redirectToDetail('#')">
                            <td>20241210</td>
                            <td>리트리버</td>
                            <td>별</td>
                            <td>계약끝났는데 돈없다며 보증금 안돌려주고 배째라고 함.</td>
                            
                             <td>
                                <a href="#" class="btn btn-primary btn-sm">수정</a>
                            </td>
                            <td>
                                <a href="#" class="btn btn-danger btn-sm">삭제</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<!-- JavaScript -->
<script>
    function redirectToDetail(url) {
        window.location.href = url;
    }
</script>
</body>
</html>
