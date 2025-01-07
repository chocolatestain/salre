package com.team.salre.login;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReportDTO {
	private int user_id;// 회원번호
	private int product_id;// 매물번호
	private int report_class;// 신고분류 1.게시글신고 2.허위매물신고 3.사용자신고
	private String report_content;//신고내용
	
}
