package com.kh.insider.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.ForbiddenDto;
import com.kh.insider.dto.MemberSuspensionDto;
import com.kh.insider.dto.MemberWithSuspensionDto;
import com.kh.insider.dto.ReplyDto;
import com.kh.insider.dto.ReportDto;
import com.kh.insider.dto.ReportListDto;
import com.kh.insider.dto.ReportResultDto;
import com.kh.insider.dto.TagDto;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.repo.BoardTagRepo;
import com.kh.insider.repo.ForbiddenRepo;
import com.kh.insider.repo.MemberRepo;
import com.kh.insider.repo.MemberStatsRepo;
import com.kh.insider.repo.MemberSuspensionRepo;
import com.kh.insider.repo.MemberWithProfileRepo;
import com.kh.insider.repo.ReplyRepo;
import com.kh.insider.repo.ReportListRepo;
import com.kh.insider.repo.ReportManagementRepo;
import com.kh.insider.repo.ReportRepo;
import com.kh.insider.repo.ReportResultRepo;
import com.kh.insider.repo.SearchRepo;
import com.kh.insider.repo.TagRepo;
import com.kh.insider.vo.AdminBoardResponseVO;
import com.kh.insider.vo.AdminBoardSearchVO;
import com.kh.insider.vo.AdminTagResponseVO;
import com.kh.insider.vo.BoardTagStatsResponseVO;
import com.kh.insider.vo.BoardTagStatsSearchVO;
import com.kh.insider.vo.BoardTimeStatsResponseVO;
import com.kh.insider.vo.BoardTimeStatsSearchVO;
import com.kh.insider.vo.MemberStatsResponseVO;
import com.kh.insider.vo.MemberStatsSearchVO;
import com.kh.insider.vo.MemberWithProfileResponseVO;
import com.kh.insider.vo.MemberWithProfileSearchVO;
import com.kh.insider.vo.PaginationVO;
import com.kh.insider.vo.ReportDetailVO;
import com.kh.insider.vo.ReportMemberDetailVO;
import com.kh.insider.vo.ReportResponseVO;
import com.kh.insider.vo.ReportSearchVO;
import com.kh.insider.vo.SearchStatsSearchVO;
import com.kh.insider.vo.SearchStatsVO;
import com.kh.insider.vo.UpdateReportContentVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/rest/admin")
public class AdminRestController {
	@Autowired
	private BoardRepo boardRepo;
	@Autowired
	private MemberWithProfileRepo memberWithProfileRepo;
	@Autowired
	private TagRepo tagRepo;
	@Autowired
	private MemberStatsRepo memberStatsRepo;
	@Autowired
	private SearchRepo searchRepo;
	@Autowired
	private ReportResultRepo reportResultRepo;
	@Autowired
	private ReportRepo reportRepo;
	@Autowired
	private BoardTagRepo boardTagRepo;
	@Autowired
	private ForbiddenRepo forbiddenRepo;
	@Autowired
	private MemberRepo memberRepo;
	@Autowired
	private ReplyRepo replyRepo;
	@Autowired
	private ReportListRepo reportListRepo;
	@Autowired
	private MemberSuspensionRepo memberSuspensionRepo;
	@Autowired
	private ReportManagementRepo reportManagementRepo;
	
