package com.kh.insider.repo;

import com.kh.insider.dto.ReportDto;
import com.kh.insider.dto.ReportResultDto;

public interface ReportResultRepo {
	void insert(ReportDto reportDto);
	ReportResultDto selectOne(ReportDto reportDto);
	void updateResult(ReportResultDto reportResultDto);
}
