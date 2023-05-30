package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.SearchComplexDto;
import com.kh.insider.dto.SearchDto;
import com.kh.insider.dto.SearchWithProfileDto;
import com.kh.insider.vo.SearchStatsSearchVO;
import com.kh.insider.vo.SearchStatsVO;

@Repository
public class SearchRepoImpl implements SearchRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<SearchComplexDto> selectRecommandList(String searchInput) {
		return sqlSession.selectList("search.selectRecommand", searchInput);
	}

	@Override
	public List<SearchWithProfileDto> selectSearchedList(long memberNo) {
		return sqlSession.selectList("search.selectSearched", memberNo);
	}

	@Override
	public void insert(SearchDto searchDto) {
		sqlSession.insert("search.insert", searchDto);
	}

	@Override
	public void delete(SearchDto searchDto) {
		sqlSession.update("search.searchDelete", searchDto);
	}

	@Override
	public SearchDto selectOne(SearchDto searchDto) {
		return sqlSession.selectOne("search.selectOne", searchDto);
	}

	@Override
	public void updateTime(SearchDto searchDto) {
		sqlSession.update("search.updateTime", searchDto);
	}

	@Override
	public List<SearchStatsVO> selectStatsList(SearchStatsSearchVO searchStatsSearchVO) {
		return sqlSession.selectList("search.selectStatsList", searchStatsSearchVO);
	}

}
