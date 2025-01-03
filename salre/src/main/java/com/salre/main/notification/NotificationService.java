package com.salre.main.notification;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NotificationService {
	@Autowired
	NotificationRepository NotificationRepository;

	// 알림 조회
	public List<NotificationDTO> select(int id) {
		return NotificationRepository.select(id);
	}
}