package com.salre.board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class CommentDAOMybatis implements CommentDAOInterface {
	
	@Autowired
	SqlSession sqlSession;
	
	// commentMapper.xml
	String namespace = "com.salre.comment.";

	// 댓글 등록
	public void register(CommentDTO commentDTO) {
		sqlSession.insert(namespace + "register", commentDTO);
	}

	// 해당 게시글에 작성된 댓글 리스트 가져오기
	public List<CommentDTO> selectAll(Integer board_id) {
		return sqlSession.selectList(namespace + "selectAll", board_id);
	}

}
