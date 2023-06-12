package com.kh.insider.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.DmMemberInfoDto;

@Repository
public class DmMemberInfoRepoImpl implements DmMemberInfoRepo{
	
    @Autowired
    private SqlSession sqlSession;

    //특정 회원에 정보
	@Override
	public List<DmMemberInfoDto> dmMemberList(long memberNo) {
		return sqlSession.selectList("dmMemberInfo.dmMemberList", memberNo) ;
	}

	@Override
	public List<DmMemberInfoDto> findUsersByRoomNo(long memberNo, int roomNo) {
		Map<String, Object> params = new HashMap<>();
        params.put("memberNo", memberNo);
        params.put("roomNo", roomNo);
        return sqlSession.selectList("dmMemberInfo.findUsersByRoomNo", params);
	}

	//특정 회원이 특정 채팅방에서 읽지 않은 메세지 수(본인이 전송한 메세지는 제외)
	@Override
	public Integer getUnreadMessages(Long memberNo) {
		return sqlSession.selectOne("dmMemberInfo.getUnreadMessages", memberNo);
	}

}
