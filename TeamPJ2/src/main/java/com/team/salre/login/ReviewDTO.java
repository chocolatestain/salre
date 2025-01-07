package com.team.salre.login;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewDTO {
	private int review_id;// 리뷰번호
	private int user_id;// 회원번호
	private int seller_id;// 판매자번호
	private int review_rate;// 평점
	private String review_content;// 후기내용
	

}
