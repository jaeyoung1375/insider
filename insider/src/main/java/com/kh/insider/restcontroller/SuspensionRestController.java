package com.kh.insider.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.MemberSuspensionDto;
import com.kh.insider.dto.MemberWithSuspensionDto;
import com.kh.insider.repo.MemberSuspensionRepo;
import com.kh.insider.repo.MemberWithProfileRepo;

@RestController
@RequestMapping("/rest/suspension")
public class SuspensionRestController {

	@Autowired
	private MemberSuspensionRepo memberSuspensionRepo;
	@Autowired
	private MemberWithProfileRepo memberWithProfileRepo;
	
	@PostMapping("/")
	public MemberWithSuspensionDto insert(@RequestBody MemberSuspensionDto  memberSuspensionDto) {
		if(memberSuspensionRepo.selectOne(memberSuspensionDto.getMemberNo())==null) {
			memberSuspensionRepo.insert(memberSuspensionDto);
		}
		else {
			memberSuspensionRepo.addSuspension(memberSuspensionDto);
		}
		return memberWithProfileRepo.suspensionSelectOne(memberSuspensionDto.getMemberNo());
	}
	@GetMapping("/{memberNo}")
	public MemberSuspensionDto selectOne(@PathVariable long memberNo) {
		return memberSuspensionRepo.selectOne(memberNo);
	}
	@PutMapping("/")
	public MemberWithSuspensionDto removeSuspension(@RequestBody MemberSuspensionDto memberSuspensionDto) {
		long memberNo = memberSuspensionDto.getMemberNo();
		memberSuspensionRepo.removeSuspension(memberNo);
		return memberWithProfileRepo.suspensionSelectOne(memberNo);
	}
}
