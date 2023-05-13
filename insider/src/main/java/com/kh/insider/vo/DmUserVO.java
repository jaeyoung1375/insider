package com.kh.insider.vo;

import java.io.IOException;
import java.util.Map;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of= {"session"})
public class DmUserVO {
	
	private WebSocketSession session;
	private long memberNo;
	private String memberName;
	
	//생성자 생성
	public DmUserVO(WebSocketSession webSocketSession) {
		this.session = webSocketSession;
		Map<String, Object> attr = session.getAttributes();
		this.memberNo = (long)attr.get("memberNo");
		this.memberName = (String)attr.get("memberName");
	}
	
	//회원이 아닐 경우, 차단
	public boolean isMember() {
		return this.memberName != null;
	}
	
	//user의 sesstion 메세지를 가지고 jsonMessage를 보내라.
	public void send(TextMessage jsonMessage) throws IOException {
		session.sendMessage(jsonMessage);
	}
	
}
