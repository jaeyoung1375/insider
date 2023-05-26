package com.kh.insider.repo;

import com.kh.insider.dto.ReplyLikeDto;

public interface ReplyLikeRepo {
	void insert(ReplyLikeDto replyLikeDto);
	void delete(ReplyLikeDto replyLikeDto);
	boolean check(ReplyLikeDto replyLikeDto);
	int count(int replyNo);
}
