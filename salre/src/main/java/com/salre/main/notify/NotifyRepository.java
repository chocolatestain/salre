package com.salre.main.notify;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NotifyRepository {
	@Autowired
	private SqlSession sqlSession;

	private String namespace = "com.salre.main.notify.";

	public List<NotifyDTO> select(int user_id) {
		return sqlSession.selectList(namespace + "select", user_id);
	}

	// NotifyDTO로 알림 생성
	public void insert(NotifyDTO nofityDTO) {
		nofityDTO.setNotify_time(new Timestamp(System.currentTimeMillis())); // 알림 시간을 현재 시간으로 설정

		sqlSession.insert(namespace + "insert", nofityDTO);
	}
}
