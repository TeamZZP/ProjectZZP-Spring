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
public class OrderDTO {
	private int order_id;
	private String userid;
	private int p_id;
	private int total_price;
	private String delivery_address;
	private String delivery_req;
	private String order_date;
	private int order_quantity;
	
}
