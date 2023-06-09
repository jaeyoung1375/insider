package com.kh.insider.controller;


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

import com.kh.insider.dto.MemberDto;
import com.kh.insider.dto.MemberWithProfileDto;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.repo.FollowRepo;
import com.kh.insider.repo.MemberRepo;
import com.kh.insider.repo.MemberWithProfileRepo;
import com.kh.insider.repo.SettingRepo;
import com.kh.insider.service.MemberService;
import com.kh.insider.service.SocialLoginService;

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
   private BoardRepo boardRepo;
   
   @Autowired
   private FollowRepo followRepo;
   
   @Autowired
   private MemberWithProfileRepo memberWithProfileRepo;
   
   @Autowired
   private SocialLoginService socialLoginService;
   
   @GetMapping("/join")
   public String join() {
      return "member/join";
   }
   
   @PostMapping("/join")
   public String join(@ModelAttribute MemberDto dto) {
      memberRepo.join(dto);
      //기본 회원설정값 생성(닉네임 받아서 생성함)
      MemberWithProfileDto newMemberDto = memberRepo.findByNickName(dto.getMemberNick());
      settingRepo.basicInsert(newMemberDto.getMemberNo());
      return "redirect:/";
   }
   
   @GetMapping("/login")
   public String login() {
      return "member/login";
   }
   
   @PostMapping("/login")
   public String login(HttpSession session, @ModelAttribute MemberDto dto, RedirectAttributes attr, HttpServletRequest request) {
   MemberDto findMember = memberRepo.login(dto.getMemberEmail(),dto.getMemberPassword());
   
   if(findMember == null) {
      int result = 0;
      attr.addFlashAttribute("result",result);
      return "redirect:login";
   }
   session.setAttribute("memberNo",findMember.getMemberNo());
   session.setAttribute("socialUser", findMember);
   memberRepo.updateLoginTime(findMember.getMemberNo());
   
   session.setAttribute("memberLevel",findMember.getMemberLevel());
   session.setAttribute("memberNick",findMember.getMemberNick());
   return "redirect:/";
   }
   
   @GetMapping("/logout")
   public String logout(HttpSession session) {
      session.removeAttribute("memberNo");
      session.removeAttribute("socialUser");
      session.removeAttribute("memberLevel");
      session.removeAttribute("memberNick");
      
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
      // 본인 프로필 인지 여부
      int postCounts = boardRepo.getTotalPostCount(dto.getMemberNo());
	  long memberNo=(long) session.getAttribute("memberNo");
      boolean isOwner = memberNo==dto.getMemberNo();
      
      
      model.addAttribute("memberDto",findMember);
      model.addAttribute("isOwner",isOwner);
      model.addAttribute("postCounts",postCounts);
            
      return "/member/mypage";
   }
   
   // 팔로우 총 개수
   @GetMapping("/totalFollowCount")
   @ResponseBody
   public int totalFollowCount(@RequestParam("memberNo") long memberNo) {
	   MemberWithProfileDto findMember = memberWithProfileRepo.selectOne(memberNo);
       int totalFollowCount = followRepo.getFollowNumber(findMember.getMemberNo());
       return totalFollowCount;
   }
   
   // 팔로워 총 개수
   @GetMapping("/totalFollowerCount")
   @ResponseBody
   public int totalFollowerCount(@RequestParam("memberNo") long memberNo) {
	   MemberWithProfileDto findMember = memberWithProfileRepo.selectOne(memberNo);
       int totalFollowerCount = followRepo.getFollowerNumber(findMember.getMemberNo());
       return totalFollowerCount;
   }
   
   // 게시물 총 개수
   @GetMapping("/totalPostCount")
   @ResponseBody
   public int totalPostCount(@RequestParam("memberNo") long memberNo) {
	   MemberWithProfileDto findMember = memberWithProfileRepo.selectOne(memberNo);
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
	   member.setMemberPassword(socialLoginService.EncryptCoskey(member.getMemberPassword()));

	   memberRepo.changePassword(member);
   }
 
//   @GetMapping("/facebook/auth")
//   @ResponseBody
//   public String facebookLogin(String code, FacebookResponseVO response) throws URISyntaxException{
//      
//      response = socialLoginService.facebookTokenCreate(code);
//      FacebookProfileVO profile = socialLoginService.facebookLogin(code, response);
//      System.out.println(profile);
//      
//      return profile.toString();
//   }
   
//   환경설정 페이지
   @GetMapping("/setting")
   public String setting() {
      return"member/setting";
   }

}