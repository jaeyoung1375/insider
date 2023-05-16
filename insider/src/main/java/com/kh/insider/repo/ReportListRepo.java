package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.ReportListDto;

public interface ReportListRepo {
	void insert(ReportListDto reportListDto);
	void update(ReportListDto reportListDto);
	List<ReportListDto> selectList();
	void delete(int reportListNo);
}
