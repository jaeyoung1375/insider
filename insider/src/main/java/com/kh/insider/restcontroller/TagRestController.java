package com.kh.insider.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.TagDto;
import com.kh.insider.repo.TagRepo;

@RestController
@RequestMapping("/rest/tag")
public class TagRestController {
	@Autowired
	private TagRepo tagRepo;
	
	@PutMapping("/")
	public int changeAvailable(@RequestBody TagDto tagDto) {
		TagDto oldTagDto = tagRepo.selectOne(tagDto.getTagName());
		int available = oldTagDto.getTagAvailable();
		int newAvailable=0;
		if(available==0) {
			newAvailable=1;
		}
		tagDto.setTagAvailable(newAvailable);
		return tagRepo.updateAvailable(tagDto);
	}
}
