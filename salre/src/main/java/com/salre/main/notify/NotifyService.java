package com.salre.main.notify;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NotifyService {
    @Autowired
    private NotifyRepository notifyRepository;

    // 알림 조회
    public List<NotifyDTO> select(int user_id) {
        return notifyRepository.select(user_id);
    }

    // 알림 생성
    public void insert(NotifyDTO nofityDTO) {
        notifyRepository.insert(nofityDTO);
    }

    // 알림 상태 변경
    public void update(int notify_id) {
        notifyRepository.update(notify_id);
    }
}