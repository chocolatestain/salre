package com.salre.main.chat;

import java.util.List;

public interface ChatDAOInterface {
	
	// 채팅방 생성 시 중복 확인
	public int checkDupChatRoom(ChatRoomDTO chatRoomDTO);
	
	// 채팅방 생성
	public void createChatRoom(ChatRoomDTO chatRoomDTO);
	
	// 채팅방 정보 조회(user_id, product_id)
	public List<ChatRoomDTO> selectByUserId(ChatRoomDTO chatRoomDTO);
	
	// 채팅방 정보 조회(chatRoom_id)
	public ChatRoomDTO selectByChatRoomId(Integer chatRoom_id);
	
	// 이전 채팅 내용 불러오기
	public List<ChatDTO> selectPreChat(Integer chatRoom_id);
	
	// 보낸 메시지 DB에 저장
	public void insertSendMessage(ChatDTO messageContent);

}
