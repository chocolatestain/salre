package com.salre.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardService {
	
	@Autowired
	BoardDAOMybatis boardDAOMybatis;
	
	// �Խ��� ��� ��ȸ
	public List<BoardDTO> selectAllService() {
		return boardDAOMybatis.selectAll();
	}

	// �Խñ� ���
	public int insertService(BoardDTO boardDTO) {
		return boardDAOMybatis.insert(boardDTO);
	}

	// �Խñ� �󼼺���
	public BoardDTO selectByBoardIdService(Long board_id) {
		return boardDAOMybatis.selectByBoardId(board_id);
	}

	// �Խñ� �󼼺��� �� ��ȸ�� ����
	public void updateClickCnt(Long boardId) {
		boardDAOMybatis.updateClickCnt(boardId);
	}

	// �Խñ� ����
	public void deleteService(Long board_id) {
		boardDAOMybatis.delete(board_id);
	}

	// 게시글 수정
	public int updateService(BoardDTO boardDTO) {
		return boardDAOMybatis.update(boardDTO);
	}

}
