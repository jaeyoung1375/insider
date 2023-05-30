package com.kh.insider.service;

import java.io.IOException;

import com.kh.insider.vo.ReportSearchVO;

public interface AdminReportService {
	//데이터를 요청한 사용자에게 리스트 반환
	void sendDataToAllClients(ReportSearchVO reportSearchVO) throws IOException;
	//리스트 갱신을 위한 데이터를 브라우저에 요청함
	void sendSearchOptionRequest() throws IOException;
}
