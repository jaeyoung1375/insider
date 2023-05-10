package com.kh.insider.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.MemberDto;

@Repository
public class MemberRepoImpl implements MemberRepo{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void join(MemberDto dto) {
		sqlSession.insert("member.join",dto);
	}

	@Override
	public MemberDto findByEmail(String memberEmail) {
		return sqlSession.selectOne("member.findByEmail",memberEmail);
	}
	
}
