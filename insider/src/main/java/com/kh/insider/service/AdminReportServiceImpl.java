package com.kh.insider.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.insider.dto.ReportManagementDto;
import com.kh.insider.repo.ReportManagementRepo;
import com.kh.insider.vo.ReportSearchVO;
import com.kh.insider.websocket.AdminReportWebSocketServer;

@Service
public class AdminReportServiceImpl implements AdminReportService{
	@Autowired 
	private AdminReportWebSocketServer adminReportWebSocketServer;
	@Autowired
	private ReportManagementRepo reportManagementRepo;

	@Override
	public void sendDataToAllClients(ReportSearchVO reportSearchVO) throws IOException {
		List<ReportManagementDto> reportList = reportManagementRepo.selectList(reportSearchVO);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		String data = objectMapper.writeValueAsString(reportList);
		adminReportWebSocketServer.sendToAdmin(data);
	}

	@Override
	public void sendSearchOptionRequest() throws IOException {
		Map<String, Integer> map = Map.of("data", 1);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		String data = objectMapper.writeValueAsString(map);
		adminReportWebSocketServer.sendToAdmin(data);
	}
}