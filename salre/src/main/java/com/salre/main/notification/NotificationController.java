package com.salre.main.notification;

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

	@GetMapping("/main")
	public ModelAndView viewMain() {
		return new ModelAndView("notification/main");
	}

	@GetMapping(value = "/subscribe/{id}", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
	public SseEmitter subscribe(@PathVariable Long id) {
		return notificationService.subscribe(id);
	}

	@PostMapping("/send/{id}")
	public void send(@PathVariable Long id) {
		notificationService.notify(id, "data");
	}
}