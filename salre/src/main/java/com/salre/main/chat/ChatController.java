package com.salre.main.chat;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String main(Model model) {
		// 로그인 정보(세션) 가져오기
		
		// 매물 정보 가져오기
		
		// 채팅방 생성
		Integer user_id = 2;
		String user_name = "홍길동";
		String room_name = "매물A(" + user_name + ")";
		ChatRoomDTO chatRoomDTO = ChatRoomDTO.builder().user_id(user_id).room_name(room_name).build();
		// 채팅방 생성 시 중복 확인
		int result = chatService.checkDupChatRoomService(chatRoomDTO);
		if (result != 1) { // 중복되는 채팅방이 없으면 채팅방 생성
			chatService.createChatRoom(chatRoomDTO);
		}
		
		// 채팅방 정보 조회(user_id)
		List<ChatRoomDTO> chatRoomDTOList = chatService.selectByUserIdService(user_id);
		
		model.addAttribute("chatRoomDTOList", chatRoomDTOList);
		
		return "chat/chatMain";
	}
	
	// 채팅방 입장
	@GetMapping("/enterChatRoom")
	public String enterChatRoom(Integer chatRoom_id, Model model) {
		// 채팅방 정보 조회(chatRoom_id)
		ChatRoomDTO chatRoomDTO = chatService.selectByChatRoomIdService(chatRoom_id);
		
		model.addAttribute("chatRoomDTO", chatRoomDTO);
		
		// 채팅방에 사용될 사용자 정보(세션 값 -> model에 담기)
		
		return "chat/chatRoom";
	}
	
	@MessageMapping("/sendMessage") // 클라이언트가 "/app/sendMessage"로 보낸 메시지를 처리
    @SendTo("/topic/chatRoom/{chatRoom_id}") // "/topic/chatRoom"를 구독 중인 클라이언트에게 메시지를 브로드캐스트
    public String sendMessage(String message) {
        log.info("Received message : " + message);
        
        return message; // 클라이언트로 메시지 반환
    }

}
