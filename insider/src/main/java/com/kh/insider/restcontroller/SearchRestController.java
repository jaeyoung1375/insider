package com.kh.insider.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.SearchComplexDto;
import com.kh.insider.repo.SearchRepo;

@RestController
@RequestMapping("/rest/search")
public class SearchRestController {
	
	@Autowired
	private SearchRepo searchRepo;
	
	@GetMapping("/{searchInput}")
	public List<SearchComplexDto> recommandSearch(@PathVariable String searchInput){
		return searchRepo.selectList(searchInput);
	}
}
