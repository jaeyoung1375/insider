package com.kh.insider.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.DmRoomRenameDto;

@Repository
public class DmRoomRenameRepoImpl implements DmRoomRenameRepo {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("dmRoomRename.sequence");
	}

	@Override
	public void RenameInsert(DmRoomRenameDto dmRoomRenameDto) {
		sqlSession.insert("dmRoomRename.RenameInsert", dmRoomRenameDto);
	}

}
