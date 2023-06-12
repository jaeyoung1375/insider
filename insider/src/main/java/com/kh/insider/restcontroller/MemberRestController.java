		package com.kh.insider.restcontroller;

import java.net.URISyntaxException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.BoardDto;
import com.kh.insider.dto.FollowWithProfileDto;
import com.kh.insider.dto.MemberDto;
import com.kh.insider.dto.MemberProfileDto;
import com.kh.insider.dto.MemberWithProfileDto;
import com.kh.insider.dto.SettingDto;
import com.kh.insider.dto.TagFollowDto;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.repo.FollowRepo;
import com.kh.insider.repo.MemberRepo;
import com.kh.insider.repo.MemberWithProfileRepo;
import com.kh.insider.repo.SettingRepo;
import com.kh.insider.repo.TagFollowRepo;
import com.kh.insider.service.ForbiddenService;
import com.kh.insider.service.MemberService;
import com.kh.insider.service.ReportService;
import com.kh.insider.service.SocialLoginService;
import com.kh.insider.vo.BoardListVO;

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
	private FollowRepo followRepo;
	@Autowired
	private BoardRepo boardRepo;
	@Autowired
	private TagFollowRepo tagFollowRepo;
	@Autowired
	private ReportService reportService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ForbiddenService forbiddenService;
	@Autowired
	private SocialLoginService socialLoginService;
	
	
	//멤버정보 불러오기
	@GetMapping("/{memberNo}")
	public MemberWithProfileDto getMember(@PathVariable long memberNo) {
		return memberWithProfileRepo.selectOne(memberNo);
	}
	@GetMapping("/")
	public MemberWithProfileDto getMemberInfo(HttpSession session) {
		long memberNo = (long)session.getAttribute("memberNo");
		return memberWithProfileRepo.selectOne(memberNo);
	}
	//멤버정보 수정
	@PutMapping("/")
	public void putMember(@RequestBody MemberDto memberDto, HttpSession session) {
		long memberNo = (Long)session.getAttribute("memberNo");
		memberDto.setMemberNo(memberNo);
		memberRepo.update(memberDto);
	}
	
	//환경설정 불러오기
	@GetMapping("/setting/{memberNo}")
	public SettingDto setting(@PathVariable long memberNo) {
		SettingDto settingDto =settingRepo.selectOne(memberNo);;
		if(settingDto!=null) {
			return settingDto; 
		}
		else {
			settingRepo.basicInsert(memberNo);
			SettingDto newSettingDto = settingRepo.selectOne(memberNo);
			return newSettingDto;
		}
	}
	@GetMapping("/setting")
	public SettingDto getSetting(HttpSession session) {
		long memberNo = (long) session.getAttribute("memberNo");
		SettingDto settingDto =settingRepo.selectOne(memberNo);;
		if(settingDto!=null) {
			return settingDto; 
		}
		else {
			settingRepo.basicInsert(memberNo);
			SettingDto newSettingDto = settingRepo.selectOne(memberNo);
			return newSettingDto;
		}
	}
	
	//환경설정 수정
	@PutMapping("/setting/")
	public void update(@RequestBody SettingDto settingDto) {
		settingRepo.update(settingDto);
	}
	//비밀번호 확인
	@PostMapping("/setting/password")
	public boolean checkPassword(@RequestBody MemberDto checkPasswordDto, HttpSession session) {
	    long memberNo = (Long) session.getAttribute("memberNo");
	    MemberDto memberDto = memberRepo.findByNo(memberNo);
	    
	    String enteredPassword = checkPasswordDto.getMemberPassword();
	    String encodedPasswordFromDatabase = memberDto.getMemberPassword();
	    
	    return memberService.checkPassword(enteredPassword, encodedPasswordFromDatabase);
	    
	}

	//비밀번호 변경
	@PutMapping("/setting/password")
	public void changePassword(@RequestBody MemberDto memberDto, HttpSession session) {
		long memberNo = (Long)session.getAttribute("memberNo");
	    MemberDto existingMember = memberRepo.findByNo(memberNo);
	    existingMember.setMemberPassword(memberDto.getMemberPassword()); // 새로운 비밀번호 설정
	    memberService.changePassword(existingMember);
	}

	
	// 팔로우 목록 불러오기(무한스크롤)
		@GetMapping("/followListPaging/{page}")
		public List<FollowWithProfileDto> followList(@PathVariable int page, @RequestParam long memberNo){
				List<FollowWithProfileDto> followList = followRepo.getFollowListPaging(page, memberNo);
			return followList;
		}
	// 팔로우 목록 불러오기(무한스크롤)
		@GetMapping("/followerListPaging/{page}")
		public List<FollowWithProfileDto> followerList(@PathVariable int page, @RequestParam long memberNo){
				List<FollowWithProfileDto> followerList = followRepo.getFollowerListPaging(page, memberNo);
			return followerList;
		}	
				
	// 마이페이지 게시물 목록(무한스크롤)
	@GetMapping("/page/{page}")
	public List<BoardListVO> paging(@PathVariable int page, @RequestParam long memberNo){
		
		return forbiddenService.changeForbiddenWords(boardRepo.myPageSelectListPaging(page, memberNo));
	}
	
	@GetMapping("/postList")
	public List<BoardListVO> postList(@RequestParam long memberNo){
		
		List<BoardListVO> getTotalPost = boardRepo.getTotalMyPost(memberNo);
//		return forbiddenService.changeForbiddenBoard(getTotalPost);
		
		return getTotalPost;
	}
	
	@GetMapping("/bookmarkMyPost")
	public List<BoardListVO> bookmarkMyPost(HttpSession session){
		long memberNo = (long) session.getAttribute("memberNo");
		return forbiddenService.changeForbiddenWords(boardRepo.bookmarkMyPost(memberNo));
	}
	
	//닉네임 중복 확인
	@GetMapping("/checkNick/{memberNick}")
	public boolean checkNick(@PathVariable String memberNick) {
		MemberWithProfileDto memberDto = memberRepo.findByNickName(memberNick);
		if(memberDto==null) {
			return true;
		}
		else {
			return false;
		}
	}
	// 친구 추천목록 조회
	@GetMapping("/recommendFriendsList")
	public List<MemberProfileDto> recommendFriendsList(HttpSession session){
		long memberNo = (long)session.getAttribute("memberNo");
		SettingDto dto = settingRepo.selectOne(memberNo);
		List<MemberProfileDto> recommendFriendsList = memberRepo.recommendFriends(memberNo,dto.getSettingDistance());
		return recommendFriendsList;
	}
	
	// 특정회원 태그 목록 조회
	@GetMapping("/hashtagList")
	public List<TagFollowDto> hashtagList(@RequestParam long memberNo){
		List<TagFollowDto> hashtagList = memberRepo.hashtagList(memberNo);
		return hashtagList;
	}
	
	// 회원탈퇴
	@PostMapping("/deleteMember")
	public String deleteMember(HttpSession session) throws URISyntaxException {
		long memberNo = (long) session.getAttribute("memberNo");
		socialLoginService.kakaoDelete(memberNo);
		
		session.removeAttribute("memberNo");
		session.removeAttribute("socialUser");
		session.removeAttribute("memberLevel");
		session.removeAttribute("memberNick");
		
		//리포트가 있으면 찾아서 상태 변경해줌
		reportService.manageDeleted("member", memberNo);
		return "redirect:/member/login";
		
	}
	//닉네임불러오기
	@GetMapping("/nickname")
	public String getNickname(HttpSession session) {
		long memberNo = (long) session.getAttribute("memberNo");
		return memberRepo.findByNo(memberNo).getMemberNick();
	}
}
