package com.kh.insider.dto;

import lombok.Data;

@Data
public class SettingDto {
	private long memberNo;
	//0:완전공개, 1:추천노출x, 2:친구에게만 공개, 3:완전비공개
	private int settingHide;
	private int settingDistance;
	private int settingLikeAlert;
	private int settingReplyAlert;
	private int settingFollowAlert;
	private int settingVideoAuto;
	private int settingReplyLikeAlert;
	private int settingMessage;
	private int settingAllowReply;
	private int settingWatchLike;
	
	
//	설정 값에 따른 설정 여부 boolean 반환
	public boolean isLikeAlert() {
		return this.settingLikeAlert==1;
	}
	public boolean isReplyAlert() {
		return this.settingReplyAlert==1;
	}
	public boolean isFollowAlert() {
		return this.settingFollowAlert==1;
	}
	public boolean isVideoAuto() {
		return this.settingVideoAuto==1;
	}
	public boolean isWatchLike() {
		return this.settingWatchLike==1;
	}
}
