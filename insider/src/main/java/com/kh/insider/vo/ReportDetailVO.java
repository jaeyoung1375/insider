package com.kh.insider.vo;

import java.util.List;

import lombok.Data;

@Data
public class ReportDetailVO {
	private List<ReportDetailCountVO> reportDetailCountVO;
	private BoardListVO boardListVO;
}
