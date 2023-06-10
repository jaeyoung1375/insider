package com.kh.insider.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.Scanner;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import com.kh.insider.dto.CertDto;
import com.kh.insider.dto.MemberDto;
import com.kh.insider.repo.CertRepo;
import com.kh.insider.repo.MemberRepo;

@Repository
public class MemberServiceImpl implements MemberService{
   
   private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+";
   
   @Autowired
   private JavaMailSender sender;
   
   @Autowired
   private CertRepo certRepo;
   
   @Autowired
   private PasswordEncoder encoder;
   
   @Autowired
   private MemberRepo memberRepo;
   
   Random random = new Random();

   @Override
   public int RandomCode() {
      
      
      
      return random.nextInt(888888)+111111;
   }

   public int sendEmail(String email) {
        int num = RandomCode();

       /* 이메일 전송 */
       MimeMessage message = sender.createMimeMessage();
       try {
           MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
           helper.setTo(email);
           helper.setSubject("Insider 회원가입 인증번호 입니다");

           ClassPathResource resource = new ClassPathResource("templates/email1.jsp");

           Scanner sc = null;
           try {
               sc = new Scanner(resource.getFile());
           } catch (IOException e) {
               e.printStackTrace();
           }

           StringBuilder emailContent = new StringBuilder(); // StringBuilder를 사용하여 문자열 조합

           while (sc.hasNextLine()) {
               emailContent.append(sc.nextLine());
           }

           // 인증번호 값으로 문자열 치환
           emailContent.replace(emailContent.indexOf("${num}"), emailContent.indexOf("${num}") + "${num}".length(), String.valueOf(num));

           helper.setText(emailContent.toString(), true);
   
           // 이메일 발송
           sender.send(message);
           
           // 데이터베이스 등록
           CertDto certDto = new CertDto();
           certDto.setEmail(email);
           certDto.setSecret(Integer.toString(num));
           certRepo.insert(certDto);
       } catch (MessagingException e) {
           e.printStackTrace();
       }
       
       return num;
   }

   @Override
   public String generatTempPassword() {
      
      
      StringBuilder tempPassword = new StringBuilder();
      
      for(int i = 0; i<10; i++) {
         int index = random.nextInt(CHARACTERS.length());
         char randomChar = CHARACTERS.charAt(index);
         tempPassword.append(randomChar);
      }
      
      return tempPassword.toString();
      
   }

	@Override
	public void changePassword(MemberDto memberDto) {
		String encrypt = encoder.encode(memberDto.getMemberPassword());
		memberDto.setMemberPassword(encrypt);
		
		memberRepo.changePassword(memberDto);
	}

	@Override
	public void join(MemberDto memberDto) {
		String encrypt = encoder.encode(memberDto.getMemberPassword());
		memberDto.setMemberPassword(encrypt);
		memberRepo.join(memberDto);
	}

	@Override
	public boolean checkPassword(String enteredPassword, String encodedPassword) {	
		System.out.println(encoder.matches(enteredPassword, encodedPassword));
	    return encoder.matches(enteredPassword, encodedPassword);
	}

	@Override
	public MemberDto login(String memberEmail, String memberPassword) {
		MemberDto findMember = memberRepo.findByEmail(memberEmail);
		
		Map<String, Object> param = new HashMap<>();
		param.put("memberEmail",memberEmail);
		param.put("memberPassword",findMember.getMemberPassword());
		
		if(encoder.matches(memberPassword, findMember.getMemberPassword())) {
			return memberRepo.login(memberEmail, findMember.getMemberPassword());
		}else {
			return null;
		}
	}
	
	
   

}