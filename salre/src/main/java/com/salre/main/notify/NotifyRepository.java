package com.salre.main.notify;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NotifyRepository {
    @Autowired
    private SqlSession sqlSession;

    private String namespace = "com.salre.main.notify.";

    // 알림 조회
    public List<NotifyDTO> select(int user_id) {
        return sqlSession.selectList(namespace + "select", user_id);
    }

    // 읽지 않은 알림 개수 조회
    public int selectUnread(int user_id) {
        int count = sqlSession.selectList(namespace + "selectUnread", user_id).size();
        return count;
    }

    // 알림 생성
    public void insert(NotifyDTO nofityDTO) {
        nofityDTO.setNotify_time(new Timestamp(System.currentTimeMillis())); // 알림 시간을 현재 시간으로 설정

        sqlSession.insert(namespace + "insert", nofityDTO);
    }

    // 알림 상태 변경
    public void update(int notify_id) {
        sqlSession.update(namespace + "update", notify_id);
    }
}