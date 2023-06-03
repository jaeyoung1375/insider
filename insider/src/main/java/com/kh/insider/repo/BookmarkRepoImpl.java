package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.BookmarkDto;

@Repository
public class BookmarkRepoImpl implements BookmarkRepo {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(BookmarkDto dto) {
		sqlSession.insert("bookmark.insert",dto);
	}

	@Override
	public List<BookmarkDto> selectList() {
		
		return sqlSession.selectList("bookmark.selectList");
	}

	@Override
	public List<BookmarkDto> findByNo(long memberNo) {
		
		return sqlSession.selectOne("bookmark.findByNo",memberNo);
	}

	@Override
	public void delete(BookmarkDto dto) {
		sqlSession.delete("bookmark.delete",dto);
	}

	@Override
	public BookmarkDto selectOne(BookmarkDto dto) {
		
		return sqlSession.selectOne("bookmark.selectOne",dto);
	}

}
