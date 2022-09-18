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
public class ChallengeDTO {
	private int chall_id;
	private String userid;
	private String chall_title;
	private String chall_content;
	private String chall_category;
	private int chall_hits;
	private int chall_liked;
	private String chall_created;
	private String chall_img;
	private int chall_comments;
	private int chall_this_month;
}
