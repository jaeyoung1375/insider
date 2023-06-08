package com.kh.insider.service;

import java.util.List;

import com.kh.insider.vo.NoticeVO;

public interface NoticeService {

	List<NoticeVO> selectNotice(Long memberNo);
	void check(Long memeberNo);
	int isInsider(Long memberNo);
	//dm 알림
	int isDm(Long memberNo);
}
