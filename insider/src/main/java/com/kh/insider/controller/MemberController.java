package com.kh.insider.controller;

import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.insider.dto.MemberDto;
import com.kh.insider.repo.MemberRepo;
import com.kh.insider.service.SocialLoginService;
import com.kh.insider.vo.GoogleInfoResponse;
import com.kh.insider.vo.GoogleResponse;
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
	memberRepo.updateLoginTime(findMember.getMemberNo());
	session.setAttribute("memberEmail",findMember.getMemberEmail());
		
	return "redirect:/";
	}
	
	// 카카오 로그인
	@GetMapping("/auth/kakao/callback")
	public String kakaoCallback(String code,
			HttpSession session, OAuthToken token, Model model) throws URISyntaxException { // Data를 리턴해주는 컨트롤러 함수
				
		token = socialLoginService.kakaoTokenCreate(code);
		MemberDto kakaoUser = new MemberDto();
		KakaoProfile profile = socialLoginService.kakaoLogin(code,token);
		long memberNo = profile.getId();
		String memberEmail = profile.kakao_account.getEmail();
		String memberPw = cosKey;
		String memberName = profile.properties.getNickname();
		String memberNickName = profile.properties.getNickname();
		MemberDto originalMember = memberRepo.findByEmail(profile.kakao_account.getEmail());
		
		
		
		if(originalMember == null) {
			System.out.println("회원가입을 진행합니다");
			kakaoUser.setMemberNo(memberNo);
			kakaoUser.setMemberEmail(memberEmail);
			kakaoUser.setMemberName(memberName);
			kakaoUser.setMemberNick(memberNickName);
			kakaoUser.setMemberPassword(memberPw);

			
			
//			memberRepo.join(kakaoUser);
		}else {
			System.out.println("기존회원이므로 로그인을 진행합니다.");
			memberRepo.updateLoginTime(memberNo);
			return "redirect:/";
		}
		session.setAttribute("socialUser",kakaoUser);
		session.setAttribute("member",token.getAccess_token());
		session.setAttribute("refresh_token",token.getRefresh_token());
		
		
		String accessToken = token.getAccess_token();
		System.out.println(accessToken);
		System.out.println(profile);
		
		return "redirect:/member/addInfo";
	}
	
	@GetMapping("/addInfo")
	public String addInfo(Model model, HttpSession session) {

		MemberDto socialUser = (MemberDto)session.getAttribute("socialUser");
		model.addAttribute("socialUser",socialUser);
		
		return "member/addInfo";
	}
	
	@PostMapping("/addInfo")
	public String addInfo(@ModelAttribute MemberDto dto) {
	
		memberRepo.join(dto);
		
		return "redirect:/";
	}
	
	@GetMapping("/login/oauth_google_check")
	public String googleCallback(String code, GoogleResponse response, HttpSession session) throws URISyntaxException {
		response =  socialLoginService.googleTokenCreate(code);
		MemberDto googleUser = new MemberDto();
		GoogleInfoResponse profile = socialLoginService.googleLogin(code,response);
		MemberDto originalMember = memberRepo.findByEmail(profile.getEmail());
		String memberNoReplace = profile.getAzp().replaceAll("[^0-9]","");
		memberNoReplace = memberNoReplace.substring(0, 10);
		profile.setAzp(memberNoReplace);
		System.out.println(profile.getAzp());
		
		long memberNo = Long.parseLong(profile.getAzp());
		String memberEmail = profile.getEmail();
		String memberPw = cosKey;
		String memberName = profile.getName();
		String memberNickName = profile.getName();
		
		
		if(originalMember == null) {
			System.out.println("회원가입을 진행합니다");
			googleUser.setMemberNo(memberNo);
			googleUser.setMemberEmail(memberEmail);
			googleUser.setMemberName(memberName);
			googleUser.setMemberNick(memberNickName);
			googleUser.setMemberPassword(memberPw);

			
		}else {
			System.out.println("기존회원이므로 로그인을 진행합니다.");
			return "redirect:/";
		}
		session.setAttribute("socialUser",googleUser);
		session.setAttribute("member",response.getAccess_token());
		session.setAttribute("refresh_token",response.getRefresh_token());
		

		return "redirect:/member/addInfo";
	}

}
