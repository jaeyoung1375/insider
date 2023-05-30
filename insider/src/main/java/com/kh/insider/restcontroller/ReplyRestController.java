package com.kh.insider.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.ReplyDto;
import com.kh.insider.repo.MemberRepo;
import com.kh.insider.repo.ReplyRepo;

@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {
	
	@Autowired
	private ReplyRepo replyRepo;
	
	@Autowired
	private MemberRepo memberRepo;
	
	//댓글 조회
	@GetMapping("/{replyOrigin}")
	public List<ReplyDto> list(@PathVariable int replyOrigin) {
		return replyRepo.selectList(replyOrigin);
	}
	
	//댓글 등록
	@PostMapping("/")
	public void write(HttpSession session, @RequestBody ReplyDto replyDto
			) {
		//작성자 설정
		long memberNo = (Long) session.getAttribute("memberNo");	
		//회원 번호 및 회원 닉네임 설정
		replyDto.setReplyMemberNo(memberNo);
		
		//등록
		replyRepo.insert(replyDto);
	}
	
	//댓글 삭제
	@DeleteMapping("/{replyNo}")
	public void delete(@PathVariable int replyNo) {
		//Dto에서 멤버 닉네임 삭제
		
		
		//댓글삭제
		replyRepo.delete(replyNo);
	}
	
	//댓글 수정
	@PatchMapping("/")
	public void edit(@ModelAttribute ReplyDto replyDto) {
		replyRepo.edit(replyDto);
	}
	
}
