package com.salre.main.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	ChatService chatService;
	
	// 채팅 메인 화면
	@GetMapping("/main")
	public String main() {
		// 로그인 정보(세션) 가져오기
		
		// 매물 정보 가져오기
		
		return "chat/chatMain";
	}
	
	// 채팅방 입장
	@GetMapping("/enterChatRoom")
	public String enterChatRoom(Integer user_id) {
		log.info("user_id : " + user_id);
		// 채팅방에 사용될 사용자 정보(UserDTO)
		
		return "chat/chatRoom";
	}

}
