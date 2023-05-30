package com.kh.insider.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class DmPrivacyRoomDto {

	  private long inviterNo;
	  private long inviteeNo;
	  private int roomNo;
	  
}
