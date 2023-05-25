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
import com.kh.insider.repo.MemberSuspensionRepo;

@RestController
@RequestMapping("/rest/suspension")
public class SuspensionRestController {

	@Autowired
	private MemberSuspensionRepo memberSuspensionRepo;
	
	@PostMapping("/")
	public void insert(@RequestBody MemberSuspensionDto memberSuspensionDto) {
		memberSuspensionRepo.insert(memberSuspensionDto);
	}
	@GetMapping("/{memberNo}")
	public MemberSuspensionDto selectOne(@PathVariable long memberNo) {
		return memberSuspensionRepo.selectOne(memberNo);
	}
	@PutMapping("/")
	public void removeSuspension(@RequestBody long memberNo) {
		memberSuspensionRepo.removeSuspension(memberNo);
	}
	@PutMapping("/add")
	public void addSuspension(@RequestBody MemberSuspensionDto memberSuspensionDto) {
		memberSuspensionRepo.addSuspension(memberSuspensionDto);
	}
}
