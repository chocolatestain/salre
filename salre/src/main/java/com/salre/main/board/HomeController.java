package com.salre.main.board;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	@GetMapping("/")
	public ModelAndView viewHome() {
		return new ModelAndView("home");
	}
	
	@GetMapping("/loan")
	public ModelAndView viewLoan() {
		return new ModelAndView("loan/loan");
	}
}