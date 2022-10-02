package com.dto;

import org.apache.ibatis.type.Alias;

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
@Alias("MemberCouponDTO")
public class MemberCouponDTO {
	
	
	String userid;
	int coupon_id;
	String coupon_get;
	String coupon_validity;
	String coupon_status;
	String coupon_used;

}
