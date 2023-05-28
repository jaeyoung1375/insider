package com.kh.insider.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.insider.dto.ReportManagementDto;
import com.kh.insider.repo.ReportManagementRepo;
import com.kh.insider.websocket.AdminReportWebSocketServer;

@Service
public class AdminReportServiceImpl implements AdminReportService{
	@Autowired 
	private AdminReportWebSocketServer adminReportWebSocketServer;
	@Autowired
	private ReportManagementRepo reportManagementRepo;

	@Override
	public void sendDataToAllClients() throws IOException {
		List<ReportManagementDto> reportList = reportManagementRepo.selectList();
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		String data = objectMapper.writeValueAsString(reportList);
		adminReportWebSocketServer.sendToAdmin(data);
	}
}