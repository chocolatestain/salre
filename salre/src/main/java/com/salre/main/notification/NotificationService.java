package com.salre.main.notification;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NotificationService {
	@Autowired
	EmitterRepository emitterRepository;
	NotificationRepository notificationRepository;

	// 기본 타임아웃 설정
	private static final Long DEFAULT_TIMEOUT = 60L * 1000 * 60;

	public SseEmitter subscribe(int user_id) {
		SseEmitter emitter = createEmitter(user_id);

		sendToClient(user_id, "EventStream Created. [userId=" + user_id + "]");
		return emitter;
	}

	public void notify(int user_id, Object event) {
		sendToClient(user_id, event);
		saveNotification(user_id, event.toString());
	}

	private void saveNotification(int user_id, String notify_content) {
		notificationRepository.insert(user_id, notify_content);
	}

	private void sendToClient(int id, Object data) {
		SseEmitter emitter = emitterRepository.get(id);
		if (emitter != null) {
			try {
				emitter.send(SseEmitter.event().id(String.valueOf(id)).name("sse").data(data));
			} catch (IOException exception) {
				emitterRepository.deleteById(id);
				throw new RuntimeException("연결 오류!");
			}
		}
	}

	private SseEmitter createEmitter(int user_id) {
		SseEmitter emitter = new SseEmitter(DEFAULT_TIMEOUT);
		emitterRepository.save(user_id, emitter);

		// Emitter가 완료될 때(모든 데이터가 성공적으로 전송된 상태) Emitter를 삭제한다.
		emitter.onCompletion(() -> emitterRepository.deleteById(user_id));
		// Emitter가 타임아웃 되었을 때(지정된 시간동안 어떠한 이벤트도 전송되지 않았을 때) Emitter를 삭제한다.
		emitter.onTimeout(() -> emitterRepository.deleteById(user_id));

		return emitter;
	}
}