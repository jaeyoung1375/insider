package com.kh.insider.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.DmInvitationDto;

@Repository
public class DmInvitationRepoImpl implements DmInvitationRepo{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void createInvitation(DmInvitationDto dmInvitationDto) {
		sqlSession.insert("dmInvitation.createInvitation", dmInvitationDto);
	}

	
}
