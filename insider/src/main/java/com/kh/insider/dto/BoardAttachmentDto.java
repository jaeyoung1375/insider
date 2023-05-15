package com.kh.insider.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@AllArgsConstructor@NoArgsConstructor@Builder
public class BoardAttachmentDto {

	
	public int boardNo;
	public String boardContent;
	public int boardLike;
	public int boardLat;
	public int boardLon;
	public Date boardTime;
	public int boardReply;
	public int boardReplyValid;
	public int boardLikeValid;
	public int boardReport;
	public int boardHide;
	public int boardKid;
	public String memberNick;
	public Integer attachmentNo;
	
	public String getImageURL() {
		if(attachmentNo == null) return "https://via.placeholder.com/150x150";
		else return "/download?attachmentNo="+attachmentNo;
	}
}
