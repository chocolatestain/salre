<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

 <section class="section">
                <h2>계약 내용</h2>
                <div class="form-group">
                    <label for="deposit_INT">보증금:</label>
                    <input type="text" id="deposit_INT" name="deposit_INT" required value="200000">
                </div>
                <div class="form-group">
                    <label for="contractAmount">계약금:</label>
                    <input type="text" id="contractAmount" name="contractAmount" required  value="200000">
                </div>
                <div class="form-group">
                    <label for="middle_payment">1차 중도금:</label>
                    <input type="text" id="middle_payment" name="middle_payment"  value="200000">
                </div>
                <div class="form-group2">
                    <label for="balance_payment">잔금:</label>
                    금 <input type="text" id="balance_payment" name="balance_payment"  value="200000"> 원정은<input type="text" id="balance_payment_day" name="balance_payment_day">에 지불한다.
                </div>
                <div class="form-group">
                    <label for="enter_day">임대차 기간:</label>
                    <input type="date" id="enter_day" name="enter_day" required value="2024-05-01">
                    ~
                    <input type="date" id="contract_date" name="contract_date" required  value="2025-08-02">
               </div>
                <div class="form-group">
                    <label for="contract_date">계약일:</label>
                    <input type="date" id="contract_date" name="contract_date" required  value="2024-12-31">
                </div>
            </section>

</body>
</html>