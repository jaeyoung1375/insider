package com.kh.insider.restcontroller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/rest/search")
public class SearchRestController {
	
	@GetMapping("/{searchInput}")
	public void recommandSearch(@PathVariable String searchInput){
		
	}
}
