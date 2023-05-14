package com.kh.insider.vo;

import java.util.List;

import com.kh.insider.dto.BoardAttachmentDto;
import com.kh.insider.dto.BoardDto;

import lombok.Data;

@Data
public class BoardListVO {
	private BoardDto boardDto;
	private List<BoardAttachmentDto> boardAttachmentList;
}
