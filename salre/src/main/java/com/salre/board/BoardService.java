package com.salre.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardService {
	
	@Autowired
	BoardDAOMybatis boardDAOMybatis;
	
	// 게시판 목록 조회
	public List<BoardDTO> selectAllService() {
		return boardDAOMybatis.selectAll();
	}

	// 게시글 등록
	public int insertService(BoardDTO boardDTO) {
		return boardDAOMybatis.insert(boardDTO);
	}

	// 게시글 상세보기
	public BoardDTO selectByBoardIdService(Long board_id) {
		return boardDAOMybatis.selectByBoardId(board_id);
	}

	// 게시글 상세보기 시 조회수 증가
	public void updateClickCnt(Long boardId) {
		boardDAOMybatis.updateClickCnt(boardId);
	}

	// 게시글 삭제
	public void deleteService(Long board_id) {
		boardDAOMybatis.delete(board_id);
	}

}
