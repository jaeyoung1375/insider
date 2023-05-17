package com.kh.insider.restcontroller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.ReportDto;
import com.kh.insider.dto.ReportManagementDto;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.repo.ReportManagementRepo;
import com.kh.insider.repo.ReportRepo;
import com.kh.insider.service.AdminReportService;

@RequestMapping("/rest/report")
@RestController
public class ReportRestController {
	@Autowired
	private ReportRepo reportRepo;
	@Autowired
	private ReportManagementRepo reportManagementRepo;
	@Autowired
	private BoardRepo boardRepo;
	@Autowired
	private AdminReportService adminReportService;
	
	@PostMapping("/")
	public boolean insert(@RequestBody ReportDto reportDto, HttpSession session) throws IOException {
		//true : 최초신고, false : 신고내용 갱신
		long memberNo = (Long)session.getAttribute("memberNo");
		reportDto.setMemberNo(memberNo);
		ReportDto checkReportDto = reportRepo.seletcOne(reportDto);
		if(checkReportDto==null) {
			reportRepo.insert(reportDto);
			String board = reportDto.getReportTable();
			//신고 수 추가
			switch(board) {
			case "board" : 
				boardRepo.addReport(reportDto.getReportTableNo());
			}
			//최신 현황을 admin report 게시판으로 전송
			adminReportService.sendDataToAllCilients();
			return true;
		}
		else {
			reportRepo.update(reportDto);
			return false;
		}
	}
	
	@GetMapping("/")
	public List<ReportManagementDto> selectList(){
		return reportManagementRepo.selectList();
	}
}
