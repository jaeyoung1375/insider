package com.kh.insider.controller;

import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.insider.dto.MemberDto;
import com.kh.insider.repo.MemberRepo;
import com.kh.insider.service.SocialLoginService;
import com.kh.insider.vo.FacebookProfileVO;
import com.kh.insider.vo.FacebookResponseVO;
import com.kh.insider.vo.GoogleProfileVO;
import com.kh.insider.vo.GoogleResponseVO;
import com.kh.insider.vo.KakaoProfileVO;
import com.kh.insider.vo.KakaoResponseVO;
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
//		settingRepo.basicInsert(dto.getMemberNo());
		return "redirect:/";
	}
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("/login")
	public String login(HttpSession session, @ModelAttribute MemberDto dto, RedirectAttributes attr) {
		
	MemberDto findMember = memberRepo.login(dto.getMemberEmail(), dto.getMemberPassword());
	
	if(findMember == null) {
		int result = 0;
		attr.addFlashAttribute("result",result);
		return "redirect:login";
	}
	memberRepo.updateLoginTime(findMember.getMemberNo());
	session.setAttribute("memberNo",findMember.getMemberNo());
	session.setAttribute("socialUser", findMember);
		
	return "redirect:/";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("memberNo");
		session.removeAttribute("socialUser");
		session.removeAttribute("member");
		
		return "redirect:/";
	}
	
	
	// 카카오 로그인
	@GetMapping("/auth/kakao/callback")
	public String kakaoCallback(String code,
			HttpSession session, KakaoResponseVO token, Model model) throws URISyntaxException { // Data를 리턴해주는 컨트롤러 함수
				
		token = socialLoginService.kakaoTokenCreate(code);
		MemberDto kakaoUser = new MemberDto();
		KakaoProfileVO profile = socialLoginService.kakaoLogin(code,token);
		Long memberNo = profile.getId();
		String memberEmail = profile.kakao_account.getEmail();
		String memberPw = cosKey;
		MemberDto originalMember = memberRepo.findByEmail(profile.kakao_account.getEmail());
		
		
		
		if(originalMember == null) {
			System.out.println("회원가입을 진행합니다..");
			kakaoUser.setMemberNo(memberNo);
			kakaoUser.setMemberEmail(memberEmail);
			kakaoUser.setMemberPassword(memberPw);
				
		}else {
			System.out.println("기존회원이므로 로그인을 진행합니다.");
			// 로그인 시각 갱신
			memberRepo.updateLoginTime(memberNo);
			// 회원정보
			session.setAttribute("socialUser",originalMember);
			session.setAttribute("memberNo", originalMember.getMemberNo());
			// 토큰정보
			session.setAttribute("member",token.getAccess_token());
			// 리프레시 토큰 정보
			session.setAttribute("refresh_token",token.getRefresh_token());
			return "redirect:/";
		}
		// addInfo로 넘길 정보
		session.setAttribute("loginUser",kakaoUser);
		session.setAttribute("member",token.getAccess_token());
		session.setAttribute("refresh_token",token.getRefresh_token());
		
		
		return "redirect:/member/addInfo";
	}
	
	@GetMapping("/addInfo")
	public String addInfo(Model model, HttpSession session) {

		MemberDto loginUser =(MemberDto) session.getAttribute("loginUser");

		model.addAttribute("loginUser",loginUser);
		
		return "member/addInfo";
	}
	
	@PostMapping("/addInfo")
	public String addInfo(@ModelAttribute MemberDto dto) {
	
		memberRepo.socialJoin(dto);
		
		return "redirect:/";
	}
	
	@GetMapping("/login/oauth_google_check")
	public String googleCallback(String code, GoogleResponseVO response, HttpSession session) throws URISyntaxException {
		response =  socialLoginService.googleTokenCreate(code);
		MemberDto googleUser = new MemberDto();
		GoogleProfileVO profile = socialLoginService.googleLogin(code,response);
		MemberDto originalMember = memberRepo.findByEmail(profile.getEmail());
		UUID uuid = UUID.randomUUID();
		String uuidString = uuid.toString();
		  // 하이픈(-) 제거
        String uuidWithoutHyphens = uuidString.replaceAll("-", "");
        // 숫자 부분 추출
        String numbersOnly = uuidWithoutHyphens.replaceAll("\\D", "");
        numbersOnly = numbersOnly.substring(0,10);
		
		Long memberNo = Long.parseLong(numbersOnly);
		String memberEmail = profile.getEmail();
		String memberPw = cosKey;
		String memberName = profile.getName();
		
		
		
		if(originalMember == null) {
			System.out.println("회원가입을 진행합니다");
			googleUser.setMemberNo(memberNo);
			googleUser.setMemberEmail(memberEmail);
			googleUser.setMemberName(memberName);
			googleUser.setMemberPassword(memberPw);

			
		}else {
			System.out.println("기존회원이므로 로그인을 진행합니다.");
			// 회원정보
			session.setAttribute("socialUser",originalMember);
			session.setAttribute("memberNo", originalMember.getMemberNo());
			// 토큰정보
			session.setAttribute("member",response.getAccess_token());
			session.setAttribute("refresh_token",response.getRefresh_token());
			return "redirect:/";
		}
		// addInfo로 넘길 정보
		session.setAttribute("socialUser",googleUser);
		session.setAttribute("member",response.getAccess_token());
		session.setAttribute("refresh_token",response.getRefresh_token());
		

		return "redirect:/member/addInfo";
	}
	
	@GetMapping("/facebook/auth")
	@ResponseBody
	public String facebookLogin(String code, FacebookResponseVO response) throws URISyntaxException{
		
		response = socialLoginService.facebookTokenCreate(code);
		FacebookProfileVO profile = socialLoginService.facebookLogin(code, response);
		System.out.println(profile);
		
		return profile.toString();
	}
	
	
	
//	환경설정 페이지
	@GetMapping("/setting")
	public String setting() {
		return"member/setting";
	}

}
