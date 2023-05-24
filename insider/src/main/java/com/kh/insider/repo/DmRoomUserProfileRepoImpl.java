package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.DmRoomUserProfileDto;

@Repository
public class DmRoomUserProfileRepoImpl implements DmRoomUserProfileRepo {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<DmRoomUserProfileDto> findRoomsById(long memberNo) {
        return sqlSession.selectList("dmRoomUserProfile.findRoomsById", memberNo);
    }
}
