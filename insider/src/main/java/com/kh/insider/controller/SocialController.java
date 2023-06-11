package com.kh.insider.controller;

import java.net.URISyntaxException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.kh.insider.dto.MemberDto;
import com.kh.insider.repo.MemberRepo;
import com.kh.insider.service.SocialLoginService;
import com.kh.insider.vo.GoogleProfileVO;
import com.kh.insider.vo.GoogleResponseVO;
import com.kh.insider.vo.KakaoProfileVO;
import com.kh.insider.vo.KakaoResponseVO;

@Controller
public class SocialController {
   
   @Value("${cos.key}")
   private String cosKey;
   
   @Autowired
   private SocialLoginService socialLoginService; 
   @Autowired
   private MemberRepo memberRepo;
   
   
   // 카카오 로그인
   @GetMapping("/kakao/login")
   public String kakaoCallback(String code,
         HttpSession session, KakaoResponseVO token, Model model) throws URISyntaxException { // Data를 리턴해주는 컨트롤러 함수
               
         token = socialLoginService.kakaoTokenCreate(code);
         MemberDto kakaoUser = new MemberDto();
         KakaoProfileVO profile = socialLoginService.kakaoLogin(code,token);
         Long memberNo = profile.getId();
         String memberEmail = profile.kakao_account.getEmail();
         String memberPw = socialLoginService.EncryptCoskey(cosKey);
         MemberDto originalMember = memberRepo.findByEmail(profile.kakao_account.getEmail());
         try {	
        	 if(originalMember == null) {
        		 
                 System.out.println("회원가입을 진행합니다..");
                 kakaoUser.setMemberNo(memberNo);
                 kakaoUser.setMemberEmail(memberEmail);                   
                 kakaoUser.setMemberPassword(memberPw);
                                       
              }else {
                 System.out.println("기존회원이므로 로그인을 진행합니다.");
                 // 로그인 시각 갱신
                 memberRepo.updateLoginTime(originalMember.getMemberNo());
                 // 회원정보
                 session.setAttribute("memberNo", originalMember.getMemberNo());
                 session.setAttribute("memberLevel", originalMember.getMemberLevel());
                 session.setAttribute("memberNick", originalMember.getMemberNick());
                 // 토큰정보
                 session.setAttribute("access_token",token.getAccess_token());
                 // 리프레시 토큰 정보
                 session.setAttribute("refresh_token",token.getRefresh_token());
                 return "redirect:/";
              }
        	 
         }catch(Exception ex) {
        	 return "redirect:/error/socialError";
         }
         
        
         // addInfo로 넘길 정보
         session.setAttribute("loginUser",kakaoUser);
         
         
         return "redirect:/member/addInfo";
      }
   
   @GetMapping("/google/login")
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
         // 로그인 시각 갱신
         memberRepo.updateLoginTime(originalMember.getMemberNo());
         session.setAttribute("memberNo", originalMember.getMemberNo());
         session.setAttribute("memberLevel", originalMember.getMemberLevel());
         session.setAttribute("memberNick", originalMember.getMemberNick());
         // 토큰정보
         session.setAttribute("access_token",response.getAccess_token());
         session.setAttribute("refresh_token",response.getRefresh_token());
         return "redirect:/";
      }
      // addInfo로 넘길 정보
      session.setAttribute("loginUser",googleUser);
      

      return "redirect:/member/addInfo";
   }
   
      
   

}