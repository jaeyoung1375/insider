package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.ReportDto;

public interface ReportRepo {
	void insert(ReportDto reportDto);
	void update(ReportDto reportDto);
	ReportDto seletcOne(int reportNo);
	List<ReportDto> selectList();
}
