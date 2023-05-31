package com.kh.insider.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@AllArgsConstructor@NoArgsConstructor@Builder
public class JwtResponseDto {

	private String accToken;
	private String refToken;
	private Long memberNo;
}
