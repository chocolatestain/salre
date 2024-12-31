<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                    padding: 10px 15px;
                    background-color: #666;
                    color: #fff;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    font-size: 1rem;
                }

                #init {
                    background-color: #999;
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

                .filters-section {
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

                .filters-display {
                    display: flex;
                    align-items: baseline;
                    justify-content: space-between;
                }

                .filters input[type="range"] {
                    width: 100%;
                }

                .filters h3 {
                    margin-bottom: 10px;
                    color: #333;
                }

                .selectControl {
                    padding: 5px 10px;
                    margin-top: 10px;
                    background-color: #999;
                    color: #fff;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    font-size: 0.75rem;
                }

                #filter {
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
                    align-items: start;
                    align-content: start;
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
                    border: none;
                    cursor: pointer;
                    text-align: left;
                    max-height: 200px;
                }

                .loan-card:hover {
                    transform: translateY(-5px);
                    background-color: #d1d1d1;
                }

                .loan-card-content {
                    display: flex;
                    align-items: center;
                    gap: 15px;
                }

                .bank-logo {
                    width: 64px;
                    flex-shrink: 0;
                }

                .loan-card-text {
                    display: flex;
                    flex-direction: column;
                    gap: 5px;
                }

                .loan-card-text h3,
                .loan-card-text h4 {
                    margin: 0;
                    color: #333;
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

                #scroll {
                    position: fixed;
                    bottom: 30px;
                    right: 30px;
                    z-index: 9999;
                    border: none;
                    background-color: #999;
                    cursor: pointer;
                    padding: 10px;
                    border-radius: 10px;
                    font-size: 2rem;
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
                    <button onclick="history.back()">⬅️</button>
                </div>

                <div class="sort">
                    <div class="sort-buttons">
                        <button id="sortRate">금리순</button>
                        <button id="sortLimit">한도순</button>
                        <button id="init">필터 초기화</button>
                    </div>
                    <div class="sort-result">
                        <span id="resultValue"></span>
                    </div>
                </div>

                <datalist id="markers">
                    <option value="1"></option>
                    <option value="2"></option>
                    <option value="3"></option>
                    <option value="4"></option>
                    <option value="5"></option>
                </datalist>

                <div class="container">
                    <div class="filters-section">
                        <div class="filters">
                            <div class="filters-display">
                                <h3>금리</h3>
                                <span>
                                    <span id="rate">5</span>%
                                </span>
                            </div>
                            <input type="range" min="1" max="5" step="0.1" value="5" list="markers"
                                oninput="document.getElementById('rate').innerHTML=this.value;">
                            <br><br>
                            <hr>
                            <div class="filters-display">
                                <h3>한도</h3>
                                <span>
                                    <span id="limit">5</span>억원
                                </span>
                            </div>
                            <input type="range" step="1" min="1" max="5" value="5" list="markers"
                                oninput="document.getElementById('limit').innerHTML=this.value;">
                            <br><br>
                            <hr>
                            <div class="filters-display">
                                <h3>은행</h3>
                                <div>
                                    <button id="selectAll" class="selectControl">전체 선택</button>
                                    <button id="deselectAll" class="selectControl">전체 해제</button>
                                </div>
                            </div>
                            <span id="bank"></span>
                            <br>
                            <hr>
                            <div class="filters-display">
                                <h3>정책지원 대출</h3>
                            </div>
                            <label><input type="checkbox" id="option1" checked> 중소기업 재직자 대상</label> <br>
                            <label><input type="checkbox" id="option2" checked> 청년 대상</label>
                            <br><br>
                            <hr>
                            <button id="filter">필터 적용</button>
                        </div>
                    </div>

                    <div class="loan-results" id="loanResults"></div>
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
                    <a href="#">회사소개</a><br> <a href="#">오시는 길</a><br> <a href="#">제휴문의</a><br> <a href="#">채용</a><br>
                </div>
            </footer>

            <button onclick="scrollToTop()" id="scroll">⬆️</button>

            <script>
                $(document).ready(function () {
                    // 서버에서 전달된 값 가져오기
                    const userAge = ${ param.age };

                    const paramIncome = "${ param.income }";
                    const incomeValue = {
                        step: {
                            "3500l": 35000000,
                            "5000l": 50000000
                        }
                    };
                    const userIncome = incomeValue.step[paramIncome] || Number.MAX_VALUE;

                    // 필터 조건 정의
                    const filters = {
                        byRate: (item, rate) => item.loan_rate <= parseFloat(rate),
                        byLimit: (item, limit) => item.loan_limit / 100000000 <= parseFloat(limit),
                        byBank: (item, banks) => banks.length === 0 || banks.includes(item.bank_name),
                        byOption1: (item, isChecked) => isChecked ? true : !item.loan_name.includes("중소기업청년"),
                        byOption2: (item, isChecked) => isChecked ? true : !item.loan_name.includes("버팀목")
                    };

                    var bankObj = {
                        "BNK경남은행": "bnk_logo.png", "BNK부산은행": "bnk_logo.png", "IBK기업은행": "ibk_logo.png", "iM뱅크": "im_logo.png",
                        "KB국민은행": "kb_logo.png", "NH농협은행": "nh_logo.png", "SC제일은행": "sc_logo.png", "Sh수협은행": "sh_logo.png",
                        "광주은행": "gj_logo.png", "신한은행": "shinhan_logo.png", "우리은행": "woori_logo.png", "제주은행": "jeju_logo.png",
                        "카카오뱅크": "kakao_logo.png", "케이뱅크": "kbank_logo.png", "토스뱅크": "toss_logo.png", "하나은행": "hana_logo.png"
                    };

                    Object.entries(bankObj).forEach(function ([bank_name, bank_logo]) {
                        let bankLabel = `<label><input type="checkbox" name="bank" value="\${bank_name}" checked> \${bank_name}</label> <br>`;

                        $('#bank').append(bankLabel);
                    });

                    function preloadImages() {
                        Object.values(bankObj).forEach(logo => {
                            const img = new Image();
                            img.src = `${pageContext.request.contextPath}/resources/images/\${logo}`;
                        });
                    }

                    let list = [];
                    let view = [];
                    let length = 0;

                    function saveList() {
                        // 초기 데이터 저장
                        sessionStorage.setItem('list', JSON.stringify(list));
                    }

                    function saveView() {
                        // view 저장
                        sessionStorage.setItem('view', JSON.stringify(view));
                    }

                    function draw(view) {
                        $('#loanResults').empty();

                        view.forEach(function (item) {
                            let img = `<img src="${pageContext.request.contextPath}/resources/images/\${bankObj[item.bank_name]}"
                                        alt="\${item.bank_name} 로고" class="bank-logo">`;

                            $('#loanResults').append(`
                                <form action="detail" method="POST">
                                    <input type="hidden" name="id" value="\${item.loan_id}">
                                        <div class="loan-card" onclick="this.closest('form').submit()">
                                            <div class="loan-card-content">
                                                \${img}
                                                <div class="loan-card-text">
                                                    <h3>\${item.loan_name}</h3>
                                                    <h4>\${item.bank_name}</h4>
                                                </div>
                                            </div>
                                            <hr>
                                                <p>기준금리: \${item.loan_rate}%</p>
                                                <p>최대한도: \${item.loan_limit / 100000000}억원</p>
                                                <p>상환방식: \${item.repayment_type}</p>
                                        </div>
                                </form>
                            `);
                        });

                        $('#resultValue').html(`총 \${list.length}개 중 \${length}개 조회 완료`);
                    }

                    // Ajax 요청 함수
                    function ajax(url) {
                        $.ajax({
                            url: url,
                            type: 'GET',
                            data: {
                                age: userAge,
                                income: userIncome
                            },
                            success: function (response) {
                                list = response;
                                view = response;

                                length = view.length;

                                saveList();
                                saveView();

                                draw(view);
                            },
                            error: function (xhr, status, error) {
                                console.log(xhr.responseText);
                            }
                        });
                    }

                    preloadImages();

                    let url = '${pageContext.request.contextPath}/loan/select';

                    // 초기 데이터 불러오기
                    ajax(url);

                    // 금리순 버튼이 기본적으로 활성화된 상태
                    $('#sortRate').addClass('active');

                    // 금리순 정렬 버튼 클릭
                    $('#sortRate').click(function () {
                        // 활성화된 버튼 상태 업데이트
                        $('#sortRate').addClass('active');
                        $('#sortLimit').removeClass('active');

                        view = JSON.parse(sessionStorage.getItem('view')) || [];

                        view.sort(function (a, b) {
                            return a.loan_rate - b.loan_rate;
                        });

                        saveView();

                        draw(view);
                    });

                    // 금리순 정렬 버튼 클릭
                    $('#sortLimit').click(function () {
                        // 활성화된 버튼 상태 업데이트
                        $('#sortLimit').addClass('active');
                        $('#sortRate').removeClass('active');

                        view = JSON.parse(sessionStorage.getItem('view')) || [];

                        view.sort(function (a, b) {
                            return b.loan_limit - a.loan_limit;
                        });

                        saveView();

                        draw(view);
                    });

                    // 전체 선택 기능능
                    function selectAll() {
                        $('input[name="bank"]').each(function () {
                            $(this).prop('checked', true);
                        });

                        $('#option1').prop('checked', true);
                        $('#option2').prop('checked', true);
                    }

                    // 전체 해제 기능
                    function deselectAll() {
                        $('input[name="bank"]').each(function () {
                            $(this).prop('checked', false);
                        });

                        $('#option1').prop('checked', false);
                        $('#option2').prop('checked', false);
                    }

                    $('#selectAll').click(function () {
                        selectAll();
                    });

                    $('#deselectAll').click(function () {
                        deselectAll();
                    });

                    // 필터 조회 버튼 클릭
                    $('#filter').click(function () {
                        // 필터 조건 가져오기
                        const rate = $('#rate').text();
                        const limit = $('#limit').text();
                        const bank = [];
                        const option1 = $('#option1').is(':checked');
                        const option2 = $('#option2').is(':checked');

                        // 은행 체크박스 값 가져오기
                        $('#bank input:checked').each(function () {
                            bank.push($(this).parent().text().trim());
                        });

                        // 활성화된 버튼 상태 업데이트
                        $('#sortRate').addClass('active');
                        $('#sortLimit').removeClass('active');

                        view = JSON.parse(sessionStorage.getItem('list')) || [];

                        // List에서 필터 조건에 맞는 항목 필터링
                        view = view.filter(item =>
                            filters.byRate(item, rate) &&
                            filters.byLimit(item, limit) &&
                            filters.byBank(item, bank) &&
                            filters.byOption1(item, option1) &&
                            filters.byOption2(item, option2)
                        );

                        length = view.length;

                        view.sort(function (a, b) {
                            return a.loan_rate - b.loan_rate;
                        });

                        saveView();

                        // 필터링된 결과 화면에 출력
                        draw(view);
                    });

                    $('#init').click(function () {
                        // 활성화된 버튼 상태 업데이트
                        $('#sortRate').addClass('active');
                        $('#sortLimit').removeClass('active');

                        list = JSON.parse(sessionStorage.getItem('list')) || [];
                        view = JSON.parse(sessionStorage.getItem('list')) || [];

                        length = view.length;

                        list.sort(function (a, b) {
                            return a.loan_rate - b.loan_rate;
                        });

                        // 필터 값 초기화
                        $('#rate').text('5');
                        $('#limit').text('5');
                        $('input[type="range"]').val('5');

                        selectAll();

                        saveList();
                        saveView();

                        draw(list);
                    });
                });

                function scrollToTop() {
                    const position =
                        document.documentElement.scrollTop || document.body.scrollTop;

                    if (position) {
                        window.requestAnimationFrame(() => {
                            window.scrollTo(0, position - position / 10);

                            scrollToTop();
                        });
                    }
                }
            </script>
        </body>

        </html>