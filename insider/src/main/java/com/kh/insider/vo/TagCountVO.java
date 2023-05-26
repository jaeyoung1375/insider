package com.kh.insider.vo;

import lombok.Data;

@Data
public class TagCountVO {
	private String tagName;
	private int tagFollow;
	private int tagAvailable;
	private int count;
}
