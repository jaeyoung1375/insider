package com.kh.insider.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@AllArgsConstructor@NoArgsConstructor@Builder
public class BoardAttachmentDto {

	public int boardAttachmentNo;
	public int boardNo;
	public int attachmentNo;
}
