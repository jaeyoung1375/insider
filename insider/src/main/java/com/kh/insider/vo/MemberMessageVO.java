package com.kh.insider.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@JsonIgnoreProperties
@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MemberMessageVO {
	
	private int memberNo;
	private String memberName, content;
	private long time;

}
