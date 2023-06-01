package com.kh.insider.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.ReportResultDto;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.repo.BoardTagRepo;
import com.kh.insider.repo.MemberStatsRepo;
import com.kh.insider.repo.MemberWithProfileRepo;
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
import com.kh.insider.vo.SearchStatsSearchVO;
import com.kh.insider.vo.SearchStatsVO;

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
	@DeleteMapping("/board")
	public void deleteBoard(@ModelAttribute ReportResultDto reportResultDto) {
		//태그를 지움
		boardTagRepo.delete(reportResultDto.getReportTableNo());
		boardRepo.delete(reportResultDto.getReportTableNo());
		
		
		reportResultRepo.updateResult(reportResultDto);
	}
	@PutMapping("/board")
	public void changeManageBoard(@RequestBody ReportResultDto reportResultDto) {
		reportResultRepo.updateResult(reportResultDto);
		//report에 reportCheck 변경
		reportRepo.updateReportCheck(reportResultDto);
	}
}
