package com.kh.insider.websocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;


@Configuration
@EnableWebSocket
public class WebSocketServerConfiguration implements WebSocketConfigurer {

	@Autowired
	private ChannelWebSocketServer channelWebSocketServer;
	
//	@Autowired
//	private JsonWebSocketServer jsonWebSocketServer;
//	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
//
//		//테스트
//		registry.addHandler(jsonWebSocketServer, "/ws/json")
//				.withSockJS();
//		
//		registry.addHandler(channelWebSocketServer, "/ws/channel6")
//				.addInterceptors(new HttpSessionHandshakeInterceptor())
//				.withSockJS();
	}

}