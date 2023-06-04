package com.kh.insider.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.ReportListDto;
import com.kh.insider.repo.MemberSuspensionRepo;
import com.kh.insider.repo.ReportListRepo;
import com.kh.insider.repo.ReportRepo;
import com.kh.insider.vo.UpdateReportContentVO;

@RestController
@RequestMapping("/rest/reportContent")
public class ReportContentRestController {

	@Autowired
	private ReportListRepo reportListRepo;
	@Autowired
	private ReportRepo reportRepo;
	@Autowired
	private MemberSuspensionRepo memberSuspensionRepo;
	
	@PostMapping("/")
	public void insert(@RequestBody ReportListDto reportListDto) {
		reportListRepo.insert(reportListDto);
	}
	@GetMapping("/")
	public List<ReportListDto> selectList(){
		return reportListRepo.selectList();
	}
	@DeleteMapping("/{reportListNo}")
	public void delete(@PathVariable int reportListNo) {
		reportListRepo.delete(reportListNo);
	}
	@PutMapping("/")
	public void update(@RequestBody UpdateReportContentVO updateReportContentVO) {
		memberSuspensionRepo.updateReportContent(updateReportContentVO);
		
		//reportListRepo.update(updateReportContentVO);
		//reportRepo.updateReportContent(updateReportContentVO);
	}
}
