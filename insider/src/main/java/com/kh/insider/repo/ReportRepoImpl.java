package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.ReportDto;
import com.kh.insider.dto.ReportResultDto;
import com.kh.insider.vo.ReportDetailCountVO;

@Repository
public class ReportRepoImpl implements ReportRepo {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ReportDto reportDto) {
		sqlSession.insert("report.insert",reportDto);
	}

	@Override
	public void update(ReportDto reportDto) {
		sqlSession.update("report.update",reportDto);
	}

	@Override
	public ReportDto seletcOne(ReportDto reportDto) {
		return sqlSession.selectOne("report.selectOne", reportDto);
	}

	@Override
	public List<ReportDto> selectList() {
		return sqlSession.selectList("report.selectList");
	}

	@Override
	public List<ReportDetailCountVO> selectDetailCount(ReportDto reportDto) {
		return sqlSession.selectList("report.selectDetailCount", reportDto);
	}

	@Override
	public void updateReportCheck(ReportResultDto reportResultDto) {
		sqlSession.update("report.updateReportCheck", reportResultDto);
	}
}