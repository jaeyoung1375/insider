package com.kh.insider.service;

import java.util.Map;

import com.kh.insider.dto.JwtResponseDto;

public interface JwtService {
	
	String createRefreshToken(Long memberNo);
    String createAccessToken(String refreshToken);
    void checkValid(String jwt);
    Map<String, Object> getToken(String jwt);
    JwtResponseDto login(Long memberNo);
    Long findId(String token);
}
