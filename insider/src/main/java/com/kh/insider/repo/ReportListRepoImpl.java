package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.ReportListDto;

@Repository
public class ReportListRepoImpl implements ReportListRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ReportListDto reportListDto) {
		sqlSession.insert("reportList.insert", reportListDto);
	}

	@Override
	public void update(ReportListDto reportListDto) {
		sqlSession.update("reportList.update", reportListDto);
	}

	@Override
	public List<ReportListDto> selectList() {
		return sqlSession.selectList("reportList.selectList");
	}

	@Override
	public void delete(int reportListNo) {
		sqlSession.delete("reportList.delete", reportListNo);
	}

}
