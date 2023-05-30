package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.SearchComplexDto;
import com.kh.insider.dto.SearchDto;
import com.kh.insider.dto.SearchWithProfileDto;

public interface SearchRepo {
	//검색 추천 리스트 출력
	List<SearchComplexDto> selectRecommandList(String searchInput);
	//검색했던 리스트 출력
	List<SearchWithProfileDto> selectSearchedList(long memberNo);
	//검색 기록 추가
	void insert(SearchDto searchDto);
	//검색 기록 삭제
	void delete(SearchDto searchDto);
	//단일조회
	SearchDto selectOne(SearchDto searchDto);
	//검색 기록 시간 갱신
	void updateTime(SearchDto searchDto);
}
