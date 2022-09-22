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
public class CommentsDTO {
	private int comment_id;
	private int chall_id;
	private String comment_content;
	private String comment_created;
	private String userid;
	private int parent_id;
	private int group_order;
	private int step;
	private String profile_img;
}
