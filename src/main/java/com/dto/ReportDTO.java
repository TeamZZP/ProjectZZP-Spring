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
public class ReportDTO {
	private int report_id;
	private String userid;
	private String report_category;
	private int chall_id;
	private int comment_id;
	private String report_reason;
	private String report_status;
	private String report_created;
	private String reported_userid;
	private String content;
	
}
