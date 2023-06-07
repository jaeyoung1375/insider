package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.ReportListDto;
import com.kh.insider.vo.UpdateReportContentVO;

public interface ReportListRepo {
	void insert(ReportListDto reportListDto);
	void update(UpdateReportContentVO updateReportContentVO);
	List<ReportListDto> selectList();
	void delete(int reportListNo);
}
