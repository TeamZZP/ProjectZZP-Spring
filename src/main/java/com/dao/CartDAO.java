package com.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.CartDTO;

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
	
	
	
}
