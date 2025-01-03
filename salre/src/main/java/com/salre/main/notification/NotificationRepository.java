package com.salre.main.notification;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class NotificationRepository {
    @Autowired
    private SqlSessionTemplate sqlSession;

    // 알림 조회
    public List<NotificationDTO> select(int user_id) {
        return sqlSession.selectList("notificationMapper.select", user_id);
    }

    // 알림 발생
    public void insert(int user_id, String notify_content) {
        NotificationDTO notification = new NotificationDTO();
        notification.setUser_id(user_id);
        notification.setNotify_content(notify_content);

        sqlSession.insert("notificationMapper.insert", notification);
    }
}