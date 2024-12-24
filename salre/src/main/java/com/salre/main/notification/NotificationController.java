package com.salre.main.notification;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/notification")
public class NotificationController {
	private final NotificationService notificationService;

	@GetMapping("/")
	public ModelAndView viewNotification() {
		return new ModelAndView("notification");
	}

	// 클라이언트의 이벤트 구독을 수락한다. 서버 -> 클라이언트로 이벤트를 보낼 수 있게된다.
	@GetMapping(value = "/subscribe/{userId}", produces = "text/event-stream")
	public SseEmitter subscribe(@PathVariable String userId) {
		return notificationService.subscribe(userId);
	}

	// 이벤트를 구독 중인 클라이언트에게 데이터를 전송한다.
	@PostMapping("/broadcast/{userId}")
	public void broadcast(@PathVariable String userId, @RequestParam String message) {
		notificationService.broadcast(userId, message);
	}
	
	// 특정 유저에게 메시지를 보낸다.
    @PostMapping("/sendToClient/{targetUserId}")
    public void sendToClient(@PathVariable String targetUserId, @RequestParam String message) {
        notificationService.sendMessageToClient(targetUserId, message);
    }
}