package com.kh.insider.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class FacebookProfileVO {
	
	private long id;
	private String gender;
	private String email;
	private String name;
	private String birthday;
}