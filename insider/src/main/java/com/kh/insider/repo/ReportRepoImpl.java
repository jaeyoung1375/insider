package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.ReportDto;

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
	public ReportDto seletcOne(int reportNo) {
		return sqlSession.selectOne("report.selectOne", reportNo);
	}

	@Override
	public List<ReportDto> selectList() {
		return sqlSession.selectList("report.selectList");
	}
}