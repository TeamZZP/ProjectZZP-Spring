package com.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.CartDAO;
import com.dto.CartDTO;
import com.dto.MemberCouponDTO;
import com.dto.ProductByCategoryDTO;

@Service
public class CartService {
	@Autowired
	private CartDAO dao;

	public List<CartDTO> cartList(String userid) {
		List<CartDTO> list = dao.cartList(userid);
		return list;
	}

	public int cartCount(String userid) {
		int n = dao.cartCount(userid);
		return n;
	}

	public int sum_money(String userid) {
		int n = dao.sum_money(userid);
		return n;
	}

	public int checkCart(HashMap<String, Object> map) {
		int n = dao.checkCart(map);
		return n;
	}

	public void cartAdd(CartDTO cart) {
		dao.cartAdd(cart);
		
	}

	public void updateCart(CartDTO cart) {
		dao.updateCart(cart);  
	}

	public void cartDel(String cart_id) {
		dao.cartDel(cart_id);
		
	}

	public void cartUpdate(HashMap<String, Object> map) {
		dao.cartUpdate(map);
		
	}

	public void chkdel(ArrayList<String> list) {
		dao.chkdel(list);
	}

	public int likeCount(String userid) {
		int count = dao.likeCount(userid);
		return count;
	}

	public List<ProductByCategoryDTO> likeList(String userid) {
		List<ProductByCategoryDTO> list = dao.likeList(userid);
		return list;
	}

	public List<CartDTO> orderCart(ArrayList<String> list) {
		return dao.orderCart(list);
	}

	public List<MemberCouponDTO> selectAllCoupon1(String userid) {
		List<MemberCouponDTO> couponList = dao.selectAllCoupon1(userid);
		return couponList;
	}

	

}
