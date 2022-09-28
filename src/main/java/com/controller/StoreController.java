package com.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dto.CartDTO;
import com.dto.CategoryDTO;
import com.dto.ImagesDTO;
import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.dto.ProductDTO;
import com.service.StoreService;

@Controller
public class StoreController {
	
	@Autowired
	StoreService service;
	
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
		}
		if(c_id==6) {
			banner = "<div style='text-align: center;'>\r\n" + 
					"              <img id='banner' alt=''src='/zzp/resources/images/main/banner_sale.png'>    \r\n" + 
					"        </div>";
		}
		
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
	public void pageChange(@RequestParam("pageNum") int pageNum ) {
		PageDTO pDTO = new PageDTO();
		
		
		
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
	
	@RequestMapping("/castingCartDTO")
	public @ResponseBody CartDTO castingCartDTO(HashMap<String, String> map) {
		CartDTO cdto = new CartDTO();
		Date date = new Date();
		String now = String.valueOf(date);
		cdto.setCart_created(now);
		cdto.setCart_id(1);
		cdto.setMoney(Integer.parseInt(map.get("p_amount"))*Integer.parseInt(map.get("p_selling_price")));
		cdto.setP_amount(Integer.parseInt(map.get("p_amount")));
		cdto.setP_id(Integer.parseInt(map.get("p_id")));
		cdto.setP_image(map.get("p_image"));
		cdto.setP_name(map.get("p_name"));
		cdto.setP_selling_price(Integer.parseInt(map.get("p_selling_price")));
		cdto.setUserid(map.get("userid"));	
		
		return cdto;
	}
	
	
	  public void order(HttpSession session, @PathVariable("cdto") CartDTO cdto) {
		  
		  
	  
	  }
	 
	

}
