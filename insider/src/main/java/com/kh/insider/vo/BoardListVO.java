package com.kh.insider.vo;

import java.util.List;

import com.kh.insider.dto.BoardAttachmentDto;
import com.kh.insider.dto.BoardWithNickDto;

import lombok.Data;

@Data
public class BoardListVO {
	private BoardWithNickDto boardWithNickDto;
	private List<BoardAttachmentDto> boardAttachmentList;
}
