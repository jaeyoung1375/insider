package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.ReportManagementDto;
import com.kh.insider.vo.ReportSearchVO;

public interface ReportManagementRepo {
	List<ReportManagementDto> selectList(ReportSearchVO reportSearchVO);
	int selectCount(ReportSearchVO reportSearchVO);
}
