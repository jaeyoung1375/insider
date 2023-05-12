package com.kh.insider.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@ConfigurationProperties(prefix = "kakao")
public class KakaoLoginProperties {
	private String clientId;
	private String grantType;
	private String redirectUri;
}
