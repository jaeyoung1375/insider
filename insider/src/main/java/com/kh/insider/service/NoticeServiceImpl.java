package com.kh.insider.service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kh.insider.vo.NoticeVO;

@Repository
public class NoticeServiceImpl implements NoticeService{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<NoticeVO> selectNotice(Long memberNo) {
		return sqlSession.selectList("notice.selectList",memberNo);
	}

	@Transactional
	@Override
	public void check(Long memberNo) {
		sqlSession.update("notice.checkBL", memberNo);
		sqlSession.update("notice.checkBR", memberNo);
		sqlSession.update("notice.checkBR2", memberNo);
		sqlSession.update("notice.checkRL", memberNo);
		sqlSession.update("notice.checkFollow", memberNo);
	}
	
//	private Map<Long, LocalDateTime> lastCheckedMap = new HashMap<>();
//	
//	@Override
//	public List<NoticeVO> selectNotice(Long memberNo) {
//		// Retrieve the last checked timestamp for the member
//		LocalDateTime lastCheckedTime = lastCheckedMap.get(memberNo);
//		
//		// If no previous check time exists, set it to the current time
//		if (lastCheckedTime == null) {
//			lastCheckedTime = LocalDateTime.now();
//			lastCheckedMap.put(memberNo, lastCheckedTime);
//		}
//		
//		// Retrieve the new updates since the last check time
//		List<NoticeVO> updates = sqlSession.selectList("notice.selectList", memberNo, lastCheckedTime);
//		
//		// Update the last checked timestamp for the member to the current time
//		lastCheckedMap.put(memberNo, LocalDateTime.now());
//		
//		return updates;
//	}

//	@Override
//	public List<NoticeVO> fetchUpdates(Long memberNo) {
//	    // Retrieve the last checked timestamp for the member
//	    LocalDateTime lastCheckedTime = lastCheckedMap.get(memberNo);
//
//	    // If no previous check time exists, set it to the current time
//	    if (lastCheckedTime == null) {
//	        lastCheckedTime = LocalDateTime.now();
//	        lastCheckedMap.put(memberNo, lastCheckedTime);
//	    }
//
//	    List<NoticeVO> updates = new ArrayList<>();
//
//	    List<NoticeVO> boardLikeUpdates = sqlSession.selectList("notice.checkBL", memberNo, lastCheckedTime);
//	    updates.addAll(boardLikeUpdates);
//
//	    List<NoticeVO> boardCommentUpdates = sqlSession.selectList("notice.checkBR", memberNo, lastCheckedTime);
//	    updates.addAll(boardCommentUpdates);
//
//	    List<NoticeVO> commentLikeUpdates = sqlSession.selectList("notice.checkRL", memberNo, lastCheckedTime);
//	    updates.addAll(commentLikeUpdates);
//
//	    List<NoticeVO> commentReplyUpdates = sqlSession.selectList("notice.checkBR2", memberNo, lastCheckedTime);
//	    updates.addAll(commentReplyUpdates);
//
//	    List<NoticeVO> followUpdates = sqlSession.selectList("notice.checkFollow", memberNo, lastCheckedTime);
//	    updates.addAll(followUpdates);
//
//	    lastCheckedMap.put(memberNo, LocalDateTime.now());
//
//	    return updates;
//	}
//
//	@Override
//	public void cleanup(Long memberNo) {
//
//		lastCheckedMap.remove(memberNo);
//	}



}
