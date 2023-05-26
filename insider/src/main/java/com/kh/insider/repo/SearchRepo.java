package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.SearchComplexDto;

public interface SearchRepo {
	List<SearchComplexDto> selectList(String searchInput);
}
