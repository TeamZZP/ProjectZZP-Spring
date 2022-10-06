package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.OrderDAO;
import com.dto.MemberCouponDTO;
import com.dto.OrderDTO;
import com.dto.PageDTO;

@Service
public class OrderService {

	@Autowired
	OrderDAO dao;

	public PageDTO myOrder(Map<String, String> map) {
		PageDTO dto = dao.myOrder(map);
		return dto;
	}

	public List<MemberCouponDTO> selectAllCoupon(String userid) {
		List<MemberCouponDTO> couponList = dao.selectAllCoupon(userid);
		return couponList;
	}

	public int getOrderId() {
		int n = dao.getOrderId();
		return n;
	}

	public int addOrder(OrderDTO orderDTO) {
		int n = dao.addOrder(orderDTO);
		System.out.println("orderService: addOrder 실행()=====");
		return n;
	}

	public int cartDelete(HashMap<String,String> map) {
		int n = dao.cartDelete(map);
		return n;
	}

}
