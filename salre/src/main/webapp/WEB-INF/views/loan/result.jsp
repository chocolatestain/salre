<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <% String ageParam=request.getParameter("age"); String incomeParam=request.getParameter("income"); int age=0; if
            (ageParam !=null && !ageParam.isEmpty()) { age=Integer.parseInt(ageParam); } int income=0; if
            (incomeParam.equals("3500l")) { income=35000000; } else if (incomeParam.equals("5000l")) { income=50000000;
            } else { income=Integer.MAX_VALUE; } %>
            <!DOCTYPE html>
            <html lang="ko">

            <head>
                <link rel="icon" href="${pageContext.request.contextPath}/resources/favicon.ico" type="image/x-icon">
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>살래?</title>
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        margin: 0;
                        padding: 0;
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

                    header .auth a {
                        margin-left: 15px;
                        padding: 10px 20px;
                        background-color: #f4a261;
                        color: #fff;
                        border-radius: 5px;
                        text-decoration: none;
                    }

                    .main-banner {
                        padding: 40px;
                        background: #f5f5f5;
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                    }

                    .controls {
                        display: flex;
                        justify-content: space-between;
                        width: 100%;
                        max-width: 1200px;
                        margin-bottom: 30px;
                    }

                    .controls button {
                        background-color: #f5f5f5;
                        border: none;
                        cursor: pointer;
                        font-size: 2rem;
                    }

                    .sort {
                        display: flex;
                        justify-content: space-between;
                        width: 100%;
                        max-width: 1200px;
                        margin-bottom: 30px;
                    }

                    .sort-buttons {
                        display: flex;
                        gap: 10px;
                    }

                    .sort button {
                        padding: 10px 20px;
                        background-color: #666;
                        color: #fff;
                        border: none;
                        border-radius: 5px;
                        cursor: pointer;
                        font-size: 1rem;
                    }

                    .sort button.active {
                        background-color: #455F9E;
                    }

                    .sort-result {
                        display: flex;
                        align-items: center;
                        font-size: 1.25rem;
                        color: #333;
                    }

                    .container {
                        width: 100%;
                        max-width: 1200px;
                        display: flex;
                        flex-direction: space-between;
                        gap: 30px;
                    }

                    .main-banner h1 {
                        font-size: 2.5rem;
                        color: #333;
                    }

                    .main-banner h2 {
                        font-size: 1.25rem;
                        color: #666;
                        margin-bottom: 2rem;
                    }

                    .filter-section {
                        display: flex;
                        gap: 20px;
                        height: 100%;
                    }

                    .filters {
                        background: #fff;
                        padding-left: 20px;
                        padding-right: 20px;
                        padding-bottom: 20px;
                        border-radius: 10px;
                        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                        width: 250px;
                    }

                    .filters input[type="range"] {
                        width: 100%;
                    }

                    .filters h3 {
                        margin-bottom: 10px;
                        color: #333;
                    }

                    .filters button {
                        padding: 10px 20px;
                        margin-top: 10px;
                        background-color: #455F9E;
                        color: #fff;
                        border: none;
                        border-radius: 5px;
                        cursor: pointer;
                        font-size: 1rem;
                        width: 100%
                    }

                    .loan-results {
                        display: grid;
                        grid-template-columns: repeat(2, 2fr);
                        gap: 20px;
                        width: 100%;
                        max-width: 1200px;
                    }

                    .loan-card {
                        background: #fff;
                        border-radius: 10px;
                        padding: 20px;
                        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                        transition: transform 0.2s;
                    }

                    .loan-card:hover {
                        transform: translateY(-5px);
                        background-color: #d1d1d1;
                    }

                    .loan-card h4 {
                        color: #333;
                        margin-bottom: 10px;
                    }

                    .loan-card p {
                        color: #666;
                        margin: 5px 0;
                    }

                    .pagination {
                        display: flex;
                        justify-content: center;
                        gap: 10px;
                        margin-top: 30px;
                    }

                    .pagination button {
                        padding: 10px 20px;
                        background: #455F9E;
                        color: #fff;
                        border: none;
                        cursor: pointer;
                        border-radius: 5px;
                    }

                    .pagination span {
                        font-size: 1rem;
                        padding: 10px;
                    }

                    footer {
                        display: flex;
                        justify-content: space-around;
                        background-color: #222;
                        color: #fff;
                        padding: 20px 0;
                    }

                    footer div {
                        text-align: left;
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
                        <a href="main">대출상품</a> <a href="#">채팅</a> <a href="#">게시판</a> <a href="#">매물</a> <a
                            href="#">관심매물</a> <a href="#">방내놓기</a>
                    </nav>
                    <div class="auth">
                        <a href="login.jsp">로그인</a> <a href="register.jsp">회원가입</a>
                    </div>
                </header>

                <!-- Main Banner -->
                <section class="main-banner">
                    <h1>대출 조회결과</h1>
                    <h2>나에게 딱 맞는 대출을 가져왔어요</h2>

                    <!-- Controls -->
                    <div class="controls">
                        <button onclick="history.back()">👈</button>
                    </div>

                    <div class="sort">
                        <div class="sort-buttons">
                            <button id="sortRate">금리순</button>
                            <button id="sortLimit">한도순</button>
                        </div>
                        <div class="sort-result">
                            <span>${loanList.size()}개 조회 완료</span>
                        </div>
                    </div>

                    <div class="container">
                        <div class="filter-section">
                            <div class="filters">
                                <h3>금리</h3>
                                <input type="range" min="1" max="5" value="5" step="0.1">
                                <hr>
                                <h3>한도</h3>
                                <input type="range" min="1" max="5" value="5" step="1">
                                <hr>
                                <h3>은행</h3>
                                <label><input type="checkbox"> BNK 경남은행</label> <br>
                                <label><input type="checkbox"> IBK 기업은행</label> <br>
                                <label><input type="checkbox"> iM 뱅크</label> <br>
                                <label><input type="checkbox"> KB 국민은행</label> <br>
                                <label><input type="checkbox"> NH 농협은행</label> <br>
                                <label><input type="checkbox"> SC 제일은행</label> <br>
                                <label><input type="checkbox"> Sh 수협은행</label> <br>
                                <label><input type="checkbox"> 광주은행</label> <br>
                                <label><input type="checkbox"> 신한은행</label> <br>
                                <label><input type="checkbox"> 우리은행</label> <br>
                                <label><input type="checkbox"> 제주은행</label> <br>
                                <label><input type="checkbox"> 카카오뱅크</label> <br>
                                <label><input type="checkbox"> 케이뱅크</label> <br>
                                <label><input type="checkbox"> 토스뱅크</label> <br>
                                <label><input type="checkbox"> 하나은행</label> <br>
                                <hr>
                                <h3>정책지원 대출</h3>
                                <label><input type="checkbox"> 중소기업 재직자 대상</label> <br>
                                <label><input type="checkbox"> 청년 대상</label>
                                <hr>
                                <button>필터 적용</button>
                            </div>
                        </div>

                        <div class="loan-results" id="loanResults">
                            <c:forEach var="item" items="${loanList}">
                                <div class="loan-card">
                                    <h3>${item.loan_name}</h3>
                                    <h4>${item.bank_name}</h4>
                                    <hr>
                                    <p>기준금리: ${item.loan_rate}%</p>
                                    <p>최대한도: ${item.loan_limit}원</p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="pagination" id="pagination"></div>
                </section>

                <!-- Footer -->
                <footer>
                    <div>
                        <h3>형태 별 검색</h3>
                        <p>
                            전세<br>월세<br>아파트<br>빌라<br>상가
                        </p>
                    </div>
                    <div>
                        <h3>고객 지원</h3>
                        <a href="#">자주 묻는 질문(FAQ)</a><br> <a href="#">Android</a><br>
                        <a href="#">iOS</a>
                    </div>
                    <div>
                        <h3>저희 회사는</h3>
                        <a href="#">회사소개</a><br> <a href="#">오시는 길</a><br> <a href="#">제휴문의</a><br> <a
                            href="#">채용</a><br>
                    </div>
                </footer>
                <script>
                    $(document)
                        .ready(
                            function () {
                                // 서버에서 전달된 값 가져오기
                                const userAge = <%=age%>;
                                const userIncome = <%=income%>;

                                // 금리순 버튼이 기본적으로 활성화된 상태
                                $('#sortRate').addClass('active');

                                // 금리순 정렬 버튼 클릭
                                $('#sortRate')
                                    .click(
                                        function () {
                                            // 활성화된 버튼 상태 업데이트
                                            $('#sortRate').addClass(
                                                'active');
                                            $('#sortLimit').removeClass(
                                                'active');

                                            // Ajax 요청 (금리순 정렬)
                                            $
                                                .ajax({
                                                    url: '${pageContext.request.contextPath}/loan/sortByRate',
                                                    type: 'GET',
                                                    data: {
                                                        age: userAge,
                                                        income: userIncome
                                                    },
                                                    success: function (
                                                        response) {
                                                        $(
                                                            '#loanResults')
                                                            .empty();
                                                        response
                                                            .forEach(function (
                                                                item) {
                                                                $(
                                                                    '#loanResults')
                                                                    .append(
                                                                        '<div class="loan-card">'
                                                                        + '<h3>'
                                                                        + item.loan_name
                                                                        + '</h3>'
                                                                        + '<h4>'
                                                                        + item.bank_name
                                                                        + '</h4>'
                                                                        + '<hr>'
                                                                        + '<p>기준금리: '
                                                                        + item.loan_rate
                                                                        + '%</p>'
                                                                        + '<p>최대한도: '
                                                                        + item.loan_limit
                                                                        + '원</p>'
                                                                        + '</div>');
                                                            });
                                                    }
                                                });
                                        });

                                // 한도순 정렬 버튼 클릭
                                $('#sortLimit')
                                    .click(
                                        function () {
                                            // 활성화된 버튼 상태 업데이트
                                            $('#sortLimit').addClass(
                                                'active');
                                            $('#sortRate').removeClass(
                                                'active');

                                            // Ajax 요청 (한도순 정렬)
                                            $
                                                .ajax({
                                                    url: '${pageContext.request.contextPath}/loan/sortByLimit',
                                                    type: 'GET',
                                                    data: {
                                                        age: userAge,
                                                        income: userIncome
                                                    },
                                                    success: function (
                                                        response) {
                                                        $(
                                                            '#loanResults')
                                                            .empty();
                                                        response
                                                            .forEach(function (
                                                                item) {
                                                                $(
                                                                    '#loanResults')
                                                                    .append(
                                                                        '<div class="loan-card">'
                                                                        + '<h3>'
                                                                        + item.loan_name
                                                                        + '</h3>'
                                                                        + '<h4>'
                                                                        + item.bank_name
                                                                        + '</h4>'
                                                                        + '<hr>'
                                                                        + '<p>기준금리: '
                                                                        + item.loan_rate
                                                                        + '%</p>'
                                                                        + '<p>최대한도: '
                                                                        + item.loan_limit
                                                                        + '원</p>'
                                                                        + '</div>');
                                                            });
                                                    }
                                                });
                                        });
                            });
                </script>
            </body>

            </html>