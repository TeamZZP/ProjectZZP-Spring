package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dto.CategoryDTO;
import com.service.StoreService;

@Controller
public class StoreController {
	
	@Autowired
	StoreService service;
	
	@RequestMapping(value = "/store")
	public ModelAndView storeMain() {
		ModelAndView mav = new ModelAndView();
		//List<Product> BestProdudctlist = service.bestProduct();
		List<CategoryDTO> categoryList = service.category();
		mav.addObject("categoryList", categoryList);
		mav.setViewName("storeMain");
		
		return mav;
	}

}
