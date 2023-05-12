package com.kh.insider.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.DmMessageDto;
import com.kh.insider.repo.DmMessageRepo;

@RestController
@RequestMapping("/rest")
public class DmRestController {
	
	@Autowired
	private DmMessageRepo dmMessageRepo;
	
	@GetMapping("/message/{roomNo}")
	public List<DmMessageDto> roomMessage (
			@PathVariable int roomNo) {
		return dmMessageRepo.roomMessageList(roomNo);
	}

}
