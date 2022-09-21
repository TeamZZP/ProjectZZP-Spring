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

	public List<CartDTO> cartList() {
		List<CartDTO> list = session.selectList("CartMapper.cartList");
		return list;
	}
	
	
	
}
