package com.kh.insider.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.MemberProfileDto;

@Repository
public class MemberProfileRepoImpl implements MemberProfileRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(MemberProfileDto memberProfileDto) {
		sqlSession.insert("memberProfile.insert", memberProfileDto);
	}

	@Override
	public void delete(long memberNo) {
		sqlSession.delete("memberProfile.delete", memberNo);
	}

	@Override
	public Integer selectAttachNo(long memberNo) {
		return sqlSession.selectOne("memberProfile.one", memberNo);
	}
}
