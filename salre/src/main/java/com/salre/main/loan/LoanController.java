package com.salre.main.loan;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/loan")
public class LoanController {
	@Autowired
	LoanService loanService;

	@GetMapping("/main")
	public ModelAndView viewMain() {
		return new ModelAndView("loan/main");
	}

	@PostMapping("/result")
	public String getResult(@RequestParam("age") int age, @RequestParam("income") String income,
			@RequestParam("product_type") String productType, Model model) {
		int incomeValue = getIncome(income);

		// 대출 조건에 맞는 상품을 조회
		List<LoanDTO> loanList = loanService.selectByRate(age, incomeValue);

		// Model에 데이터를 추가하여 JSP로 전달
		model.addAttribute("loanList", loanList);

		// result.jsp로 이동
		return "loan/result";
	}

	private int getIncome(String income) {
		switch (income) {
		case "3500l":
			return 35000000;
		case "5000l":
			return 50000000;
		default:
			return Integer.MAX_VALUE;
		}
	}

	@GetMapping("/detail")
	public ModelAndView viewDetail() {
		return new ModelAndView("loan/detail");
	}
}