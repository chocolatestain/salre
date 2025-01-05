package com.salre.main.chat;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChatService {
	
	@Autowired
	ChatDAO chatDAO;
	
	// 채팅방 생성 시 중복 확인
	public int checkDupChatRoomService(ChatRoomDTO chatRoomDTO) {
		return chatDAO.checkDupChatRoom(chatRoomDTO);
	}

	// 채팅방 생성
	public void createChatRoom(ChatRoomDTO chatRoomDTO) {
		chatDAO.createChatRoom(chatRoomDTO);
	}

	// 채팅방 정보 조회(user_id)
	public List<ChatRoomDTO> selectByUserIdService(Integer user_id) {
		return chatDAO.selectByUserId(user_id);
	}

	// 채팅방 정보 조회(chatRoom_id)
	public ChatRoomDTO selectByChatRoomIdService(Integer chatRoom_id) {
		return chatDAO.selectByChatRoomId(chatRoom_id);
	}

}
