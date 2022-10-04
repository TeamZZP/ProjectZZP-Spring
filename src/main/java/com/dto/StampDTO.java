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
public class StampDTO {
	private int stamp_id;
	private int chall_id;
	private String stamp_img;
	private String stamp_name;
	private String stamp_content;
	private String userid;
	private int stamp_num;
}
