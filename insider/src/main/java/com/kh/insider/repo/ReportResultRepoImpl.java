package com.kh.insider.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.ReportDto;
import com.kh.insider.dto.ReportResultDto;

@Repository
public class ReportResultRepoImpl implements ReportResultRepo {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ReportDto reportDto) {
		sqlSession.insert("reportResult.insert", reportDto);
	}

	@Override
	public ReportResultDto selectOne(ReportDto reportDto) {
		return sqlSession.selectOne("reportResult.selectOne", reportDto);
	}

	@Override
	public void updateResult(ReportResultDto reportResultDto) {
		sqlSession.update("reportResult.updateResult", reportResultDto);
	}

}
