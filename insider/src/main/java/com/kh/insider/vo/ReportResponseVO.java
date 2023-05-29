package com.kh.insider.vo;

import java.util.List;

import com.kh.insider.dto.ReportManagementDto;

import lombok.Data;

@Data
public class ReportResponseVO {
	List<ReportManagementDto> reportList;
	private PaginationVO paginationVO;
}
