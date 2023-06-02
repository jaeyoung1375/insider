package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.ReportDto;
import com.kh.insider.dto.ReportResultDto;
import com.kh.insider.vo.ReportDetailCountVO;

public interface ReportRepo {
	void insert(ReportDto reportDto);
	void update(ReportDto reportDto);
	ReportDto seletcOne(ReportDto reportDto);
	List<ReportDto> selectList();
	List<ReportDetailCountVO> selectDetailCount(ReportDto reportDto);
	void updateReportCheck(ReportResultDto reportResultDto);
}
