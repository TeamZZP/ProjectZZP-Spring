package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dto.CategoryDTO;
import com.dto.ProductByCategoryDTO;
import com.service.StoreService;

@Controller
public class StoreController {
	
	@Autowired
	StoreService service;
	
	@RequestMapping(value = "/store")
	public ModelAndView storeMain() {
		ModelAndView mav = new ModelAndView();
		List<ProductByCategoryDTO> bestProdudctlist = service.bestProduct();
		List<CategoryDTO> categoryList = service.category();
		System.out.println(bestProdudctlist);
		mav.addObject("categoryList", categoryList);
		mav.addObject("Productlist", bestProdudctlist);
		mav.setViewName("storeMain");
		
		return mav;
	}
	
	//카테고리 변경시
	@RequestMapping(value = "/productByCategory")
	public ModelAndView productByCategory(@RequestParam("c_id") int c_id) {
		ModelAndView mav = new ModelAndView();
		System.out.println("c_id in Storecontroller/productByCategory()==="+c_id);
		List<ProductByCategoryDTO> prodByCateList = service.productByCategory(c_id);
		System.out.println(prodByCateList);
		mav.addObject("Productlist",prodByCateList);  //변경된 카테고리에 맞는 상품 List
		
		List<CategoryDTO> categoryList = service.category(); //카테고리 List 
		mav.addObject("categoryList", categoryList);
		
		mav.setViewName("storeMain");
		return mav;
	}
	

}
