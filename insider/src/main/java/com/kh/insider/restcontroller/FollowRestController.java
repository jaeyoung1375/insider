package com.kh.insider.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.FollowDto;
import com.kh.insider.dto.FollowWithProfileDto;
import com.kh.insider.repo.FollowRepo;
import com.kh.insider.repo.MemberRepo;

@RestController
@RequestMapping("/rest/follow")
public class FollowRestController {
	@Autowired
	private FollowRepo followRepo;
	@Autowired
	private MemberRepo memberRepo;
	
	//팔로우 및 팔로워 반환(필요한 사람이 VO 적절하게 만들어서 쓰세요
//	@GetMapping("/")
//	public List<FollowWithProfileDto> getFollowList(@PathVariable long ){
//		
//	}
	
	//팔로우/언팔로우 작업 후 팔로우 여부 반환(true = follow 된 상태)
	@PostMapping("/{followerNo}")
	public boolean follow(@PathVariable long followerNo, HttpSession session) {
		long memberNo = (long)session.getAttribute("memberNo");
		FollowDto followDto = new FollowDto();
		followDto.setMemberNo(memberNo);
		followDto.setFollowFollower(followerNo);
		
		FollowDto checkDto = followRepo.selectOne(followDto);
		if(checkDto==null) {
			followRepo.insert(followDto);
			return true;
		}
		else {
			followRepo.delete(followDto);
			return false;
		}
	}
	
//	@GetMapping("/check/{followerNo}")
//	public FollowDto followCheck(@PathVariable long followerNo, HttpSession session) {
//		long memberNo = (Long)session.getAttribute("memberNo");
//		FollowDto followDto = new FollowDto();
//		followDto.setMemberNo(memberNo);
//		followDto.setFollowFollower(followerNo);
//		
//		return followRepo.selectOne(followDto);
//	}
	
	@PostMapping("/check")
	public List<Long> followcheck(
			HttpSession session) {
		long memberNo = (Long)session.getAttribute("memberNo");
		
		 return followRepo.check(memberNo);
	}
}
