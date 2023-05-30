package com.kh.insider.websocket;

import java.io.IOException;
import java.util.Collection;
import java.util.Map;

import org.modelmapper.internal.util.CopyOnWriteLinkedHashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.insider.repo.ReportManagementRepo;
import com.kh.insider.vo.PaginationVO;
import com.kh.insider.vo.ReportResponseVO;
import com.kh.insider.vo.ReportSearchVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminReportWebSocketServer extends TextWebSocketHandler{
	
	//메세지 해석기
	private ObjectMapper mapper = new ObjectMapper();
	@Autowired
	private ReportManagementRepo reportManagementRepo;
	//사용자 저장소
	private Map<Long, WebSocketSession> users = new CopyOnWriteLinkedHashMap<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//users.add(session);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//users.remove(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		ReportSearchVO searchVO = mapper.readValue(message.getPayload(), ReportSearchVO.class);
		//입장 메세지라면
		if(searchVO.getData()!=null && searchVO.getData()==1) {
			long memberNo=searchVO.getMemberNo();
			if(!users.containsKey(memberNo)) {
				users.put(memberNo, session);
			}
			else {
				users.remove(memberNo);
				users.put(memberNo, session);
			}
		}
		//요청 메세지라면
		else {
			ReportResponseVO reportResponseVO = new ReportResponseVO();
			int count = reportManagementRepo.selectCount(searchVO);
			searchVO.setCount(count);
			reportResponseVO.setReportList(reportManagementRepo.selectList(searchVO));
			
			PaginationVO paginationVO = new PaginationVO();
			paginationVO.setCount(count);
			paginationVO.setPage(searchVO.getPage());
			paginationVO.setSize(searchVO.getSize());
			
			reportResponseVO.setPaginationVO(paginationVO);
			String data = mapper.writeValueAsString(reportResponseVO);
			
			this.sendToAdmin(searchVO.getMemberNo(), data);
		}
	}
	//서버에서 연결된 유저들에게 메세지 전달(AdminReportService로 호출)
	public void sendToAdmin(long memberNo, String message) throws IOException {
		users.get(memberNo).sendMessage(new TextMessage(message));
	}
	public void sendToAdmin(String message) throws IOException {
		Collection<WebSocketSession> values = users.values();
		for(WebSocketSession session: values) {
			session.sendMessage(new TextMessage(message));
		}
	}
}