package com.kh.insider.repo;

import java.util.HashMap;
import java.util.Map;

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

	@Override
	public MemberDto login(String memberEmail, String memberPassword) {
		Map<String,String> param = new HashMap<>();
		param.put("memberEmail", memberEmail);
		param.put("memberPassword", memberPassword);
		
		return sqlSession.selectOne("member.login",param);
	}
	
}
