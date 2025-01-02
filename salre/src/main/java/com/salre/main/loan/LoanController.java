package com.salre.main.loan;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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

		// ��異� 議곌굔�뿉 留욌뒗 �긽�뭹�쓣 議고쉶
		List<LoanDTO> loanList = loanService.select(age, incomeValue);

		// Model�뿉 �뜲�씠�꽣瑜� 異붽��븯�뿬 JSP濡� �쟾�떖
		model.addAttribute("loanList", loanList);

		// result.jsp濡� �씠�룞
		return "loan/result";
	}

	// ��異� �긽�뭹 議고쉶
	@GetMapping("/select")
	@ResponseBody
	public List<LoanDTO> select(@RequestParam("age") int age, @RequestParam("income") int incomeValue) {
		return loanService.select(age, incomeValue);
	}

	@PostMapping("/detail")
	public String getDetail(@RequestParam("id") int id, Model model) {
		// ��異� 議곌굔�뿉 留욌뒗 �긽�뭹�쓣 議고쉶
		LoanDTO loan = loanService.selectById(id);

		// Model�뿉 �뜲�씠�꽣瑜� 異붽��븯�뿬 JSP濡� �쟾�떖
		model.addAttribute("loan", loan);

		// detail.jsp濡� �씠�룞
		return "loan/detail";
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
}