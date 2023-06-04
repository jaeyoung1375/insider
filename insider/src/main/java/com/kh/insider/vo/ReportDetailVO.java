package com.kh.insider.vo;

import java.util.List;

import com.kh.insider.dto.ReplyDto;

import lombok.Data;

@Data
public class ReportDetailVO {
	private List<ReportDetailCountVO> reportDetailCountVO;
	private List<ReplyDto> replyList;
	private BoardListVO boardListVO;
	private ReportMemberDetailVO memberVO;
}
