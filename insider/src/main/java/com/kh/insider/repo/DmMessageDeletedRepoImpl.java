package com.kh.insider.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.DmMessageDeletedDto;

@Repository
public class DmMessageDeletedRepoImpl implements DmMessageDeletedRepo {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertDeleteMessage(DmMessageDeletedDto dmMessageDeletedDto) {
		sqlSession.insert("dmMessageDeleted.insertDeleteMessage", dmMessageDeletedDto);
	}

}
