package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.DmPrivacyRoomDto;

@Repository
public class DmPrivacyRoomRepoImpl implements DmPrivacyRoomRepo{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void createPrivacy(DmPrivacyRoomDto dmPrivacyRoomDto) {
		sqlSession.insert("dmPrivacyRoom.createPrivacy", dmPrivacyRoomDto);
	}
	
	@Override
	public boolean checkDuplication(DmPrivacyRoomDto dmPrivacyRoomDto) {
		DmPrivacyRoomDto findPrivacyDto = sqlSession.selectOne("dmPrivacyRoom.checkDuplication", dmPrivacyRoomDto);
		if( findPrivacyDto == null) return false;
		else return true;
	}

	/// 삭제 예정
	@Override
	public List<DmPrivacyRoomDto> inviteeList(long inviteeNo) {
		return sqlSession.selectList("dmPrivacyRoom.inviteeList", inviteeNo);
	}

////////////////////////삭제 예정 /////////////////
	@Override
	public DmPrivacyRoomDto selectOneRoom(DmPrivacyRoomDto dmPrivacyRoomDto) {
		return sqlSession.selectOne("dmPrivacyRoom.selectOneRoom", dmPrivacyRoomDto);
	}
	
}