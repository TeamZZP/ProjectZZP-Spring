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
public class ReviewProductImagesDTO {

	private String userid;
	private int p_id;
	private int order_id;
	private int review_id; 
	private String review_title; 
	private String review_content; 
	private String review_rate; 
	private String review_img; 
	private String review_create; 
	private String p_name;
	private String p_content;
	private int c_id;
	private int p_cost_price;
	private int p_selling_price;
	private int p_discount;
	private String p_created;
	private int p_stock;
	private int image_rnk;
	private String image_route;
	private String update_date;
	
	
}
