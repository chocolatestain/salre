package com.salre.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	CommentService commentService;

	// 게시판 목록 조회(게시글 페이징; 처음 페이지 요청은 1페이지를 보여줌)
	@GetMapping(value = "/list")
	public String boardList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			Model model) {
		// 해당 페이지에서 보여줄 게시글 목록
		List<BoardDTO> boardList = boardService.selectByPageService(page);
		log.info("boardList : " + boardList);
		
		// /board/list/page=2 이런 식으로 요청하게 됨
		PageDTO pageDTO = boardService.pagingParam(page);
		log.info("pageDTO : " + pageDTO);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pageDTO", pageDTO);
//		model.addAttribute("boardList", boardService.selectAllService());
		
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
	public String boardDetail(Integer board_id, Model model) {
		// 게시글 상세보기 시 조회수 증가
		boardService.updateClickCnt(board_id);
		
		// 해당 게시글 정보
		BoardDTO boardDTO = boardService.selectByBoardIdService(board_id);
		
		// 해당 게시글에 작성된 댓글 리스트 가져오기
		List<CommentDTO> commentDTOList = commentService.selectAllService(board_id);
		
		model.addAttribute("boardDTO", boardDTO);
		model.addAttribute("commentDTOList", commentDTOList);
		
		return "board/boardDetail";
	}
	
	// 게시글 삭제
	@GetMapping(value = "/delete")
	public String boardDelete(Integer board_id) {
		boardService.deleteService(board_id);
		
		return "redirect:list";
	}
	
	// 게시글 수정 화면
	@GetMapping(value = "/update")
	public String boardUpdate(Integer board_id, Model model) {
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
	
	// 게시글 페이징
	// /board/paging/page=2
	// 처음 페이지 요청은 1 페이지를 보여줌
	@GetMapping("/paging")
	public String boardPaging(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			Model model) {
		log.info("page : " + page);
		
		// 해당 페이지에서 보여줄 게시글 목록
		List<BoardDTO> pagingList = boardService.selectByPageService(page);
		log.info("pagingList : " + pagingList);
		
		PageDTO pageDTO = boardService.pagingParam(page);
		log.info("pageDTO : " + pageDTO);
		
		model.addAttribute("pagingList", pagingList);
		model.addAttribute("pageDTO", pageDTO);
		
		return "pageDTO";
	}
	
}
