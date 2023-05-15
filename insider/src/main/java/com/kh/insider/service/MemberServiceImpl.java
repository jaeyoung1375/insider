package com.kh.insider.service;

import java.io.IOException;
import java.util.Random;
import java.util.Scanner;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

@Repository
public class MemberServiceImpl implements MemberService{
	
	
	
	@Autowired
	private JavaMailSender sender;

	@Override
	public int RandomCode() {
		
		Random random = new Random();
		
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

	        sender.send(message);
	    } catch (MessagingException e) {
	        e.printStackTrace();
	    }
	    
	    return num;
	}
	

}
