package com.salre.main.product;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class UserDTO {
	int user_id;
	String id;
	String password;
	String user_name;
	String phone_num;
	String email;
	String resident_num;
	String address;
	String address_detail;
	String auth_seller;
}
