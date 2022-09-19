package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.service.StoreService;

@Controller
public class StoreController {
	
	@Autowired
	StoreService service;
	
	@RequestMapping(value = "/store")
	public String storeMain() {
		//List<Product> BestProdudctlist = service.bestProduct();
		//List<String> categoryList = service.category();
		return"";
	}

}
