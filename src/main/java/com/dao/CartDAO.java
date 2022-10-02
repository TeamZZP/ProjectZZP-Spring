package com.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.CartDTO;
import com.dto.ProductByCategoryDTO;

@Repository("CartDAO")
public class CartDAO {

	@Autowired
	private SqlSessionTemplate session;

	public List<CartDTO> cartList(String userid) {
		List<CartDTO> list = session.selectList("CartMapper.cartList",userid);
		return list;
	}

	public int cartCount(String userid) {
		int n = session.selectOne("CartMapper.cartCount",userid);
		return n;
	}

	public int sum_money(String userid) {
		int sum = session.selectOne("CartMapper.sum_money",userid);
		return sum;
	}

	public int checkCart(HashMap<String, Object> map) {
		int n = session.selectOne("CartMapper.checkCart",map);
		return n;
	}

	public void cartAdd(CartDTO cart) {
		int n = session.insert("CartMapper.cartAdd",cart);
		System.out.println("장바구니insert 갯수>>"+n);
	}

	public void updateCart(CartDTO cart) {
		int n = session.update("CartMapper.updateCart",cart);
		System.out.println("장바구니 수량 변경 >>"+n);
		
	}

	public void cartDel(String cart_id) {
		int n = session.delete("CartMapper.cartDel", cart_id);
		System.out.println("상품 삭제>>"+n);
		
	}

	public void cartUpdate(HashMap<String, Object> map) {
		int n = session.update("CartMapper.cartUpdate", map);
		System.out.println("상품 수량 update>> "+n);
		
	}

	public void cartAllDel(ArrayList<String> list) {
		session.delete("CartMapper.cartAllDel",list);
		System.out.println("장바구니 비우기성공");
	}

	public int likeCount(String userid) {
		int count = session.selectOne("CartMapper.likeCount", userid);
		return count;
	}

	public List<ProductByCategoryDTO> likeList(String userid) {
		List<ProductByCategoryDTO> list = session.selectList("CartMapper.likeList",userid);
		return list;
	}
	
	
	
}
