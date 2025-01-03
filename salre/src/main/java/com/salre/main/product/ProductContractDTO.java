package com.salre.main.product;
 
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder 
@Getter
@Setter
public class ProductContractDTO {
	int product_id;
	int user_id;
	int region_id;
	String product_name;
	String payment_type;
	int product_status;
	int view_count;
	String address;
	String address_detail;
	int deposit;
	int rentfee;
	double area;
	String product_type;
	int floor;
	Date enter_day;
	int room_count;
	int bath_count;
	Date approve_day;
	int park_count;
	int manage_fee;
	String direction;
	
	int contract_id;
	int price;
	String account;
	int contract_status;
	Date contract_startdate;
	Date contract_enddate;
	Date contract_date;
	String contract_rule;	
	
	
	//계약 추가
	int middle_payment;
	int balance_payment;
	Date balance_payment_day;
}
