package com.kh.insider.controller;

import java.net.URISyntaxException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.insider.dto.MemberDto;
import com.kh.insider.repo.MemberRepo;
import com.kh.insider.service.SocialLoginService;
import com.kh.insider.vo.KakaoProfile;
import com.kh.insider.vo.OAuthToken;
import com.kh.insider.repo.SettingRepo;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
public class MemberController {
	
	@Value("${cos.key}")
	private String cosKey;
	
	
	@Autowired
	private MemberRepo memberRepo;
	@Autowired
	private SettingRepo settingRepo;
	
	@Autowired
	private SocialLoginService socialLoginService;
	
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto dto) {
		memberRepo.join(dto);
		//기본 회원설정값 생성(추후 수정 필요)
		settingRepo.basicInsert(dto.getMemberNo());
		return "redirect:join";
	}
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("/login")
	public String login(HttpSession session, @ModelAttribute MemberDto dto) {
		
	MemberDto findMember = memberRepo.login(dto.getMemberEmail(), dto.getMemberPassword());
	
	if(findMember == null) {
		return "redirect:login";
	}
	session.setAttribute("memberEmail",findMember.getMemberEmail());
		
	return "redirect:/";
	}
	
	// 카카오 로그인
	@GetMapping("/auth/kakao/callback")
	public String kakaoCallback(String code,
			HttpSession session, OAuthToken token) throws URISyntaxException { // Data를 리턴해주는 컨트롤러 함수
				
		token = socialLoginService.tokenCreate(code);
		MemberDto kakaoUser = new MemberDto();
		KakaoProfile profile = socialLoginService.kakaoLogin(code,token);
		long memberNo = profile.getId();
		String memberEmail = profile.kakao_account.getEmail();
		String memberPw = cosKey;
		String memberName = profile.properties.getNickname();
		String memberNickName = profile.properties.getNickname();
		String memberTel = profile.kakao_account.getPhone_number();
		String memberGender = profile.getKakao_account().getGender();
		MemberDto originalMember = memberRepo.findByEmail(profile.kakao_account.getEmail());
		
		
		
		if(originalMember == null) {
			System.out.println("회원가입을 진행합니다");
			kakaoUser.setMemberNo(memberNo);
			kakaoUser.setMemberEmail(memberEmail);
			kakaoUser.setMemberName(memberName);
			kakaoUser.setMemberNick(memberNickName);
			kakaoUser.setMemberPassword(memberPw);
			kakaoUser.setMemberTel("010-1234");
			
			// 생년월일 - 추후 수정
			kakaoUser.setMemberBirth("1997-01-28");
			kakaoUser.setMemberGender(memberGender);
			// 주소 - 추후 수정
			kakaoUser.setMemberPost("12345");
			kakaoUser.setMemberBasicAddr("영등포구");
			kakaoUser.setMemberDetailAddr("당산이레빌딩");
			
			
			memberRepo.join(kakaoUser);
		}else {
			System.out.println("기존회원이므로 로그인을 진행합니다.");
		}
		
		session.setAttribute("member",token.getAccess_token());
		session.setAttribute("refresh_token",token.getRefresh_token());
		
		
		String accessToken = token.getAccess_token();
		System.out.println(accessToken);
		System.out.println(profile);
		
		System.out.println(profile.getKakao_account().getBirthyear());
		System.out.println(profile.getKakao_account().getBirthday());
		return "redirect:/";
	}

}
