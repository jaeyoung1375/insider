package com.kh.insider.dto;

import lombok.Data;

@Data
public class SettingDto {
	private String memberNo;
	private int settingHide;
	private int settingDistance;
	private int settingLikeAlert;
	private int settingReplyAlert;
	private int settingFollowAlert;
	private int settingVideoAuto;
}
