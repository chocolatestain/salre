package com.salre.main.notification;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class NotificationDTO {
	private int user_id;
	private String notify_content;
	private Timestamp notify_time;
}