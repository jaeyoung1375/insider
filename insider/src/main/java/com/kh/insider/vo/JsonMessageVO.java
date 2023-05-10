package com.kh.insider.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@JsonIgnoreProperties
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class JsonMessageVO {

	private String content;
	private long time;
	
}
