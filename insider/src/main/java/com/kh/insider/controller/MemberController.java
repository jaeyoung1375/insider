package com.kh.insider.controller;

import java.net.URISyntaxException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.insider.dto.BoardDto;
import com.kh.insider.dto.FollowWithProfileDto;
import com.kh.insider.dto.FollowerWithProfileDto;
import com.kh.insider.dto.MemberDto;
import com.kh.insider.dto.MemberWithProfileDto;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.repo.FollowRepo;
import com.kh.insider.repo.MemberRepo;
import com.kh.insider.repo.MemberWithProfileRepo;
import com.kh.insider.repo.SettingRepo;
import com.kh.insider.service.MemberService;
import com.kh.insider.service.SocialLoginService;
import com.kh.insider.vo.FacebookProfileVO;
import com.kh.insider.vo.FacebookResponseVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@CrossOrigin
@RequestMapping("/member")
public class MemberController {
   
   @Value("${cos.key}")
   private String cosKey;
   
   @Autowired
   private MemberRepo memberRepo;
   @Autowired
   private MemberService memberService;
   
   @Autowired
   private SettingRepo settingRepo;
   
   @Autowired
   private SocialLoginService socialLoginService;
   
   @Autowired
   private BoardRepo boardRepo;
   
   @Autowired
   private FollowRepo followRepo;
   
   @Autowired
   private MemberWithProfileRepo memberWithProfileRepo;
   
   @GetMapping("/join")
   public String join() {
      return "member/join";
   }
   
   @PostMapping("/join")
   public String join(@ModelAttribute MemberDto dto) {
      memberRepo.join(dto);
      //기본 회원설정값 생성(추후 수정 필요)
//      settingRepo.basicInsert(dto.getMemberNo());
      return "redirect:/";
   }
   
   @GetMapping("/login")
   public String login() {
      return "member/login";
   }
   
   @PostMapping("/login")
   public String login(HttpSession session, @ModelAttribute MemberDto dto, RedirectAttributes attr, HttpServletRequest request) {
   session = request.getSession();
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
   
   @GetMapping("/{memberNick}")
   public String myPage(@PathVariable String memberNick, Model model, HttpSession session) {
      
	   MemberWithProfileDto dto = memberRepo.findByNickName(memberNick);
      // 프로필 정보 불러오기
	   MemberWithProfileDto findMember = memberWithProfileRepo.selectOne(dto.getMemberNo());
      // 로그인한 사용자
      MemberDto loginUser = (MemberDto)session.getAttribute("socialUser");
      log.debug("로그인한 사용자:{}", loginUser);
      // 본인 프로필 인지 여부
      boolean isOwner = loginUser.getMemberNo().equals(dto.getMemberNo());
      
      
      model.addAttribute("memberDto",findMember);
      model.addAttribute("isOwner",isOwner);
            
      return "/member/mypage";
   }
   
   // 팔로우 총 개수
   @GetMapping("/totalFollowCount")
   @ResponseBody
   public int totalFollowCount(@RequestParam("memberNick") String memberNick) {
	   MemberWithProfileDto findMember = memberRepo.findByNickName(memberNick);
       int totalFollowCount = followRepo.getFollowNumber(findMember.getMemberNo());
       return totalFollowCount;
   }
   
   // 팔로워 총 개수
   @GetMapping("/totalFollowerCount")
   @ResponseBody
   public int totalFollowerCount(@RequestParam("memberNick") String memberNick) {
	   MemberWithProfileDto findMember = memberRepo.findByNickName(memberNick);
       int totalFollowerCount = followRepo.getFollowerNumber(findMember.getMemberNo());
       return totalFollowerCount;
   }
   
   // 게시물 총 개수
   @GetMapping("/totalPostCount")
   @ResponseBody
   public int totalPostCount(@RequestParam("memberNick") String memberNick) {
	   MemberWithProfileDto findMember = memberRepo.findByNickName(memberNick);
	   int totalPostCount = boardRepo.getTotalPostCount(findMember.getMemberNo());
	   return totalPostCount;
   }
   
   
   @GetMapping("/emailCheck")
   @ResponseBody
   public String isEmailDuplicated(@RequestParam String memberEmail) throws Exception {
      
      int result = memberRepo.isEmailDuplicated(memberEmail);
      log.debug("result = {}",result);
      
      if(result != 0) {
         return "fail";
      }else {
         return "success";
      }
   }
   
   @GetMapping("/sendMail")
   @ResponseBody
   public String sendMail(@RequestParam String memberEmail) {
      
      int num = memberService.sendEmail(memberEmail);
      System.out.println(Integer.toString(num));
      return Integer.toString(num);
      
   }
   
   @GetMapping("/nickCheck")
   @ResponseBody
   public String isNickDuplicated(@RequestParam String memberNick) throws Exception{
      
      int result = memberRepo.isNickDuplicated(memberNick);
      if(result != 0) {
         return "fail";
      }else {
         return "success";
      }
   }
   
   @GetMapping("/passwordSearch")
   public String passwordSearch() {
      return "member/passwordSearch";
   }
   
   @GetMapping("/resetPassword")
   public String resetPassword() {
	   return "/member/resetPassword";
   }
   
   @PostMapping("/passwordChange")
   @ResponseBody
   public void passwordChange(@RequestBody MemberDto member) {
	   member.setMemberEmail(member.getMemberEmail());
	   member.setMemberPassword(member.getMemberPassword());

	   memberRepo.changePassword(member);
   }
   
  
   
   
   @GetMapping("/facebook/auth")
   @ResponseBody
   public String facebookLogin(String code, FacebookResponseVO response) throws URISyntaxException{
      
      response = socialLoginService.facebookTokenCreate(code);
      FacebookProfileVO profile = socialLoginService.facebookLogin(code, response);
      System.out.println(profile);
      
      return profile.toString();
   }
   
//   환경설정 페이지
   @GetMapping("/setting")
   public String setting() {
      return"member/setting";
   }

}