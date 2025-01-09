package com.salre.main.myPage;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostDTO {
	private int board_id; // �Խñ� ID (Primary Key)
	private int user_id; // �ۼ��� ID
	private String board_class; // �Խñ� �з�
	private String board_title; // �Խñ� ����
	private String board_content; // �Խñ� ����
	private Timestamp created_at; // ��������
	private Timestamp updated_at; // ��������
	private int click_cnt; // ��ȸ��
}
