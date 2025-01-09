package com.salre.main.myPage;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReportDTO {
	private int user_id;// ȸ����ȣ
	private int product_id;// �Ź���ȣ
	private int report_class;// �Ű�з� 1.�Խñ۽Ű� 2.�����Ź��Ű� 3.����ڽŰ�
	private String report_content;//�Ű���
	
}
