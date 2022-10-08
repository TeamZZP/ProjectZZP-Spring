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
public class CouponMemberCouponDTO {
	
	String userid;
	int coupon_id;
	String coupon_get;
	String coupon_status;
	String coupon_used;
	String coupon_img;
	int coupon_discount;
	String coupon_created;
	String coupon_validity;
	String coupon_name;
	int coupon_give_id;
	
}
