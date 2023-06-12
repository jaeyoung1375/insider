package com.kh.insider.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	@Override
	public int countUsersInRoom(int roomNo) {
		return sqlSession.selectOne("dmUser.countUsersInRoom", roomNo);
	}

	@Override
	public List<DmUserDto> getUnreadMessageNum(long memberNo, int roomNo) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("memberNo", memberNo);
	    params.put("roomNo", roomNo);
	    return sqlSession.selectList("dmUser.getUnreadMessageNum", params);
	}
	
	@Override
	public void updateUnReadDm(DmUserDto dmUserDto) {
		sqlSession.update("dmUser.updateUnReadDm", dmUserDto);
	}

	@Override
	public List<Integer> getEnteredRoomNo(long memberNo) {
		return sqlSession.selectList("dmUser.getEnteredRoomNo", memberNo);
	}

	
}
