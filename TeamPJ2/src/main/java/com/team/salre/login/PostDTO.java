package com.team.salre.login;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostDTO {
	private int board_id; // 게시글 ID (Primary Key)
	private int user_id; // 작성자 ID
	private String board_class; // 게시글 분류
	private String board_title; // 게시글 제목
	private String board_content; // 게시글 내용
	private Timestamp created_at; // 생성일자
	private Timestamp updated_at; // 수정일자
	private int click_cnt; // 조회수
}
