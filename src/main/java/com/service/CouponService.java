package com.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.CouponDAO;
import com.dto.CouponDTO;
import com.dto.PageDTO;

@Service
public class CouponService {

	@Autowired
	CouponDAO dao;

	public PageDTO myCoupon(Map<String, String> map) {
		PageDTO dto = dao.myCoupon(map);
		return dto;
	}

	public PageDTO couponSelect(Map<String, String> map) {
		PageDTO dto = dao.couponSelect(map);
		return dto;
	}

	public void couponInsert(CouponDTO dto) {
		dao.couponInsert(dto);
	}

	public CouponDTO couponOneSelect(String coupon_id) {
		CouponDTO dto = dao.couponOneSelect(coupon_id);
		return dto;
	}

	public void couponUpdate(CouponDTO dto) {
		dao.couponUpdate(dto);
	}

	public void couponDelete(String coupon_id) {
		dao.couponDelete(coupon_id);
	}

	public void couponAllDel(List<String> delCoupon) {
		dao.couponAllDel(delCoupon);
	}
	
}
