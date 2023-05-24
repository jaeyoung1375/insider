package com.kh.insider.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.BoardDto;
import com.kh.insider.dto.BoardWithNickDto;
import com.kh.insider.dto.FollowWithProfileDto;
import com.kh.insider.dto.FollowerWithProfileDto;
import com.kh.insider.dto.MemberDto;
import com.kh.insider.dto.MemberWithProfileDto;
import com.kh.insider.dto.SettingDto;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.repo.FollowRepo;
import com.kh.insider.repo.MemberRepo;
import com.kh.insider.repo.MemberStatsRepo;
import com.kh.insider.repo.MemberWithProfileRepo;
import com.kh.insider.repo.SettingRepo;
import com.kh.insider.vo.MemberStatsResponseVO;
import com.kh.insider.vo.MemberStatsSearchVO;
import com.kh.insider.vo.MemberWithProfileResponseVO;
import com.kh.insider.vo.MemberWithProfileSearchVO;
import com.kh.insider.vo.PaginationVO;

@RestController
@RequestMapping("/rest/member")
public class MemberRestController {
	@Autowired
	private SettingRepo settingRepo;
	@Autowired
	private MemberWithProfileRepo memberWithProfileRepo;
	@Autowired
	private MemberRepo memberRepo;
	@Autowired
	private MemberStatsRepo memberStatsRepo;
	@Autowired
	private FollowRepo followRepo;
	@Autowired
	private BoardRepo boardRepo;
	
	
	//멤버정보 불러오기
	@GetMapping("/{memberNo}")
	public MemberWithProfileDto getMember(@PathVariable long memberNo) {
		return memberWithProfileRepo.selectOne(memberNo);
	}
	//멤버정보 수정
	@PutMapping("/")
	public void putMember(@RequestBody MemberDto memberDto) {
		memberRepo.update(memberDto);
	}
	
	//환경설정 불러오기
	@GetMapping("/setting/{memberNo}")
	public SettingDto setting(@PathVariable long memberNo) {
		return settingRepo.selectOne(memberNo);
	}
	
	//환경설정 수정
	@PutMapping("/setting/")
	public void update(@RequestBody SettingDto settingDto) {
		settingRepo.update(settingDto);
	}
	//비밀번호 확인
	@PostMapping("/setting/password")
	public boolean checkPassword(@RequestBody MemberDto checkPasswordDto, HttpSession session) {
		long memberNo = (Long)session.getAttribute("memberNo");
		MemberDto memberDto = memberRepo.findByNo(memberNo);
		return checkPasswordDto.getMemberPassword().equals(memberDto.getMemberPassword());
	}
	//비밀번호 변경
	@PutMapping("/setting/password")
	public void changePassword(@RequestBody MemberDto memberDto, HttpSession session) {
		long memberNo = (Long)session.getAttribute("memberNo");
		memberDto.setMemberNo(memberNo);
		memberRepo.changePassword(memberDto);
	}
	//리스트 출력
	@GetMapping("/list")
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
	//통계자료 반환
	@PostMapping("/stats/")
	public List<MemberStatsResponseVO> getStats(@RequestBody MemberStatsSearchVO memberStatsSearchVO){
		return memberStatsRepo.selectList(memberStatsSearchVO);
	}
	@PostMapping("/stats/cumulative/")
	public List<MemberStatsResponseVO> getCumulative(@RequestBody MemberStatsSearchVO memberStatsSearchVO){
		return memberStatsRepo.selectListCumulative(memberStatsSearchVO);
	}
	
	// 팔로워 목록 불러오기
	@GetMapping("/followerList")
	public List<FollowerWithProfileDto> followerList(@RequestParam long memberNo){
		List<FollowerWithProfileDto> followerList = followRepo.getFollowerList(memberNo);
		return followerList;
	}
	
	// 팔로우 목록 불러오기
		@GetMapping("/followList")
		public List<FollowWithProfileDto> followList(@RequestParam long memberNo){
			List<FollowWithProfileDto> followList = followRepo.getFollowList(memberNo);
			return followList;
		}
		
	// 마이페이지 게시물 목록
	@GetMapping("/page/{page}")
	public List<BoardWithNickDto> paging(@PathVariable int page, @RequestParam String memberNick){
		return boardRepo.myPageSelectListPaging(page, memberNick);
	}
}
