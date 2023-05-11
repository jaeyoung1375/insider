package com.kh.insider.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.MemberDto;
import com.kh.insider.dto.MemberWithProfileDto;
import com.kh.insider.dto.SettingDto;
import com.kh.insider.repo.MemberRepo;
import com.kh.insider.repo.MemberWithProfileRepo;
import com.kh.insider.repo.SettingRepo;

@RestController
@RequestMapping("/rest/member")
public class MemberRestController {
	@Autowired
	private SettingRepo settingRepo;
	@Autowired
	private MemberWithProfileRepo memberWithProfileRepo;
	@Autowired
	private MemberRepo memberRepo;
	
	//멤버정보 불러오기
	@GetMapping("/{memberNo}")
	public MemberWithProfileDto getMember(@PathVariable int memberNo) {
		return memberWithProfileRepo.selectOne(memberNo);
	}
	//멤버정보 수정
	@PutMapping("/")
	public void putMember(@RequestBody MemberDto memberDto) {
		memberRepo.update(memberDto);
	}
	
	//환경설정 불러오기
	@GetMapping("/setting/{memberNo}")
	public SettingDto setting(@PathVariable int memberNo) {
		return settingRepo.selectOne(memberNo);
	}
	
	//환경설정 수정
	@PutMapping("/setting/")
	public void update(@RequestBody SettingDto settingDto) {
		settingRepo.update(settingDto);
	}
}
