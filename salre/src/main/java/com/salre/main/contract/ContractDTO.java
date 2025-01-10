package com.salre.main.contract;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Builder
@Setter@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ContractDTO {
	int contract_id;
	int user_id;
	int product_id;
	int price;
	int contract_status;
	
	Date contract_startdate;
	Date contract_enddate;
	Date contract_date;
	String contract_rule;
	
	Integer middle_payment;
	Integer balance_payment;
	String balance_payment_day;
	String middle_payment_day;
	Integer rent_fee_day; //1일 ,,,2일...3등
	
	String account; 
	String bank_name;
	String account_name;
	
	String contract_epath;
	String contract_imgpath;
	
}
