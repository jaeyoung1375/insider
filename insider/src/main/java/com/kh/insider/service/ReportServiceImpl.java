package com.kh.insider.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.insider.dto.ReportDto;
import com.kh.insider.dto.ReportResultDto;
import com.kh.insider.repo.ReportRepo;
import com.kh.insider.repo.ReportResultRepo;

@Service
public class ReportServiceImpl implements ReportService{
	@Autowired
	private ReportRepo reportRepo;
	@Autowired
	private ReportResultRepo reportResultRepo;

	@Override
	public void manageDeleted(String table, int tableNo) {
		ReportDto reportDto = new ReportDto();
		reportDto.setReportTable(table);
		reportDto.setReportTableNo(tableNo);
		ReportResultDto reportResultDto = reportResultRepo.selectOne(reportDto);
		if(reportResultDto!=null) {
			reportResultDto.setReportResult(2);
			reportRepo.updateReportCheck(reportResultDto);
			reportRepo.deleteDeletedReport();
			reportResultRepo.updateResult(reportResultDto);
		}		
	}

	@Override
	public void manageDeleted(String table, long tableNo) {
		ReportDto reportDto = new ReportDto();
		reportDto.setReportTable(table);
		reportDto.setReportTableNo(tableNo);
		ReportResultDto reportResultDto = reportResultRepo.selectOne(reportDto);
		if(reportResultDto!=null) {
			reportResultDto.setReportResult(2);
			reportRepo.updateReportCheck(reportResultDto);
			reportRepo.deleteDeletedReport();
			reportResultRepo.updateResult(reportResultDto);
		}			
	}

}
