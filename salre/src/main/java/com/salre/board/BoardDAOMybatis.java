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
	
	// �Խ��� ��� ��ȸ
	public List<BoardDTO> selectAll() {
		List<BoardDTO> boardList = sqlSession.selectList(namespace + "selectAll");
		log.info("[selectAll] boardList �Ǽ� : " + boardList.size());

		return boardList;
	}

	// �Խñ� ���
	public int insert(BoardDTO boardDTO) {
		int result = sqlSession.insert(namespace + "insert", boardDTO);
		log.info("[insert] ��� �Ǽ� : " + result);
		
		return result;
	}

	// �Խñ� �󼼺���
	public BoardDTO selectByBoardId(Long board_id) {
		BoardDTO boardDTO = sqlSession.selectOne(namespace + "selectByBoardId", board_id);
		log.info("[selectByBoardId] boardDTO : " + boardDTO);
		
		return boardDTO;
	}

	// �Խñ� �󼼺��� �� ��ȸ�� ����
	public void updateClickCnt(Long boardId) {
		sqlSession.update(namespace + "updateClickCnt", boardId);
	}

	// �Խñ� ����
	public void delete(Long board_id) {
		sqlSession.delete(namespace + "delete", board_id);
	}

	// 게시글 수정
	public int update(BoardDTO boardDTO) {
		int result = sqlSession.update(namespace + "update", boardDTO);
		log.info("[update] 수정 건수 : " + result);
		
		return result;
	}

}
