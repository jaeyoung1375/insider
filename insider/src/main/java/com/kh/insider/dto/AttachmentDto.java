package com.kh.insider.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data@NoArgsConstructor @AllArgsConstructor @Builder
public class AttachmentDto {
	
	public int attachmentNo;
	public String attachmentName;
	public String attachmentType;
	public long attachmentSize;
}
