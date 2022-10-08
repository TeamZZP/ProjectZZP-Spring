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
import com.dto.ProductOrderImagesDTO;

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
		return n;
	}

	public int cartDelete(HashMap<String,String> map) {
		int n = dao.cartDelete(map);
		return n;
	}

	public int selectCart(HashMap<String, String> map) {
		int count = dao.selectCart(map);
		return count;
	}

	public int deleteCoupon(HashMap<String, String> couponMap) {
		int n = dao.deleteCoupon(couponMap);
		return n;
	}

	public List<OrderDTO> getOrderInfo(int order_id) {
		List<OrderDTO> orderList= dao.getOrderInfo(order_id);
		return orderList;
	}

	public int selectSameCouponCount(HashMap<String, String> couponMap) {
		int n = dao.selectSameCouponCount(couponMap);
		return n;
	}

	public int deleteOneCoupon(HashMap<String, String> couponMap) {
		int n = dao.deleteOneCoupon(couponMap);
		return n;
	}

	public List<ProductOrderImagesDTO> selectOrderProd(int order_id) {
		List<ProductOrderImagesDTO> prodList = dao.selectOrderProd(order_id);
		return prodList;
	}

}
