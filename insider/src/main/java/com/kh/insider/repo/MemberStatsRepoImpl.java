package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.vo.MemberStatsResponseVO;
import com.kh.insider.vo.MemberStatsSearchVO;

@Repository
public class MemberStatsRepoImpl implements MemberStatsRepo{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<MemberStatsResponseVO> selectList(MemberStatsSearchVO memberStatsSearchVO) {
		return sqlSession.selectList("member.memberStats", memberStatsSearchVO);
	}
	

}
