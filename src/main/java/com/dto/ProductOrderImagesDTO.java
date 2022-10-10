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
public class ProductOrderImagesDTO {

	private int order_id;
	private String userid;
	private int p_id;
	private int sum_money;
	private int fee;
	private int total_price;
	private int discounted;
	private String delivery_address;
	private String delivery_req;
	private String order_date;
	private int order_quantity;
	private String order_state;
	private int p_amount;
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
