package com.salre.main.myPage;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewDTO {
	private int review_id;// �����ȣ
	private int user_id;// ȸ����ȣ
	private int seller_id;// �Ǹ��ڹ�ȣ
	private int review_rate;// ����
	private String review_content;// �ı⳻��
	
	
	private String seller_name; // 추가된 필드
	private String product_name; // 추가된 필드
	
	private boolean reviewWritten;// 추가된 필드
	private int product_id;      // 추가된 필드 상품 ID
	private int product_status;      // 추가된 필드 상품 ID
	
}
