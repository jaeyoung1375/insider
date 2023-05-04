package com.kh.insider.configuration;

import java.io.File;

import javax.annotation.PostConstruct;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Component
@ConfigurationProperties(prefix = "custom.fileupload")
public class FileUploadProperties {
	
	@Setter
	private String path;
	
	@Getter
	private File dir;
	
	@PostConstruct
	public void init() {
		dir = new File(path);
		dir.mkdirs();
	}

}
