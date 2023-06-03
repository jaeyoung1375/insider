package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.TagDto;
import com.kh.insider.vo.AdminBoardSearchVO;
import com.kh.insider.vo.TagCountVO;

@Repository
public class TagRepoImpl implements TagRepo{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(String tagName) {
		sqlSession.insert("tag.insert", tagName);
	}

	@Override
	public void updateFollow(String tagName) {
		sqlSession.update("tag.updateFollow", tagName);
	}

	@Override
	public List<TagDto> selectList() {
		return sqlSession.selectList("tag.selectList");
	}

	@Override
	public TagDto selectOne(String tagName) {
		return sqlSession.selectOne("tag.selectOne", tagName);
	}

	@Override
	public List<TagCountVO> tagCountList(AdminBoardSearchVO vo) {
		return sqlSession.selectList("tag.tagCountList", vo);
	}

	@Override
	public int tagCountListCount(AdminBoardSearchVO vo) {
		return sqlSession.selectOne("tag.tagCountListCount", vo);
	}

	@Override
	public int updateAvailable(TagDto tagDto) {
		sqlSession.update("tag.updateAvailable", tagDto);
		return tagDto.getTagAvailable();
	}

}
