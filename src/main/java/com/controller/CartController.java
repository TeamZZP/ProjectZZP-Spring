package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	public String cartList(@PathVariable("userid") String userid) {
		List<CartDTO> list = service.cartList(); 
		return "cart";
	}
}
