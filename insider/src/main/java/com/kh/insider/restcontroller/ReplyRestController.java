package com.kh.insider.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.ReplyDto;
import com.kh.insider.dto.ReplyLikeDto;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.repo.ReplyLikeRepo;
import com.kh.insider.repo.ReplyRepo;
import com.kh.insider.service.ForbiddenService;
import com.kh.insider.service.ReportService;
import com.kh.insider.vo.ReplyLikeVO;

@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {
	
	@Autowired
	private ReplyRepo replyRepo;
	
	@Autowired
	private ReplyLikeRepo replyLikeRepo;
	@Autowired
	private BoardRepo boardRepo;
	@Autowired
	private ReportService reportService;
	@Autowired
	private ForbiddenService forbiddenService;
	
	//댓글 조회
	@GetMapping("/{replyOrigin}")
	public List<ReplyDto> list(@PathVariable int replyOrigin, HttpSession session) {
		long memberNo = (long) session.getAttribute("memberNo");
		return forbiddenService.changeForrbiddenReply(replyRepo.selectList(replyOrigin, memberNo));
	}
	
	//댓글 등록
	@PostMapping("/")
	public void write(HttpSession session, @RequestBody ReplyDto replyDto
			) {
		//작성자 설정
		long memberNo = (Long) session.getAttribute("memberNo");	
		replyDto.setReplyMemberNo(memberNo);
		//등록
		replyRepo.insert(replyDto);
		boardRepo.updateReply(replyDto.getReplyOrigin());
	}
	
	//댓글 삭제
	@DeleteMapping("/{replyNo}")
	public void delete(@PathVariable int replyNo, HttpSession session) {
		//본인인지 확인
		long memberNo = (long)session.getAttribute("memberNo");
		ReplyDto replyDto = replyRepo.selectOne(replyNo);
		if(replyDto.getReplyMemberNo()!=memberNo) return;
		
		replyRepo.delete(replyNo);
		
		boardRepo.updateReply(replyDto.getReplyOrigin());
		
		//리포트가 있으면 찾아서 상태 변경해줌
		reportService.manageDeleted("reply", replyNo);
	}
	
	
	//댓글 좋아요
		@PostMapping("/like")
		public ReplyLikeVO like(
				HttpSession session,
				@RequestBody ReplyLikeDto replyLikeDto
				) {
			//로그인 세션 값 받아오기
			long memberNo = (Long)session.getAttribute("memberNo");
			replyLikeDto.setMemberNo(memberNo);
			
			//댓글 좋아요 눌렀는지 확인
			//current가 true면 좋아요 삭제, false면 좋아요 등록
			boolean current = replyLikeRepo.check(replyLikeDto);
			if(current) {
				replyLikeRepo.delete(replyLikeDto);
			}
			else {
				replyLikeRepo.insert(replyLikeDto);
			}
			
			//ReplyDto.replyLike개수 설정
			int count = replyLikeRepo.count(replyLikeDto.getReplyNo());
			
			replyRepo.updateLikeCount(replyLikeDto.getReplyNo(), count);
			
			return ReplyLikeVO.builder()
						.result(!current)
						.count(count)
						.build();
		}
		
		//댓글 좋아요 여부 확인
		@PostMapping("/check")
		public boolean check(
				HttpSession session, @RequestBody ReplyLikeDto replyLikeDto
				) {
			long memberNo = (Long)session.getAttribute("memberNo");
			replyLikeDto.setMemberNo(memberNo);
			
			return replyLikeRepo.check(replyLikeDto);
		}
}
