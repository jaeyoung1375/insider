package com.kh.insider.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@ConfigurationProperties(prefix = "google")
public class GoogleLoginProperties {
	private String client_id;
	private String client_secret;
	private String redirect_uri;
	private String grant_type;
}
