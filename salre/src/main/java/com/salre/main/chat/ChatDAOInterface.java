package com.salre.main.chat;

import java.util.List;

public interface ChatDAOInterface {
	
	// 채팅방 생성 시 중복 확인
	public int checkDupChatRoom(ChatRoomDTO chatRoomDTO);
	
	// 채팅방 생성
	public void createChatRoom(ChatRoomDTO chatRoomDTO);
	
	// 채팅방 정보 조회
	public List<ChatRoomDTO> selectByUserId(Integer user_id);

}
