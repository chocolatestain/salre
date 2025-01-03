<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
					text-align: center;
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

				.form-box {
					background-color: #fff;
					padding: 2rem;
					border-radius: 10px;
					box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
					margin-bottom: 2rem;
					width: 100%;
					max-width: 1200px;
					height: 100%;
					display: flex;
					justify-content: center;
					align-items: center;
					gap: 300px;
				}

				.bank-logo {
					width: 64px;
					flex-shrink: 0;
				}

				.loan-logo {
					width: 200%;
					height: 200%;
					flex-shrink: 0;
					border-radius: 5px;
				}

				.info {
					display: flex;
					flex-direction: column;
					align-items: flex-start;
					justify-content: flex-start;
					text-align: left;
					line-height: 0;
				}

				.info ul {
					padding-left: 20px;
				}

				h1 {
					font-size: 2rem;
					color: #333;
				}

				h2 {
					font-size: 1.5rem;
					color: #666;
					margin-bottom: 2rem;
				}

				.table-box {
					background-color: #fff;
					padding: 2rem;
					border-radius: 10px;
					box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
					margin-bottom: 2rem;
					width: 100%;
					max-width: 1200px;
					height: 100%;
					display: flex;
					justify-content: center;
					align-items: center;
					flex-direction: column;
				}

				.data {
					text-align: left;
				}

				input {
					width: 100%;
					padding: 0.75rem;
					margin: 1rem 0;
					font-size: 1rem;
					border-radius: 5px;
					border: 1px solid #ccc;
					box-sizing: border-box;
				}

				.data button {
					background-color: #455f9e;
					color: white;
					cursor: pointer;
					border: none;
					width: 100%;
					padding: 0.75rem;
					margin: 1rem 0;
					font-size: 1rem;
					border-radius: 5px;
					border: 1px solid #ccc;
					box-sizing: border-box;
				}

				.data button:hover {
					background-color: #2c3562;
				}

				table {
					width: 100%;
					border-collapse: separate;
					border-spacing: 0;
					margin-bottom: 20px;
					background-color: #fff;
					box-shadow: 0 0px 10px rgba(0, 0, 0, 0.1);
					border-radius: 5px;
					overflow: hidden;
				}

				th,
				td {
					padding: 10px;
					text-align: center;
					border: 1px solid #666;
				}

				th {
					background-color: #f4a261;
					color: white;
					font-weight: bold;
				}

				td {
					color: #333;
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
						href="#">관심매물</a>
					<a href="#">방내놓기</a>
				</nav>
				<div class="auth">
					<a href="login.jsp">로그인</a> <a href="register.jsp">회원가입</a>
				</div>
			</header>

			<!-- Main Banner -->
			<section class="main-banner">
				<div>
					<h1>대출 상세정보</h1>
					<h2>내가 선택한 대출 정보를 확인하세요</h2>
				</div>

				<!-- Controls -->
				<div class="controls">
					<button onclick="history.back()">⬅️</button>
				</div>

				<div class="form-box">
					<div class="img"></div>
					<div class="info"></div>
				</div>

				<h1>대출이자 계산기</h1>

				<div class="table-box">
					<div class="data">
						<h3>
							<label for="amount">대출 금액&nbsp;(만 원)</label>
							<input type="number" name="amount" placeholder="금액 입력" />
							<label for="period">대출 기간&nbsp;(개월)</label>
							<input type="number" name="period" placeholder="기간 입력" />
						</h3>
						<hr>
						<button id="doCalc">계산</button>
					</div>
					<div class="calcValue"></div>
					<div class="calc"></div>
				</div>
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
					const bank_name = "${ loan.bank_name }";

					var bankObj = {
						"BNK경남은행": "bnk_logo.png", "BNK부산은행": "bnk_logo.png", "IBK기업은행": "ibk_logo.png", "iM뱅크": "im_logo.png",
						"KB국민은행": "kb_logo.png", "NH농협은행": "nh_logo.png", "SC제일은행": "sc_logo.png", "Sh수협은행": "sh_logo.png",
						"광주은행": "gj_logo.png", "신한은행": "shinhan_logo.png", "우리은행": "woori_logo.png", "제주은행": "jeju_logo.png",
						"카카오뱅크": "kakao_logo.png", "케이뱅크": "kbank_logo.png", "토스뱅크": "toss_logo.png", "하나은행": "hana_logo.png"
					};

					let bank_img = `<img src="${pageContext.request.contextPath}/resources/images/\${bankObj[bank_name]}"
                                        alt="\${bank_name} 로고" class="bank-logo">`;

					let loan_check = !"${loan.loan_name}".includes("중소기업청년") && !"${loan.loan_name}".includes("버팀목") ? "loan1.jpg" : "loan2.jpg";
					let loan_img = `<img src="${pageContext.request.contextPath}/resources/images/\${loan_check}"
                                        alt="대출 로고" class="loan-logo">`;

					$(".img").html(`\${loan_img}`);

					$('.info').html(`
					\${bank_img}
					<h1>${loan.loan_name}</h1>
					<h2>${loan.bank_name}</h2>
					<ul>
						<li><h3>${loan.repayment_type}</h3></li> <br>
						<li><h3>기준금리: ${loan.loan_rate}%</h3></li> <br>
						<li><h3>최대한도: <fmt:formatNumber value="${loan.loan_limit}" pattern="#,###"/>원</h3></li>
					</ul>
				`);

					$("#doCalc").click(function () {
						let amount = parseFloat($("input[name='amount']").val());
						let period = parseFloat($("input[name='period']").val());

						if (!amount || !period) {
							alert("모든 항목을 입력해주세요.");

							return false;
						}

						let maxAmount = `${loan.loan_limit}`;

						if (parseFloat(amount * 10000) > maxAmount) {
							alert(`해당 상품의 최대 한도는 \${maxAmount / 100000000}억 원입니다.`);

							$("input[name='amount']").val(maxAmount / 10000);
							amount = maxAmount / 10000;
						}

						$('.calc').html(`
							<table>
								<thead>
									<tr>
										<th>회차</th>
										<th>상환원금</th>
										<th>이자액</th>
										<th>납부액</th>
										<th>잔액</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						`);

						let repayment_type = "${loan.repayment_type}";
						let rate = `${loan.loan_rate}`;
						let balance = Math.round(amount * 10000);
						let principal = 0;
						let interest = 0;
						let payment = 0;

						let val1 = 0;
						let val2 = 0;
						let dpLg1 = "";
						let dpLg2 = "";
						let avg = 0;

						function draw(i, principal, interest, payment, balance) {
							$('.calc tbody').append(`
								<tr>
									<td>\${i}회</td>
									<td>\${principal.toLocaleString()}원</td>
									<td>\${interest.toLocaleString()}원</td>
									<td>\${payment.toLocaleString()}원</td>
									<td>\${balance.toLocaleString()}원</td>
								</tr>
							`);
						}

						if (repayment_type == "원리금분할상환") {
							let monthly_rate = rate / 100 / 12;
							payment = Math.round(amount * 10000 * (monthly_rate * Math.pow(1 + monthly_rate, period)) / (Math.pow(1 + monthly_rate, period) - 1));

							val1 = payment;
							val2 = 0;

							dpLg1 = "(대출금액) / (대출기간)";
							dpLg2 = "상환 테이블 참고";

							avg = payment;

							for (let i = 1; i <= period; i++) {
								interest = Math.round(balance * monthly_rate);
								principal = payment - interest;
								balance -= principal;

								val2 += interest;

								if (i == period) {
									balance = 0;
								}

								draw(i, principal, interest, payment, balance);
							}
						}

						else if (repayment_type == "원금분할상환") {
							val1 = Math.round(amount / period * 10000);

							dpLg1 = "(대출금액) / (대출기간)";
							dpLg2 = "상환 테이블 참고";

							for (let i = 1; i <= period; i++) {
								principal = Math.round(amount * 10000 / period);
								interest = Math.round(balance * rate / 100 / 12);
								payment = principal + interest;
								balance -= principal;

								val2 += interest;
								avg += payment;

								if (i == period) {
									balance = 0;
								}

								draw(i, principal, interest, payment, balance);
							}

							avg /= period;
						}

						else if (repayment_type == "만기일시상환") {
							val1 = 0;
							val2 = Math.round(amount * rate / 12 * period * 100);

							dpLg1 = "해당사항 없음";
							dpLg2 = "(대출금액) * (연 이자율) / 12 * (대출기간)";

							interest = Math.round(balance * rate / 100 / 12);
							payment = interest;
							avg = payment;

							for (let i = 1; i <= period; i++) {
								if (i == period) {
									principal = balance;
									payment = balance + interest;
									balance = 0;
								}

								draw(i, principal, interest, payment, balance);
							}
						}

						$('.calcValue').html(`
							<h2>계산 결과</h2>
							<h3>한 달에 평균 \${Math.round(avg).toLocaleString()}원씩 납부하면 돼요 🥰</h3>
							<table>
								<thead>
									<tr>
										<th>구분</th>
										<th>값</th>
										<th class="dpLg">비고</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="구분">금액</td>
										<td class="값">\${amount}만원</td>
										<td class="비고">사용자 입력값</td>
									</tr>
									<tr>
										<td class="구분">상환기간</td>
										<td class="값">\${period}개월</td>
										<td class="비고">사용자 입력값</td>
									</tr>
									<tr>
										<td class="구분">연 이자율</td>
										<td class="값">${loan.loan_rate}%</td>
										<td class="비고">${loan.repayment_type} 방식</td>
									</tr>
									<tr>
										<td class="구분">월 상환액</td>
										<td class="값">\${val1.toLocaleString()}원</td>
										<td class="비고">\${dpLg1}</td>
									</tr>
									<tr>
										<td class="구분">총 이자액</td>
										<td class="값">\${val2.toLocaleString()}원</td>
										<td class="비고">\${dpLg2}</td>
									</tr>
								</tbody>
							</table>
						`);
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