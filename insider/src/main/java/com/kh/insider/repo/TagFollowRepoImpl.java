package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.TagFollowDto;

@Repository
public class TagFollowRepoImpl implements TagFollowRepo{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(TagFollowDto tagFollowDto) {
		sqlSession.insert("tagFollow.insert", tagFollowDto);
	}

	@Override
	public List<TagFollowDto> selectList(long memberNo) {
		return sqlSession.selectList("tagFollow.selectList", memberNo);
	}

	@Override
	public int countFromMember(long memberNo) {
		return sqlSession.selectOne("tagFollow.countFromMember", memberNo);
	}

	@Override
	public int countFromTag(String tagName) {
		return sqlSession.selectOne("tagFollow.countFromTag", tagName);
	}

	@Override
	public void delete(TagFollowDto tagFollowDto) {
		sqlSession.delete("tagFollow.delete", tagFollowDto);
	}

}
