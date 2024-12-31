package com.salre.board;

import java.util.List;

public interface CommentDAOInterface {
	
	// 댓글 등록
	public void register(CommentDTO commentDTO);
	
	// 해당 게시글에 작성된 댓글 리스트 가져오기
	public List<CommentDTO> selectAll(Integer board_id);

}
