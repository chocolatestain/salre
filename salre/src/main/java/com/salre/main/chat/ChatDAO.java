package com.salre.main.chat;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ChatDAO implements ChatDAOInterface {
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.salre.main.chat.";

}
