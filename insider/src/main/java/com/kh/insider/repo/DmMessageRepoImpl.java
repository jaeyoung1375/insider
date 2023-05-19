package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.DmMessageDto;

@Repository
public class DmMessageRepoImpl implements DmMessageRepo {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public long sequence() {
		return sqlSession.selectOne("dmMessage.sequence");
	}

	@Override
	public long create(DmMessageDto dmMessageDto) {
		sqlSession.insert("dmMessage.create", dmMessageDto);
		return dmMessageDto.getMessageNo();
	}

	@Override
	public DmMessageDto detail(long messageNo) {
		return sqlSession.selectOne("dmMessage.detail", messageNo);
	}

	@Override
	public List<DmMessageDto> roomMessageList(int roomNo) {
		return sqlSession.selectList("dmMessage.roomMessageList", roomNo);
	}

	@Override
	public void delete(DmMessageDto dmMessageDto) {
		sqlSession.delete("dmMessage.delete", dmMessageDto);
	}
	
}
