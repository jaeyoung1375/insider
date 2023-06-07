package com.kh.insider.vo;

import java.util.List;

import com.kh.insider.dto.ReplyDto;

import lombok.Data;

@Data
public class ReportMemberDetailVO {
	List<BoardListVO> boardList;
	List<ReplyDto> replyList;
}
