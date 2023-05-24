package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class DmRoomUserProfileDto {

    private int roomNo;
    private String roomName;
    private Date roomCreated;
    private int roomType;
    private long memberNo;
    private Date joinTime;
    private int attachmentNo;
    
}
