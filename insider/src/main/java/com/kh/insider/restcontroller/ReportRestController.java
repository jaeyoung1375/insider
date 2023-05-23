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

import com.kh.insider.dto.BlockDto;
import com.kh.insider.dto.MemberWithProfileDto;
import com.kh.insider.dto.ReportDto;
import com.kh.insider.dto.ReportManagementDto;
import com.kh.insider.repo.BlockRepo;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.repo.MemberWithProfileRepo;
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
	@Autowired
	private MemberWithProfileRepo memberWithProfileRepo;
	@Autowired
	private BlockRepo blockRepo;
	
	@PostMapping("/")
	public MemberWithProfileDto insert(@RequestBody ReportDto reportDto, HttpSession session) throws IOException {
		//true : 최초신고, false : 신고내용 갱신
		long memberNo = (Long)session.getAttribute("memberNo");
		reportDto.setMemberNo(memberNo);
		
		//기존에 리포트를 한 상태인지 확인
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
		}
		else {
			reportRepo.update(reportDto);
		}
		
		//차단 여부 확인 후 차단할 멤버 정보 반환
		BlockDto blockDto = new BlockDto();
		blockDto.setMemberNo(memberNo);
		blockDto.setBlockNo(reportDto.getReportMemberNo());
		if(blockRepo.selectOne(blockDto)==null) {
			return memberWithProfileRepo.selectOne(reportDto.getReportMemberNo());
		}
		else {
			return null;
		}
	}
	
	@GetMapping("/")
	public List<ReportManagementDto> selectList(){
		return reportManagementRepo.selectList();
	}
}
