package com.salre.board;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class CommentDTO {
	Integer comment_id;
	Integer user_id;
	Integer board_id;
	String comment_writer;
	String comment_content;
	Date created_at;
	Date updated_at;
}
