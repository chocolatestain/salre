package com.salre.board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class BoardDAOMybatis implements BoardDAOInterface {
	
	@Autowired
	SqlSession sqlSession;
	
	// boardMapper.xml
	String namespace = "com.salre.board.";
	
	// 게시판 목록 조회
	public List<BoardDTO> selectAll() {
		List<BoardDTO> boardList = sqlSession.selectList(namespace + "selectAll");
		log.info("[selectAll] boardList 건수 : " + boardList.size());

		return boardList;
	}

	// 게시글 등록
	public int insert(BoardDTO boardDTO) {
		int result = sqlSession.insert(namespace + "insert", boardDTO);
		log.info("[insert] 등록 건수 : " + result);
		
		return result;
	}

	// 게시글 상세보기
	public BoardDTO selectByBoardId(Long board_id) {
		BoardDTO boardDTO = sqlSession.selectOne(namespace + "selectByBoardId", board_id);
		log.info("[selectByBoardId] boardDTO : " + boardDTO);
		
		return boardDTO;
	}

	// 게시글 상세보기 시 조회수 증가
	public void updateClickCnt(Long boardId) {
		sqlSession.update(namespace + "updateClickCnt", boardId);
	}

	// 게시글 삭제
	public void delete(Long board_id) {
		sqlSession.delete(namespace + "delete", board_id);
	}

}
