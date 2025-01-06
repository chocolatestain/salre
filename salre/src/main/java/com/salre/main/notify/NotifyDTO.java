package com.salre.main.notify;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class NotifyDTO {
	private int user_id;
	private String notify_content;
	private Timestamp notify_time;
}