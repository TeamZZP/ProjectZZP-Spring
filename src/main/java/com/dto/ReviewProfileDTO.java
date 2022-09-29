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
public class ReviewProfileDTO {

	String userid;
	String profile_img;
	String profile_txtT;
	int review_id; 
	int order_id; 
	int p_id; 
	String review_title; 
	String review_content;
	String review_rate;
	String review_img; 
	String review_created; 
	
}
