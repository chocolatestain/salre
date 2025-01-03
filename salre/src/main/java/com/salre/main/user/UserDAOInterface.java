package com.salre.main.user;

import java.util.List;

public interface UserDAOInterface {
	public UserDTO selectById(int  user_id);
	public List<UserDTO> selectAll();
//	public UserDTO selectByContractId(int contract_id);
}
