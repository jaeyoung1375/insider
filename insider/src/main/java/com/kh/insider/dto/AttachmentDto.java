package com.kh.insider.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@AllArgsConstructor@NoArgsConstructor@Builder
public class AttachmentDto {

	private int attachmentNo;
	private String attachmentName;
	private String attachmentType;
	private long attachmentSize;
}
