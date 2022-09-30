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
public class CouponDTO {
	
	int coupon_id; 
	String coupon_img; 
	String coupon_name; 
	int coupon_discount;
	
}
