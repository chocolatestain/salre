package com.salre.board;

import java.util.List;

public interface BoardDAOInterface {
	
	// 게시판 목록 조회
	public List<BoardDTO> selectAll();
	
	// 게시글 등록
	public int insert(BoardDTO boardDTO);
	
	// 게시글 상세보기
	public BoardDTO selectByBoardId(Integer board_id);
	
	// 게시글 상세보기 시 조회수 증가
	public void updateClickCnt(Integer board_id);
	
	// 게시글 삭제
	public void delete(Integer board_id);
	
	// 게시글 수정
	public int update(BoardDTO boardDTO);

}
