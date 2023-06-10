package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.ReplyDto;
import com.kh.insider.vo.UpdateReportContentVO;

public interface ReplyRepo {
	void insert(ReplyDto replydto);
	List<ReplyDto> selectList(int replyOrigin);
	//차단 댓글 막는용
	List<ReplyDto> selectList(int replyOrigin, long memberNo);
	boolean delete(int replyNo);
	ReplyDto selectOne(int replyNo);
	void updateLikeCount(int count, int replyNo);
	//신고 개수 추가
	void addReport(int replyNo);
	//신고 개수 있는 리스트 반환
	List<ReplyDto> selectListReported(long memberNo);
}
