package com.kh.insider.restcontroller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.BlockDto;
import com.kh.insider.repo.BlockRepo;

@RestController
@RequestMapping("/rest/block")
public class BlockRestController {
	@Autowired
	private BlockRepo blockRepo;
	
	@GetMapping("/{blockNo}")
	public boolean block(@PathVariable long blockNo, HttpSession session) {
		long memberNo = (long)session.getAttribute("memberNo");
		BlockDto blockDto = new BlockDto();
		blockDto.setMemberNo(memberNo);
		blockDto.setBlockNo(blockNo);
		
		BlockDto checkDto = blockRepo.selectOne(blockDto);
		if(checkDto==null) {
			blockRepo.insert(blockDto);
			return true;
		}
		else {
			blockRepo.delete(blockDto);
			return false;
		}
	}
}
