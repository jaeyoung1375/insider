package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.ReplyDto;

public interface ReplyRepo {
	void insert(ReplyDto replydto);
	List<ReplyDto> selectList(int replyOrigin);
	boolean delete(int replyNo);
	ReplyDto selectOne(int replyNo);
	void updateLikeCount(int count, int replyNo);
}
