package com.salre.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

	// 게시판 목록 조회
	@GetMapping(value = "/list")
	public String boardList(Model model) {
		model.addAttribute("boardList", boardService.selectAllService());
		
		return "board/boardList";
	}
	
	// 게시글 등록 화면
	@GetMapping(value = "/insert")
	public String boardInsertPage() {
		return "board/boardInsert";
	}
	
	// 게시글 등록
	@ResponseBody
	@PostMapping(value = "/insert", consumes = MediaType.APPLICATION_JSON_VALUE,
			produces = "text/plain;charset=utf-8")
	public String boardInsert(@RequestBody BoardDTO boardDTO) {
		// 한글 인코딩?
		
		// 세션 값으로 user_id, writer(아이디) 받아오기
		// 공지사항 : 관리자만 등록 가능, 자유게시판 : 누구나 가능
		int result = boardService.insertService(boardDTO);
		
		return result > 0 ? "게시글이 등록되었습니다." : "게시글 등록에 실패했습니다.";
	}
	
	// 게시글 상세보기
	@GetMapping(value = "/detail")
	public String boardDetail(Long board_id, Model model) {
		BoardDTO boardDTO = boardService.selectByBoardIdService(board_id);
		
		// 게시글 상세보기 시 조회수 증가
		boardService.updateClickCnt(board_id);
		
		model.addAttribute("boardDTO", boardDTO);
		
		return "board/boardDetail";
	}
	
	// 게시글 삭제
	@GetMapping(value = "/delete")
	public String boardDelete(Long board_id) {
		boardService.deleteService(board_id);
		
		return "redirect:list";
	}
	
}
