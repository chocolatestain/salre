package com.salre.main.contract;

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
	String account;
	int contract_status;
}
