package com.team.salre.login;

import org.apache.ibatis.annotations.Mapper;

// Interface(규격서): 정의는 있고 구현은 없다.
@Mapper
public interface UserDAOInterface {

			// 회원가입
			public int insertUser(UserDTO user);
			
			// 로그인
			//public UserDTO selectUserById(String id,String password);
			public UserDTO selectUserById(String id);
			
			// ID찾기
			public String findIdByEmail(String email);
			
			// 회원탈퇴
			public void deleteUser(String id);
			
			//ID중복체크
		    public UserDTO selectUserById2(String id);
		       
		  
		

}