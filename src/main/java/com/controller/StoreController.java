package com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dto.CategoryDTO;
import com.dto.ImagesDTO;
import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.dto.ProductDTO;
import com.dto.QuestionDTO;
import com.dto.ReviewProfileDTO;
import com.service.QuestionService;
import com.service.ReviewService;
import com.service.StoreService;

@Controller
public class StoreController {
	
	@Autowired
	StoreService service;
	@Autowired
	QuestionService qService;
	@Autowired
	ReviewService rService;
	
	//스토어메인
	@RequestMapping(value = "/store")
	public ModelAndView storeMain(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<Integer> zzimList = new ArrayList<Integer>();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login");  //로그인세션
		PageDTO pDTO = new PageDTO();
		
		pDTO = service.bestProduct();  //베스트상품리스트
		if(mdto !=null) {//로그인이 되었을 경우 찜 가져오기
			zzimList=service.zzimAllCheck(mdto.getUserid());
		}
		System.out.println("zzimList: "+zzimList);
		List<CategoryDTO> categoryList = service.category(); //카테고리 리스트
		mav.addObject("c_id","");  
		mav.addObject("categoryList", categoryList);
		mav.addObject("pDTO", pDTO);
		mav.addObject("mdto", mdto);
		mav.addObject("zzimList", zzimList);
		System.out.println("mdto:" + mdto);
		mav.setViewName("storeMain");
		
		return mav;
	}
	
	//카테고리 변경시
	@RequestMapping(value = "/store/{c_id}")
	public ModelAndView productByCategory(HttpSession session ,@PathVariable("c_id") int c_id) {
		List<Integer> zzimList = new ArrayList<Integer>();
		ModelAndView mav = new ModelAndView();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login");  //로그인세션
		PageDTO pDTO = new PageDTO();
		String banner = "";
		pDTO= service.productByCategory(c_id);  //해당카테고리상품리스트
		System.out.println(pDTO.getList());
		if(mdto !=null) {//로그인이 되었을 경우 찜 가져오기
			zzimList=service.zzimAllCheck(mdto.getUserid());
			System.out.println(zzimList);
		}
		if(c_id==6) {
			banner = 
					"<img style='position: relative; left: 150px; bottom:10px;' id='banner' alt=''src='/zzp/resources/images/main/banner_sale.png'>" ;
		}
		
		mav.addObject("c_id",c_id);  
		mav.addObject("pDTO",pDTO);  
		List<CategoryDTO> categoryList = service.category(); //카테고리 List 
		mav.addObject("categoryList", categoryList);
		mav.addObject("zzimList", zzimList);
		mav.addObject("banner", banner);
		mav.setViewName("storeMain");
		return mav;
	}
	
	@RequestMapping("/pageChange")
	@ResponseBody
	public ModelAndView pageChange(HttpSession session ,@RequestParam("curPage") String curPage,@RequestParam("sortBy") String sortBy,@RequestParam("c_id") String c_id) {
		System.out.println("페이징 컨트롤러");
		System.out.println("curPage :"+ curPage);
		System.out.println("sortBy :"+ sortBy);
		System.out.println("c_id :"+ c_id);
		List<Integer> zzimList = new ArrayList<Integer>();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login");
		ModelAndView mav = new ModelAndView();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("curPage",curPage);
		map.put("sortBy", sortBy);
		map.put("c_id", c_id);
		PageDTO pDTO = new PageDTO();
		if(c_id.equals(0)||c_id.equals("")) {
			pDTO=service.bestProdPaging(map);
			System.out.println(pDTO.getList());
			mav.addObject("pDTO", pDTO);
		}else {
			pDTO=service.paging(map);
			System.out.println(pDTO.getList());
			mav.addObject("pDTO", pDTO);
		}
		mav.setViewName("productPaging");
		
		return mav;		
	}
	
	//제품상세
	@RequestMapping(value = "/product/{p_id}")
	public ModelAndView productRetrieve(HttpSession session ,@PathVariable("p_id") int p_id) {
		ModelAndView mav = new ModelAndView();
		HashMap<String, String> map = new HashMap<String, String>();
		List<Integer> zzimList = new ArrayList<Integer>();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login");  //로그인세션
		ProductDTO pdto= service.productRetrieve(p_id);  //선택상품상세
		System.out.println("productRetrieve Controller 실행 : "+ p_id );
		System.out.println(pdto);
		List<ImagesDTO> imageList= service.ImagesRetrieve(p_id);
		System.out.println(imageList);
		if(mdto!=null) {
			map.put("userid", mdto.getUserid());
			map.put("p_id", String.valueOf(pdto.getP_id()));
			zzimList=service.zzimAllCheck(mdto.getUserid());
		}
		List<CategoryDTO> categoryList = service.category(); //카테고리 List 
		
		List<QuestionDTO> prodQuestion = qService.prodQuestion(Integer.toString(p_id));
		System.out.println("상품 문의 " + prodQuestion); // Question

		List<ReviewProfileDTO> prodReview = rService.prodReview(Integer.toString(p_id));
		System.out.println("상품 리뷰 " + prodReview); // 리뷰

		mav.addObject("prodQuestion", prodQuestion);
		mav.addObject("prodReview", prodReview);
		
		mav.addObject("categoryList", categoryList);
		mav.addObject("pdto",pdto);
		mav.addObject("imageList",imageList);
		mav.addObject("mdto", mdto);
		mav.addObject("zzim", zzimList);
		mav.setViewName("productRetrieve");
		
		return mav;
	}
	
	//찜기능
	@RequestMapping("/zzim")
	public @ResponseBody int zzim(@RequestParam("p_id") int p_id , HttpSession session) {
		MemberDTO mdto = (MemberDTO) session.getAttribute("login");
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("userid", mdto.getUserid());
		map.put("p_id", String.valueOf(p_id));
		int zzimCheck = service.zzimCheck(map); //찜 검사(찜했는지안했는지)
		int zzimData = 0;
		if(zzimCheck==0) {    //찜 안했을때 
			service.addZzim(map);  //찜 추가
			zzimData = 1;
		}else {   //찜 했을때
			service.deleteZzim(map);  //찜 제거
			zzimData=0;
		}
		
		return zzimData;
	}
	
	
	 
	

}
