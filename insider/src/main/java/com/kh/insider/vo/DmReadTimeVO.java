package com.kh.insider.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class DmReadTimeVO {
	private long memberNo;
	private long readTime;
	private Date readDmTime;
}
