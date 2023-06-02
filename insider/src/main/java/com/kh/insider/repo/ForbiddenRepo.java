package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.ForbiddenDto;

public interface ForbiddenRepo {
	List<String> selectList(String forbiddenWord);
	void insert(String forbiddenWord);
	void delete(String forbiddenWord);
	ForbiddenDto selectOne(ForbiddenDto forbiddenDto);
}