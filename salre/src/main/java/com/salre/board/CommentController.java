package com.salre.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/comment")
public class CommentController {
	
	@Autowired
	CommentService commentService;
	
	// 댓글 등록
	@ResponseBody
	@PostMapping(value = "/register")
	public List<CommentDTO> commentRegister(@RequestBody CommentDTO commentDTO) {
		log.info("commentDTO : " + commentDTO);
		
		commentService.register(commentDTO);
		
		// 해당 게시글에 작성된 댓글 리스트 가져오기
		List<CommentDTO> commentDTOList = commentService.selectAllService(commentDTO.getBoard_id());
		log.info("commentDTOList : " + commentDTOList);
		
		return commentDTOList;
	}

}
