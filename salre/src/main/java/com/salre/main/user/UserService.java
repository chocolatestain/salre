package com.salre.main.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class UserService {

	@Autowired
	public UserMybatis UserDAO;
	
//	public UserDTO selectByContractId(int contract_id) {
//		return UserDAO.selectByContractId(contract_id);
//	}
	

    // 유저 ID로 조회
    public UserDTO getUserById(int user_id) {
    	return UserDAO.selectById(user_id);
    }
 
    // 유저 ID로 조회
    public List<UserDTO> getselectAll() {
    	return UserDAO.selectAll();
    }

   
}

