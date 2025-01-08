package com.salre.main.chat;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	ChatService chatService;
	
	@Autowired
    private SimpMessagingTemplate simpMessagingTemplate;
	
	// 채팅 메인 화면
	@GetMapping("/main")
	public String main(HttpSession session, Model model) {
		// 로그인 정보(세션) 가져오기, 매물 정보 가져오기
		Integer product_id = 50; // 매물 번호
		Integer product_user_id = 5; // 채팅 받는 사람(user_id)
		String product_name = "매물A"; // 매물 이름
		
		// 채팅방 생성
		Integer user_id = 3; // 채팅 시작하는 사람(보내는 사람, 세션 값에서 가져오기) 3, 5
		String user_name = "홍길동"; // 세션 값에서 가져오기; 홍길동, 판매자
		String room_name = product_name + "(" + user_id + ":" + user_name + ")";
		ChatRoomDTO chatRoomDTO = ChatRoomDTO.builder().user_id(user_id)
													   .room_name(room_name)
													   .product_id(product_id).build();
		// 채팅방 생성 시 중복 확인
		int result = chatService.checkDupChatRoomService(chatRoomDTO);
		if (result != 1) { // 중복되는 채팅방이 없으면 채팅방 생성
			chatService.createChatRoom(chatRoomDTO);
		}
		
		// 채팅방 정보 조회(user_id, product_id)
		List<ChatRoomDTO> chatRoomDTOList = chatService.selectByUserIdService(chatRoomDTO);
		
		// 채팅방별 마지막 대화 내용 조회
		
		model.addAttribute("chatRoomDTOList", chatRoomDTOList);
		
		return "chat/chatMain";
	}
	
	// 채팅방 입장
	@GetMapping("/enterChatRoom")
	public String enterChatRoom(Integer chatRoom_id, Model model) {
		// 채팅방 정보 조회(chatRoom_id)
		ChatRoomDTO chatRoomDTO = chatService.selectByChatRoomIdService(chatRoom_id);
		
		model.addAttribute("chatRoomDTO", chatRoomDTO);
		
		return "chat/chatRoom";
	}
	
	// 이전 채팅 내용 불러오기
	@ResponseBody
	@GetMapping("/getPreviousChat")
	public List<ChatDTO> getPreviousChat(Integer chatRoom_id) {
		List<ChatDTO> chatDTOList = chatService.selectPreChatService(chatRoom_id);
		
		return chatDTOList;
	}
	
	// 채팅방 입장 알림
	@MessageMapping("/addUser")
//	@SendTo("topic/chatRoom")
	public void addUser(ChatDTO message) {
		// addUser가 우선 순위로 먼저 처리
		message.setChat_content(message.getSender() + " 님이 입장했습니다.");
        log.info("[chat_content] : " + message.getChat_content());
        
        simpMessagingTemplate.convertAndSend("/topic/chatRoom/" + message.getChatRoom_id(), message);
        
//        return message;
	}
	
	// 채팅방 내에서 메시지 전송
	@MessageMapping("/sendMessage") // 클라이언트가 "/app/sendMessage"로 보낸 메시지를 처리
//    @SendTo("/topic/chatRoom") // "/topic/chatRoom"를 구독 중인 클라이언트에게 메시지를 브로드캐스트
    public void sendMessage(ChatDTO message) {
        log.info("[Received message] : " + message);

        simpMessagingTemplate.convertAndSend("/topic/chatRoom/" + message.getChatRoom_id(), message);
        
        // 보낸 메시지 DB에 저장
        chatService.insertSendMessageService(message);
        
//        return message;
    }
	
}
