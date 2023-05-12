package com.kh.insider.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@JsonIgnoreProperties //항목이 없어도 이해 해주는 어노테이션
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class JsonMessageVO {
	
	private String content;
	private long time;
	
}
