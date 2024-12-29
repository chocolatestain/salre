package com.salre.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;

	// �Խ��� ��� ��ȸ
	@GetMapping(value = "/list")
	public String boardList(Model model) {
		model.addAttribute("boardList", boardService.selectAllService());
		
		return "board/boardList";
	}
	
	// �Խñ� ��� ȭ��
	@GetMapping(value = "/insert")
	public String boardInsertPage() {
		return "board/boardInsert";
	}
	
	// �Խñ� ���
	@ResponseBody
	@PostMapping(value = "/insert", consumes = MediaType.APPLICATION_JSON_VALUE,
			produces = "text/plain;charset=utf-8")
	public String boardInsert(@RequestBody BoardDTO boardDTO) {
		// �ѱ� ���ڵ�?
		
		// ���� ������ user_id, writer(���̵�) �޾ƿ���
		// �������� : �����ڸ� ��� ����, �����Խ��� : ������ ����
		int result = boardService.insertService(boardDTO);
		
		return result > 0 ? "�Խñ��� ��ϵǾ����ϴ�." : "�Խñ� ��Ͽ� �����߽��ϴ�.";
	}
	
	// �Խñ� �󼼺���
	@GetMapping(value = "/detail")
	public String boardDetail(Long board_id, Model model) {
		// �Խñ� �󼼺��� �� ��ȸ�� ����
		boardService.updateClickCnt(board_id);
		
		BoardDTO boardDTO = boardService.selectByBoardIdService(board_id);
		
		model.addAttribute("boardDTO", boardDTO);
		
		return "board/boardDetail";
	}
	
	// �Խñ� ����
	@GetMapping(value = "/delete")
	public String boardDelete(Long board_id) {
		boardService.deleteService(board_id);
		
		return "redirect:list";
	}
	
	// 게시글 수정 화면
	@GetMapping(value = "/update")
	public String boardUpdate(Long board_id, Model model) {
		BoardDTO boardDTO = boardService.selectByBoardIdService(board_id);
		
		model.addAttribute("boardDTO", boardDTO);
		
		return "board/boardUpdate";
	}
	
	// 게시글 수정
	@ResponseBody
	@PostMapping(value = "/update", consumes = MediaType.APPLICATION_JSON_VALUE,
			produces = "text/plain;charset=utf-8")
	public String boardUpdate(@RequestBody BoardDTO boardDTO) {
		int result = boardService.updateService(boardDTO);
		
		return result > 0 ? "공지사항이 수정되었습니다." : "공지사항 수정을 실패했습니다.";
	}
	
}
