package com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dto.CategoryDTO;
import com.dto.MemberDTO;
import com.dto.ProductByCategoryDTO;
import com.service.StoreService;

@Controller
public class StoreController {
	
	@Autowired
	StoreService service;
	
	@RequestMapping(value = "/store")
	public ModelAndView storeMain(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		HashMap<String, String> map = new HashMap<String, String>();
		List<Integer> zzimList = new ArrayList<Integer>();
		int zzim ;
		MemberDTO mdto = (MemberDTO) session.getAttribute("login");  //로그인세션
		List<ProductByCategoryDTO> bestProdudctlist = service.bestProduct();  //베스트상품리스트
		if(mdto !=null) {//로그인이 되었을 경우 찜 가져오기
			for (int i = 0; i < bestProdudctlist.size(); i++) {   //개별 상품번호로 찜 가져오기
				System.out.println(mdto.getUserid()+" , "+bestProdudctlist.get(i).getP_id());
				map.put("userid", mdto.getUserid());
				map.put("p_id", String.valueOf(bestProdudctlist.get(i).getP_id()));	
				zzimList.add(service.zzimCheck(map));
			}
		}
		System.out.println("zzimList: "+zzimList);
		List<CategoryDTO> categoryList = service.category(); //카테고리 리스트
		mav.addObject("categoryList", categoryList);
		mav.addObject("Productlist", bestProdudctlist);
		mav.addObject("mdto", mdto);
		mav.addObject("zzimList", zzimList);
		System.out.println("mdto:" + mdto);
		mav.setViewName("storeMain");
		
		return mav;
	}
	
	//카테고리 변경시
	@RequestMapping(value = "/productByCategory")
	public ModelAndView productByCategory(HttpSession session ,@RequestParam("c_id") int c_id) {
		HashMap<String, String> map = new HashMap<String, String>();
		List<Integer> zzimList = new ArrayList<Integer>();
		ModelAndView mav = new ModelAndView();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login");  //로그인세션
		List<ProductByCategoryDTO> prodByCateList = service.productByCategory(c_id);  //해당카테고리상품리스트
		System.out.println(prodByCateList);
		if(mdto !=null) {//로그인이 되었을 경우 찜 가져오기
			for (int i = 0; i < prodByCateList.size(); i++) {   //개별 상품번호로 찜 가져오기
				System.out.println(mdto.getUserid()+" , "+prodByCateList.get(i).getP_id());
				map.put("userid", mdto.getUserid());
				map.put("p_id", String.valueOf(prodByCateList.get(i).getP_id()));	
				zzimList.add(service.zzimCheck(map));
			}
		}
		mav.addObject("Productlist",prodByCateList);  
		List<CategoryDTO> categoryList = service.category(); //카테고리 List 
		mav.addObject("categoryList", categoryList);
		mav.addObject("zzimList", zzimList);
		mav.setViewName("storeMain");
		return mav;
	}
	
	@RequestMapping(value = "/productRetrieve")
	public ModelAndView productRetrieve(HttpSession session ,@RequestParam("p_id") int p_id) {
		ModelAndView mav = new ModelAndView();
		HashMap<String, String> map = new HashMap<String, String>();
		int zzim =0;
		MemberDTO mdto = (MemberDTO) session.getAttribute("login");  //로그인세션
		ProductByCategoryDTO pdto= service.productRetrieve(p_id);  //선택상품상세
		if(mdto!=null) {
			map.put("userid", mdto.getUserid());
			map.put("p_id", String.valueOf(pdto.getP_id()));
			zzim = service.zzimCheck(map);
		}
		List<CategoryDTO> categoryList = service.category(); //카테고리 List 
		mav.addObject("categoryList", categoryList);
		mav.addObject("pdto",pdto);
		mav.addObject("mdto", mdto);
		mav.addObject("zzim", zzim);
		mav.setViewName("productRetrieve");
		
		return mav;
	}
	
	
	

}
