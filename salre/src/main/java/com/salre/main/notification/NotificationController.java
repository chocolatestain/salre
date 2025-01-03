package com.salre.main.notification;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/notification")
@RequiredArgsConstructor
public class NotificationController {
	@Autowired
	NotificationService notificationService;
	NotificationRepository notificationRepository;

	@GetMapping("/main")
	public ModelAndView viewMain() {
		return new ModelAndView("notification/main");
	}

	@GetMapping(value = "/subscribe/{id}", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
	public SseEmitter subscribe(@PathVariable int user_id) {
		return notificationService.subscribe(user_id);
	}

	@PostMapping("/send/{id}")
	public void send(@PathVariable int user_id) {
		notificationService.notify(user_id, "data");
	}

	// 알림 조회 API 추가
    @GetMapping("/list/{userId}")
    public List<NotificationDTO> getNotifications(@PathVariable int user_id) {
        return notificationRepository.select(user_id);
    }
}