package com.kh.insider.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@NoArgsConstructor@AllArgsConstructor@Builder
public class BoardAttachVO {

	private int boardNo;
	private String boardContent;
	public int boardReplyValid;
	public int boardLikeValid;
	private String memberNo;
	private String memberNick;
	public int attachmentNo;
	public String attachmentName;
	public String attachmentType;
	public long attachmentSize;
}
