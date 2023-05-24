package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.TagDto;

@Repository
public class TagRepoImpl implements TagRepo{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(String tagName) {
		sqlSession.insert("tag.insert", tagName);
	}

	@Override
	public void updateFollow(TagDto tagDto) {
		sqlSession.update("tag.updateFollow", tagDto);
	}

	@Override
	public List<TagDto> selectList() {
		return sqlSession.selectList("tag.selectList");
	}

	@Override
	public TagDto selectOne(String tagName) {
		return sqlSession.selectOne("tag.selectOne", tagName);
	}

}
