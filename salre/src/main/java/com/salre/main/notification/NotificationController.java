package com.salre.main.notification;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/notification")
public class NotificationController {
	@Autowired
	NotificationService notificationService;

	@GetMapping("/main")
	public ModelAndView viewMain() {
		return new ModelAndView("notification/main");
	}
}