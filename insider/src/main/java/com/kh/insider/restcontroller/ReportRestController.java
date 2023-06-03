package com.kh.insider.restcontroller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.BlockDto;
import com.kh.insider.dto.MemberWithProfileDto;
import com.kh.insider.dto.ReportDto;
import com.kh.insider.dto.ReportResultDto;
import com.kh.insider.repo.BlockRepo;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.repo.MemberRepo;
import com.kh.insider.repo.MemberWithProfileRepo;
import com.kh.insider.repo.ReplyRepo;
import com.kh.insider.repo.ReportManagementRepo;
import com.kh.insider.repo.ReportRepo;
import com.kh.insider.repo.ReportResultRepo;
import com.kh.insider.service.AdminReportService;
import com.kh.insider.vo.PaginationVO;
import com.kh.insider.vo.ReportDetailVO;
import com.kh.insider.vo.ReportResponseVO;
import com.kh.insider.vo.ReportSearchVO;

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
	@Autowired
	private ReportResultRepo reportResultRepo;
	@Autowired
	private MemberRepo memberRepo;
	@Autowired
	private ReplyRepo replyRepo;
	
	@PostMapping("/")
	public MemberWithProfileDto insert(@RequestBody ReportDto reportDto, HttpSession session) throws IOException {
		//true : 최초신고, false : 신고내용 갱신
		long memberNo = (Long)session.getAttribute("memberNo");
		if(memberNo==reportDto.getReportMemberNo()) {
			return null;
		}
		reportDto.setMemberNo(memberNo);
		
		//기존에 리포트를 한 상태인지 확인
		ReportDto checkReportDto = reportRepo.seletcOne(reportDto);
		if(checkReportDto==null) {
			reportRepo.insert(reportDto);
			String tableName = reportDto.getReportTable();
			
			//리포트 관리 결과 테이블에 추가
			ReportResultDto reportResultDto = reportResultRepo.selectOne(reportDto);
			if(reportResultDto==null) {
				reportResultRepo.insert(reportDto);
			}
			
			//신고 수 추가
			switch(tableName) {
			case "board" : 
				boardRepo.addReport((int) reportDto.getReportTableNo());
				break;
			case "member":
				memberRepo.addReport(reportDto.getReportTableNo());
				break;
			case "reply" :
				replyRepo.addReport((int) reportDto.getReportTableNo());
				break;
			}
			//최신 현황을 admin report 게시판으로 전송
			adminReportService.sendSearchOptionRequest();
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
	public ReportResponseVO selectList(@ModelAttribute ReportSearchVO vo){
		//전체 게시물 수 반환
		int count = reportManagementRepo.selectCount(vo);
		vo.setCount(count);
		ReportResponseVO responseVO = new ReportResponseVO();
		responseVO.setReportList(reportManagementRepo.selectList(vo));
		
		PaginationVO paginationVO = new PaginationVO();
		paginationVO.setCount(count);
		paginationVO.setPage(vo.getPage());
		paginationVO.setSize(vo.getSize());
		
		responseVO.setPaginationVO(paginationVO);
		return responseVO;
	}
	@GetMapping("/detail")
	public ReportDetailVO selectReportDetailCount(@ModelAttribute ReportDto reportDto){
		ReportDetailVO reportDetailVO = new ReportDetailVO();
		reportDetailVO.setReportDetailCountVO(reportRepo.selectDetailCount(reportDto));
		
		switch(reportDto.getReportTable()) {
		case "board":
			reportDetailVO.setBoardListVO(boardRepo.selectOneBoard((int)reportDto.getReportTableNo()));
			break;
		}
		return reportDetailVO;
	}
}
