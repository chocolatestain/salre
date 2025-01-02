package com.salre.main.user;

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
