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
public class ProductOrderReviewDTO {

	int order_id; 
	String userid;
	int p_id; 
	int total_price; 
	String delivery_address;
	String delivery_loc;
	String delivery_req; 
	String order_date; 
	String order_state; 
	int p_amount; 
	String p_name; 
	String p_content;
	int c_id; 
	int p_cost_price; 
	int p_selling_price; 
	int p_discount; 
	String p_created;
	int p_stock; 
	int review_id; 
	String review_title; 
	String review_content; 
	String review_rate; 
	String review_img; 
	String review_create; 
	
}
