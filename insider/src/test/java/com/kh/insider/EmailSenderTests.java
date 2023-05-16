package com.kh.insider;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

//목표 : src/main/resources/templates/email.html을 읽어와서 메일로 발송
@SpringBootTest
public class EmailSenderTests {

	@Autowired
	private JavaMailSender sender;
	
	@Test
	public void test() throws MessagingException, FileNotFoundException, IOException {
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = 
				new MimeMessageHelper(message, false, "UTF-8");
		
		helper.setTo("jaeyoung1375@naver.com");
		helper.setSubject("마임메세지 템플릿 테스트");
		
		//email.html의 내용을 읽어와서 첨부
		//- ClassPathResource는 주어진 경로 앞에 classpath:/를 첨부하여 탐색
		ClassPathResource resource = 
						new ClassPathResource("templates/email.html");
		Scanner sc = new Scanner(resource.getFile());
		StringBuffer buffer = new StringBuffer();
		
		while(sc.hasNextLine()) {//읽을 줄이 남았다면
			buffer.append(sc.nextLine());//한 줄을 읽어서 buffer에 추가해라
		}
		
		
		//변경한 내용을 첨부
		helper.setText(buffer.toString(), true);
		
		sender.send(message);//전송
	}
	
}

