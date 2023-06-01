package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.ForbiddenDto;

@Repository
public class ForbiddenRepoImpl implements ForbiddenRepo{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<String> selectList(String forbiddenWord) {
		return sqlSession.selectList("forbidden.selectList", forbiddenWord);
	}

	@Override
	public void insert(String forbiddenWord) {
		sqlSession.insert("forbidden.insert", forbiddenWord);
	}

	@Override
	public void delete(String forbiddenWord) {
		sqlSession.delete("forbidden.delete", forbiddenWord);
	}

	@Override
	public ForbiddenDto selectOne(ForbiddenDto forbiddenDto) {
		return sqlSession.selectOne("forbidden.selectOne", forbiddenDto);
	}

}
