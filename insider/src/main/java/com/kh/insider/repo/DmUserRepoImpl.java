package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.DmUserDto;

@Repository
public class DmUserRepoImpl implements DmUserRepo {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void enter(DmUserDto dmUserDto) {
		dmUserDto.setReadTime(System.currentTimeMillis());
		sqlSession.insert("dmUser.enter", dmUserDto);
	}

	@Override
	public List<DmUserDto> find(long memberNo) {
		return sqlSession.selectList("dmUser.find", memberNo);
	}

	@Override
	public boolean check(DmUserDto dmUserDto) {
		DmUserDto findDto = sqlSession.selectOne("dmUser.check", dmUserDto);
		if(findDto == null) return false;
		else return true;
	}

	@Override
	public void updateReadTime(DmUserDto dmUserDto) {
		dmUserDto.setReadTime(System.currentTimeMillis());
		sqlSession.update("dmUser.updateReadTime", dmUserDto);
	}
	
	@Override
	public List<Long> selectReadTime(int roomNo) {
		return sqlSession.selectList("dmUser.selectReadTime", roomNo);
	}
	
	@Override
	public void leaveRoom(DmUserDto dmUserDto) {
		sqlSession.delete("dmUser.leaveRoom", dmUserDto);
	}
	
	@Override
	public List<DmUserDto> findMembersByRoom(int roomNo) {
		return sqlSession.selectList("dmUser.findMembersByRoom", roomNo);
	}
	

	///////////////////////////////////////////////////////
	
	@Override
	public List<DmUserDto> findUsersByRoomNo(int roomNo) {
		return sqlSession.selectList("dmUser.findUsersByRoomNo", roomNo);
	}



}
