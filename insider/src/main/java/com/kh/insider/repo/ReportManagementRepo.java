package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.ReportManagementDto;

public interface ReportManagementRepo {
	List<ReportManagementDto> selectList();
}
