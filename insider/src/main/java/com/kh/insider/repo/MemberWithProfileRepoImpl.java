package com.kh.insider.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.MemberWithProfileDto;

@Repository
public class MemberWithProfileRepoImpl implements MemberWithProfileRepo{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public MemberWithProfileDto selectOne(int memberNo) {
		return sqlSession.selectOne("memberWithProfile.selectOne", memberNo);
	}
}