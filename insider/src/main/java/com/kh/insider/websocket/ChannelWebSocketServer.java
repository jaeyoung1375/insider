package com.kh.insider.websocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.insider.service.DmService;

@Service
public class ChannelWebSocketServer extends TextWebSocketHandler {
	
	@Autowired
	private DmService dmService;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		dmService.connertHandler(session);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		dmService.disconnectHandler(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		dmService.receiveHandler(session, message);
	}
	
	
	//1차 테스트
//	@Override
//	protected void handleTextMessage(WebSocketSession session, TextMessage message) {
//		try {
//			dmService.receiveHandler(session, message);
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
//	
//	@Override
//	protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message) throws Exception {
//		dmService.receiveHandler(session, new TextMessage(message.getPayload().array()));
//	}
	
	
	
	//2차 테스트
//	@Override
//	protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message) throws IOException {
//	    byte[] payload = message.getPayload().array();
//	    if (payload.length > 0) {
//	        String textPayload = new String(payload, StandardCharsets.UTF_8);
//	        dmService.receiveHandler(session, new TextMessage(textPayload));
//	    }
//	}
//
//	@Override
//	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws IOException {
//	    if (message.getPayloadLength() == 0) {
//	        return;
//	    }
//
//	    if (message.isLast()) {
//	        dmService.receiveHandler(session, message);
//	    } else {
//	        // handle partial message
//	    }
//	}

}
