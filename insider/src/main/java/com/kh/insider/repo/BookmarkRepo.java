package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.BookmarkDto;

public interface BookmarkRepo {
	
	public void insert(BookmarkDto dto);
	public List<BookmarkDto> selectList();
	public BookmarkDto selectOne(BookmarkDto dto);
	public List<BookmarkDto> findByNo(long memberNo);
	public void delete(BookmarkDto dto);
	

}
