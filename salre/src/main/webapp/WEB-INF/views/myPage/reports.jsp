<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"></c:set>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>나의 신고내역</title>
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
            <h1 class="mb-4">My Page - 나의 신고내역</h1>

            <!-- 작성한 글 테이블 -->
            <div class="table-container">
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>신고분류</th>
                            <th>신고내용</th>
                            <th>신고일자</th>
                            <th>처리결과</th>
                       
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 서버에서 데이터를 받아오는 부분 -->
                        <c:forEach var="report" items="${reportList}">
                        <tr>
                            <%-- <tr onclick="redirectToDetail('${contextPath}/post/detail?id=${post.id}')"> --%>
                               <%--  <td>${report.user_id}</td>
                                <td>${report.product_id}</td> --%>
                                <td>${report.report_class}</td>
                                <td>${report.report_content}</td>
                                <td>컬럼만들어야함</td>
                                <td>
                                    <a href="${contextPath}/report/detail?id=${report.user_id}" class="btn btn-primary btn-sm">View</a>
                                </td>
                        </tr>
                            <!-- </tr> -->
                        </c:forEach>
                          <!-- 데이터가 없을 경우 -->
                        <c:if test="${empty reportList}">
                            <tr>
                                <td colspan="6">신고한 내역이 없습니다.</td>
                            </tr>
                        </c:if>
                        
                        <!-- 더미 데이터 (테스트용) -->
      			  <!--  <tr onclick="redirectToDetail('#')">
                            <td>욕설</td>
                            <td>직접적인 욕설을 사용하여 타인에게 모욕감을 줌</td>
                            <td>2024.12.24</td>
                            <td>
                                <a href="#" class="btn btn-primary btn-sm">View</a>
                            </td>
                        </tr> -->
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
