package com.kh.insider.websocket;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminReportWebSocketServer extends TextWebSocketHandler{
	
	//사용자 저장소
	private Set<WebSocketSession> users = new CopyOnWriteArraySet<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		users.add(session);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		users.remove(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		for(WebSocketSession user : users) {
			user.sendMessage(message);
		}
	}
	//서버에서 연결된 유저들에게 메세지 전달(AdminReportService로 호출)
	public void sendToAdmin(String message) throws IOException {
		for(WebSocketSession user : users) {
			user.sendMessage(new TextMessage(message));
		}
	}
}