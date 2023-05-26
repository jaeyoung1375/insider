package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.MemberWithProfileDto;
import com.kh.insider.dto.MemberWithSuspensionDto;
import com.kh.insider.vo.MemberWithProfileSearchVO;

@Repository
public class MemberWithProfileRepoImpl implements MemberWithProfileRepo{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public MemberWithProfileDto selectOne(long memberNo) {
		return sqlSession.selectOne("memberWithProfile.selectOne", memberNo);
	}

	@Override
	public List<MemberWithSuspensionDto> selectList(MemberWithProfileSearchVO memberWithProfileSearchVO) {
		return sqlSession.selectList("memberWithProfile.selectList", memberWithProfileSearchVO);
	}

	@Override
	public int selectCount(MemberWithProfileSearchVO memberWithProfileSearchVO) {
		return sqlSession.selectOne("memberWithProfile.selectListCount", memberWithProfileSearchVO);
	}

	@Override
	public MemberWithSuspensionDto suspensionSelectOne(long memberNo) {
		return sqlSession.selectOne("memberWithProfile.suspensionSelectOne", memberNo);
	}
}