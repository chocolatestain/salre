package com.salre.main.login;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class UserDTO {

	private int user_id;//auto inc..DB테이블엔 없어도 DTO엔 써줘야
	private String id; // 사용자 ID
    private String password; // 비밀번호
    private String user_name; // 사용자 이름
    private String phone_num; // 전화번호
    private String email; // 이메일
    private String resident_num; // 주민등록번호
    private String address; // 주소
    private String address_detail; // 상세 주소
    private String auth_seller; // 인증코드
	
}
