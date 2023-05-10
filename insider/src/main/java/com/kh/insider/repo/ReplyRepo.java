package com.kh.insider.repo;

import com.kh.insider.dto.ReplyDto;

public interface ReplyRepo {
	void insert(ReplyDto replydto);
	boolean delete(int replyNo);
}
