package com.kh.insider.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.ReportDto;
import com.kh.insider.repo.ReportRepo;

@RequestMapping("/rest/report")
@RestController
public class ReportRestController {
	@Autowired
	private ReportRepo reportRepo;
	
	@PostMapping("/")
	public void insert(@RequestBody ReportDto reportDto) {
		reportRepo.insert(reportDto);
	}
}
