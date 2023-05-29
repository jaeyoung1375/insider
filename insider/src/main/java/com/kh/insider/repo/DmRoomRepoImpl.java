package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.DmRoomDto;

@Repository
public class DmRoomRepoImpl implements DmRoomRepo {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("dmRoom.sequence");
	}

	@Override
	public void create(DmRoomDto dmRoomDto) {
		sqlSession.insert("dmRoom.create", dmRoomDto);
	}

	@Override
	public DmRoomDto find(int roomNo) {
		return sqlSession.selectOne("dmRoom.find", roomNo);
	}

	@Override
	public List<DmRoomDto> list() {
		return sqlSession.selectList("dmRoom.list");
	}
	
	@Override
	public void deleteRoom(DmRoomDto dmRoomDto) {
		sqlSession.delete("dmRoom.deleteRoom", dmRoomDto);
	}
	
    @Override
    public void changeRoomInfo(DmRoomDto dmRoomDto) {
        sqlSession.update("dmRoom.changeRoomInfo", dmRoomDto);
    }

	@Override
    public void updateRoomName(DmRoomDto dmRoomDto) {
        sqlSession.update("dmRoom.updateRoomName", dmRoomDto);
    }

	
}
