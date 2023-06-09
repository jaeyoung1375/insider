package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class CertDto {
	private String email;
	private String secret;
	private Date limit;
}
