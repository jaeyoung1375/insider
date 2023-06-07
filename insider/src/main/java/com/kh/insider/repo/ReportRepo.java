package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.ReportDto;
import com.kh.insider.dto.ReportResultDto;
import com.kh.insider.vo.ReportDetailCountVO;
import com.kh.insider.vo.UpdateReportContentVO;

public interface ReportRepo {
	void insert(ReportDto reportDto);
	void update(ReportDto reportDto);
	ReportDto seletcOne(ReportDto reportDto);
	List<ReportDto> selectList();
	List<ReportDetailCountVO> selectDetailCount(ReportDto reportDto);
	void updateReportCheck(ReportResultDto reportResultDto);
	//삭제된 게시물의 신고 내역 삭제
	void deleteDeletedReport();
	//신고 목록 수정 시 기존 데이터 수정
	void updateReportContent(UpdateReportContentVO updateReportContentVO);
}
