package com.salre.main.notification;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

public class NotificationRepository {
    @Autowired
    private SqlSessionTemplate sqlSession;

    public List<NotificationDTO> select(int id) {
        Map<String, Object> map = new HashMap<>(id);

        map.put("age", id);

        return sqlSession.selectList("notificationMapper.select", map);
    }
}