	//관리자페이지 리스트 출력
	@GetMapping("/board/list")
	public AdminBoardResponseVO selectList(@ModelAttribute AdminBoardSearchVO vo){
		//정렬 리스트 trim
		vo.refreshOrderList();
		//태그 리스트 반환
		vo.makeTagList();
		//전체 게시물 수 반환
		int count = boardRepo.selectAdminCount(vo);
		vo.setCount(count);
		AdminBoardResponseVO responseVO = new AdminBoardResponseVO();
		responseVO.setBoardList(boardRepo.selectListWithAttach(vo));
		
		PaginationVO paginationVO = new PaginationVO();
		paginationVO.setCount(count);
		paginationVO.setPage(vo.getPage());
		paginationVO.setSize(vo.getSize());
		
		responseVO.setPaginationVO(paginationVO);
		return responseVO;
	}
	//리스트 출력
	@GetMapping("/member/list")
	public MemberWithProfileResponseVO selectList(@ModelAttribute MemberWithProfileSearchVO vo){
		//정렬 리스트 trim
		vo.refreshOrderList();
		//전체 게시물 수 반환
		int count = memberWithProfileRepo.selectCount(vo);
		vo.setCount(count);
		MemberWithProfileResponseVO responseVO = new MemberWithProfileResponseVO();
		responseVO.setMemberList(memberWithProfileRepo.selectList(vo));
		
		PaginationVO paginationVO = new PaginationVO();
		paginationVO.setCount(count);
		paginationVO.setPage(vo.getPage());
		
		responseVO.setPaginationVO(paginationVO);
		return responseVO;
	}
	@GetMapping("/tag/list")
	public AdminTagResponseVO selectTagList(@ModelAttribute AdminBoardSearchVO vo) {
		//정렬 리스트 trim
		vo.refreshTagOrderList();
		//전체 게시물 수 반환
		int count = tagRepo.tagCountListCount(vo);
		vo.setTagCount(count);
		AdminTagResponseVO responseVO = new AdminTagResponseVO();
		responseVO.setTagList(tagRepo.tagCountList(vo));
		
		PaginationVO paginationVO = new PaginationVO();
		paginationVO.setCount(count);
		paginationVO.setPage(vo.getTagPage());
		paginationVO.setSize(vo.getTagSize());
		responseVO.setPaginationVO(paginationVO);
		return responseVO;
	}
	//게시물 통계자료 반환
	@PostMapping("/stats/boardTime")
	public List<BoardTimeStatsResponseVO> getTimeStats(@RequestBody BoardTimeStatsSearchVO boardTimeStatsSearchVO){
		return boardRepo.getBoardTimeStats(boardTimeStatsSearchVO);
	}
	@PostMapping("/stats/boardTag")
	public List<BoardTagStatsResponseVO> getTagStats(@RequestBody BoardTagStatsSearchVO boardTagStatsSearchVO){
		return boardRepo.getBoardTagStats(boardTagStatsSearchVO);
	}

	//회원 통계자료 반환
	@PostMapping("/stats/member")
	public List<MemberStatsResponseVO> getStats(@RequestBody MemberStatsSearchVO memberStatsSearchVO){
		return memberStatsRepo.selectList(memberStatsSearchVO);
	}
	@PostMapping("/stats/cumulative")
	public List<MemberStatsResponseVO> getCumulative(@RequestBody MemberStatsSearchVO memberStatsSearchVO){
		return memberStatsRepo.selectListCumulative(memberStatsSearchVO);
	}
	
	//검색 통계자료 반환
	@PostMapping("/stats/searchTag")
	public List<SearchStatsVO> getSearchTagStats(@RequestBody SearchStatsSearchVO searchVO) {
		searchVO.setColumn("search_tag_name");
		return searchRepo.selectStatsList(searchVO);
	}
	@PostMapping("/stats/searchNick")
	public List<SearchStatsVO> getSearchNickStats(@RequestBody SearchStatsSearchVO searchVO){
		searchVO.setColumn("member_nick");
		return searchRepo.selectStatsList(searchVO);
	}
	@PutMapping("/board")
	public void deleteBoard(@RequestBody ReportResultDto reportResultDto, HttpSession session) {
		int memberLevel = (int)session.getAttribute("memberLevel");
		if(memberLevel==0) return;
		//태그를 지움
		boardTagRepo.delete((int)reportResultDto.getReportTableNo());
		boardRepo.delete((int)reportResultDto.getReportTableNo());
		
		reportRepo.updateReportCheck(reportResultDto);
		reportResultRepo.updateResult(reportResultDto);
	}
	@PutMapping("/reportManage")
	public void changeManageBoard(@RequestBody ReportResultDto reportResultDto) {
		String tableName = reportResultDto.getReportTable();
		//report 테이블의 신고들의 체크 상태 변경
		reportRepo.updateReportCheck(reportResultDto);
		if(reportResultDto.getReportResult()==1) {
			//report에 reportCheck 변경
			switch(tableName) {
			case "board" : 
				//report 카운트 재산정(체크된 리포트는 카운트 안함)
				boardRepo.addReport((int)reportResultDto.getReportTableNo());
				break;
			case "member":
				memberRepo.addReport(reportResultDto.getReportTableNo());
				break;
			case "reply" :
				replyRepo.addReport((int)reportResultDto.getReportTableNo());
				break;
			}
		}
		else {
			switch(tableName) {
			case "board" : 
				boardTagRepo.delete((int)reportResultDto.getReportTableNo());
				boardRepo.delete((int)reportResultDto.getReportTableNo());
				break;
			case "member":
				memberRepo.addReport(reportResultDto.getReportTableNo());
				break;
			case "reply" :
				replyRepo.delete((int)reportResultDto.getReportTableNo());
				break;
			}
		}
		//결과 테이블 상태 변경
		reportResultRepo.updateResult(reportResultDto);
	}
	//금지어 출력
	@GetMapping("/forbidden")
	public List<String> forbiddenList(@RequestParam(required=false) String forbiddenWord) {
		return forbiddenRepo.selectList(forbiddenWord);
	}
	//금지어 입력
	@PostMapping("/forbidden")
	public void insertForbbiden(@RequestBody ForbiddenDto forbiddenDto) {
		ForbiddenDto newDto = forbiddenRepo.selectOne(forbiddenDto);
		if(newDto==null) {
			forbiddenRepo.insert(forbiddenDto.getForbiddenWord());
		}
		else return;
	}
	//금지어 삭제
	@DeleteMapping("/forbidden")
	public void deleteForbidden(@RequestParam String forbiddenWord, HttpSession session) {
		int memberLevel = (int)session.getAttribute("memberLevel");
		if(memberLevel==0) return;
		forbiddenRepo.delete(forbiddenWord);
	}
	
