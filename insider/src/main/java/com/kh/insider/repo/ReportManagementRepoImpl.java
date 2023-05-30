package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.ReportManagementDto;
import com.kh.insider.vo.ReportSearchVO;

@Repository
public class ReportManagementRepoImpl implements ReportManagementRepo{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ReportManagementDto> selectList(ReportSearchVO reportSearchVO) {
		return sqlSession.selectList("reportManagement.selectList", reportSearchVO);
	}

	@Override
	public int selectCount(ReportSearchVO reportSearchVO) {
		return sqlSession.selectOne("reportManagement.selectCount", reportSearchVO);
	}

}
