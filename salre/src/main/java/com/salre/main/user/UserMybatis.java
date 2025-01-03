package com.salre.main.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository("userMybatis")
public class UserMybatis implements UserDAOInterface{

	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	String namespace = "com.salre.main.user.";
	
//	public UserDTO selectByContractId(int contract_id) {
//		UserDTO user = sqlSession.selectOne(namespace +"selectByContractId",contract_id);
//		return user;
//	}
	public List<UserDTO> selectAll() {
		List<UserDTO> userlist = sqlSession.selectList(namespace+"selectAll");
		log.info("user조회"+userlist.size());
		return userlist;
	}
	
	
	public UserDTO selectById(HttpServletRequest user_id) {
		UserDTO user = sqlSession.selectOne(namespace +"selectById",user_id);
		log.info("user 1건:" + user);
		return user;

	}
	
	public UserDTO selectById(int user_id) {
		UserDTO user = sqlSession.selectOne(namespace +"selectById",user_id);
		log.info("user 1건:" + user);
		return user;
		
	}
	
}
