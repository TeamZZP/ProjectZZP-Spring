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
public class CartDTO {
	int cart_id;
	int p_id;
	String userid;
	int p_amount;
	String p_image;
	String p_name;
	int p_selling_price;
	String cart_created;
	int money; //수량 * 개별 가격
}
