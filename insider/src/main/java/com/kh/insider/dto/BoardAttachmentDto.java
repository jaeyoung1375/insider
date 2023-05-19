package com.kh.insider.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@AllArgsConstructor@NoArgsConstructor@Builder
public class BoardAttachmentDto {

	private int boardAttachmentNo;
	private int boardNo;
	private int attachmentNo;
	
//	public String getImageURL() {
//		if(attachmentNo == 0) return "https://via.placeholder.com/150x150";
//		else return "/rest/attachment/download/"+attachmentNo;
//	}

}
