package com.kh.insider.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.DmMessageNickDto;
import com.kh.insider.vo.DmMessageNickVO;

@Repository
public class DmMessageNickRepoImpl implements DmMessageNickRepo {

	@Autowired
    private SqlSession sqlSession;

	@Override
	public List<DmMessageNickDto> getUndeletedMessages(long messageSender, int roomNo, long memberNo) {
		Map<String, Object> params = new HashMap<>();
        params.put("messageSender", messageSender);
        params.put("roomNo", roomNo);
        params.put("memberNo", memberNo);
        return sqlSession.selectList("getUndeletedMessages", params);
	}

	@Override
	public List<DmMessageNickVO> getMessagesWithLike(long messageSender, int roomNo, long memberNo) {
		Map<String, Object> params = new HashMap<>();
        params.put("messageSender", messageSender);
        params.put("roomNo", roomNo);
        params.put("memberNo", memberNo);
        return sqlSession.selectList("dmMessageNick.getMessagesWithLike", params);
	}
}
