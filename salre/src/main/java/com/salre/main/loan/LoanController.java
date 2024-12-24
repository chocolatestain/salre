package com.salre.main.loan;

import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LoanController {

	private static final Logger logger = LoggerFactory.getLogger(LoanController.class);

	@Autowired
	private LoanService loanService;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/loan", method = RequestMethod.GET, produces = "text/plain; charset=UTF-8")
	@ResponseBody
	public String getLoan(Locale locale) {
		logger.info("Fetching loan data for locale: {}.", locale);

		// LoanDTO 리스트 가져오기
		List<LoanDTO> list = loanService.selectAll();

		StringBuilder sb = new StringBuilder();

		sb.append("대출번호\t").append("대출명\t").append("은행명\t").append("금리방식\t").append("상환방식\t").append("기준금리\t")
				.append("대출한도\t").append("최대나이\t").append("최대한도\n\n");

		for (LoanDTO loan : list) {
			sb.append(loan.getLoan_id() + "\t").append(loan.getLoan_name() + "\t").append(loan.getBank_name() + "\t")
					.append(loan.getInterest_type() + "\t").append(loan.getRepayment_type() + "\t")
					.append(loan.getLoan_rate() + "\t").append(loan.getLoan_limit() + "\t")
					.append(loan.getMax_age() + "\t").append(loan.getMax_income()).append("\n\n");
		}

		return sb.toString(); // 텍스트 형식으로 반환
	}
}