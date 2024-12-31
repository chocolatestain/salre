package com.salre.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentService {
	
	@Autowired
	CommentDAOMybatis commentDAOMybatis;

	// 댓글 등록
	public void register(CommentDTO commentDTO) {
		commentDAOMybatis.register(commentDTO);
	}

	// 해당 게시글에 작성된 댓글 리스트 가져오기
	public List<CommentDTO> selectAllService(Integer board_id) {
		return commentDAOMybatis.selectAll(board_id);
	}

	// 해당 댓글 정보 조회
	public CommentDTO selectByCommentIdService(Integer comment_id) {
		return commentDAOMybatis.selectByCommentId(comment_id);
	}

}
