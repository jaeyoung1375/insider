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
		sqlSession.insert("dmUser.enter", dmUserDto);
	}

	@Override
	public List<DmUserDto> find(String memberNo) {
		return sqlSession.selectList("dmUser.find", memberNo);
	}

	@Override
	public boolean check(DmUserDto dmUserDto) {
		DmUserDto findDto = sqlSession.selectOne("dmUser.check", dmUserDto);
		if(findDto == null) return false;
		else return true;
	}

	@Override
	public void invite(DmUserDto dmUserDto) {
		sqlSession.update("dmUser.invite", dmUserDto);
	}

//	@Override
//	public void exit(DmUserDto dmUserDto) {
//		int roomNo = dmUserDto.getRoomNo();
//		sqlSession.delete("dmUser.delete", roomNo);
//	}

}