	//사용가능 태그 설정
	@PutMapping("/tag")
	public int changeAvailable(@RequestBody TagDto tagDto) {
		TagDto oldTagDto = tagRepo.selectOne(tagDto.getTagName());
		int available = oldTagDto.getTagAvailable();
		int newAvailable=0;
		if(available==0) {
			newAvailable=1;
		}
		tagDto.setTagAvailable(newAvailable);
		return tagRepo.updateAvailable(tagDto);
	}
	//리포트 리스트 입력, 수정, 삭제
	@DeleteMapping("/reportContent/{reportListNo}")
	public void delete(@PathVariable int reportListNo) {
		reportListRepo.delete(reportListNo);
	}
	@PostMapping("/reportContent/")
	public void insert(@RequestBody ReportListDto reportListDto) {
		reportListRepo.insert(reportListDto);
	}
	@PutMapping("/reportContent/")
	public void update(@RequestBody UpdateReportContentVO updateReportContentVO) {
		memberSuspensionRepo.updateReportContent(updateReportContentVO);
		reportListRepo.update(updateReportContentVO);
		reportRepo.updateReportContent(updateReportContentVO);
	}
	//신고 관리
	@GetMapping("/report/")
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
	
	@GetMapping("/report/detail")
	public ReportDetailVO selectReportDetailCount(@ModelAttribute ReportDto reportDto){
		ReportDetailVO reportDetailVO = new ReportDetailVO();
		reportDetailVO.setReportDetailCountVO(reportRepo.selectDetailCount(reportDto));
		
		switch(reportDto.getReportTable()) {
		case "board":
			reportDetailVO.setBoardListVO(boardRepo.selectOneBoard((int)reportDto.getReportTableNo()));
			break;
		case "member":
			ReportMemberDetailVO reportMemberDetailVO = new ReportMemberDetailVO();
			reportMemberDetailVO.setBoardList(boardRepo.selectListReported(reportDto.getMemberNo()));
			reportMemberDetailVO.setReplyList(replyRepo.selectListReported(reportDto.getMemberNo()));
			reportDetailVO.setMemberVO(reportMemberDetailVO);
			break;
		case "reply":
			ReplyDto replyDto = replyRepo.selectOne((int)reportDto.getReportTableNo());
			reportDetailVO.setReplyList(replyRepo.selectList(replyDto.getReplyOrigin()));
			break;
		}
		return reportDetailVO;
	}
	//정지 관리
	@PostMapping("/suspension/")
	public MemberWithSuspensionDto insert(@RequestBody MemberSuspensionDto  memberSuspensionDto) {
		if(memberSuspensionRepo.selectOne(memberSuspensionDto.getMemberNo())==null) {
			memberSuspensionRepo.insert(memberSuspensionDto);
		}
		else {
			memberSuspensionRepo.addSuspension(memberSuspensionDto);
		}
		return memberWithProfileRepo.suspensionSelectOne(memberSuspensionDto.getMemberNo());
	}
	@PutMapping("/suspension/")
	public MemberWithSuspensionDto removeSuspension(@RequestBody MemberSuspensionDto memberSuspensionDto) {
		long memberNo = memberSuspensionDto.getMemberNo();
		memberSuspensionRepo.removeSuspension(memberNo);
		return memberWithProfileRepo.suspensionSelectOne(memberNo);
	}
	//reply no로 리스트 반환
	@GetMapping("/report/detail/{replyNo}")
	public List<ReplyDto> selectReplyList(@PathVariable int replyNo){
		ReplyDto replyDto = replyRepo.selectOne(replyNo);
		return replyRepo.selectList(replyDto.getReplyOrigin());
	}
}
