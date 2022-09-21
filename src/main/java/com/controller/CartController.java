package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dto.CartDTO;
import com.service.CartService;

@Controller
public class CartController {
	
	@Autowired
	CartService service;
	
	/**
	 * 장바구니 리스트화면
	 */
	@RequestMapping(value = "/cart/{userid}", method = RequestMethod.GET)
		
	public String cartList(@PathVariable("userid") String userid, Model m) {
		//장바구니 List
		List<CartDTO> cartList = service.cartList(userid); 
		//장바구니에 담긴 갯수
		int cartCount = service.cartCount(userid);
		//찜에 담긴 갯수
		
		System.out.println();

		m.addAttribute("cartList", cartList);
		m.addAttribute("cartCount", cartCount);
		return "cartList";
	}
}
