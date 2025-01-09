<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico" type="image/x-icon" />
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>살래?</title>

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

            .main-banner>div {
                width: 100%;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }

            .form-box {
                background-color: white;
                padding: 2rem;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                max-width: 400px;
                width: 100%;
                text-align: left;
            }

            .main-banner h1 {
                font-size: 2.5rem;
                color: #333;
            }

            .main-banner h2 {
                font-size: 1.25rem;
                color: #666;
                margin-bottom: 3rem;
            }

            .form-box h3 {
                margin: 0 auto;
                font-size: 1.25rem;
                padding-bottom: 1.5rem;
            }

            input,
            select,
            button {
                width: 100%;
                padding: 0.75rem;
                margin: 1rem 0;
                font-size: 1rem;
                border-radius: 5px;
                border: 1px solid #ccc;
                box-sizing: border-box;
            }

            button {
                background-color: #455f9e;
                color: white;
                cursor: pointer;
                border: none;
            }

            button:hover {
                background-color: #2c3562;
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
                <a href="main">대출상품</a> <a href="#">채팅</a> <a href="#">게시판</a>
                <a href="#">매물</a> <a href="#">관심매물</a>
                <a href="#">방내놓기</a>
            </nav>
            <div class="auth">
                <a href="login.jsp">로그인</a> <a href="register.jsp">회원가입</a>
            </div>
        </header>

        <!-- Main Banner -->
        <section class="main-banner">
            <div>
                <h1>대출 맞춤비교</h1>
                <h2>나에게 딱 맞는 대출을 찾아드려요</h2>

                <div class="form-box">
                    <form action="result" method="POST" onsubmit="return validateForm()">
                        <h3>
                            <label for="age">나이</label>
                            <input type="number" name="age" min="19" max="100" placeholder="만 나이 입력" />
                            <label for="income">연 소득</label>
                            <select name="income">
                                <option value="3500l">3500만원 이하</option>
                                <option value="5000l">5000만원 이하</option>
                                <option value="5000h">5000만원 이상</option>
                            </select>
                            <label for="product_type">매물유형</label>
                            <select name="product_type">
                                <option value="month">월세</option>
                                <option value="2year">전세</option>
                            </select>
                        </h3>
                        <button type="submit">조회</button>
                    </form>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer>
            <div>
                <h3>형태 별 검색</h3>
                <p>전세<br />월세<br />아파트<br />빌라<br />상가</p>
            </div>
            <div>
                <h3>고객 지원</h3>
                <a href="#">자주 묻는 질문(FAQ)</a><br />
                <a href="#">Android</a><br />
                <a href="#">iOS</a>
            </div>
            <div>
                <h3>저희 회사는</h3>
                <a href="#">회사소개</a><br />
                <a href="#">오시는 길</a><br />
                <a href="#">제휴문의</a><br />
                <a href="#">채용</a><br />
            </div>
        </footer>

        <script>
            function validateForm() {
                var age = document.querySelector('input[name="age"]').value;

                if (!age) {
                    alert("나이를 입력해주세요");

                    return false;
                }
            }
        </script>
    </body>

    </html>