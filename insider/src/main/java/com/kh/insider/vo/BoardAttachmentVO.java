package com.kh.insider.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@AllArgsConstructor@NoArgsConstructor@Builder
public class BoardAttachmentVO {
	
		private int boardNo;
		private int attachmentNo;
		public String attachmentName;
		public String attachmentType;
		public long attachmentSize;
		
//		public String getImageURL() {
//			if(attachmentNo == 0) return "https://via.placeholder.com/150x150";
//			else return "/download?attachmentNo="+attachmentNo;
//		}
}
