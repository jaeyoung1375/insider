package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class SearchDto {
	public int searchNo;
	public long memberNo;
	public String searchTagName;
	public Long searchMemberNo;
	public Date searchTime;
	public int searchDelete;
}
