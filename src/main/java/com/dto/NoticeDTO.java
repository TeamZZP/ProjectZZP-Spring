package com.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter 
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class NoticeDTO {

	int notice_id; 
	String notice_tittle; 
	String notice_content;
	String notice_created; 
	String userid; 
	String notice_category; 
	int notice_hits; 
	
}
