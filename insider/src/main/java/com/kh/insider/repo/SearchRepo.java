package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.SearchDto;

public interface SearchRepo {
	List<SearchDto> selectList(String searchInput);
}
