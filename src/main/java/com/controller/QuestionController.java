package com.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.dto.QuestionDTO;
import com.dto.UploadDTO;
import com.service.QuestionService;

@Controller
public class QuestionController {
	
	@Autowired
	QuestionService service; 
	/**
	 * 큐엔에이 리스트 출력
	 */
	@RequestMapping(value = "/qna", method = RequestMethod.GET)
	public String questionList(Model m, HttpServletRequest request) {
		PageDTO pDTO = new PageDTO();
		String curPage = request.getParameter("curPage"); 
		if (curPage == null) {  
			curPage = "1";
		}
		pDTO = service.questionPage(Integer.parseInt(curPage));
		System.out.println("pDTO " + pDTO);
		
		m.addAttribute("pDTO", pDTO);
		
		return "question";
	}
	/**
	 * 큐엔에이 글 쓰러가기
	 */
	@RequestMapping(value = "/qna/write", method = RequestMethod.GET)
	public String questionInsert(HttpSession session, Model m) {
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		m.addAttribute("mDTO", mDTO);
		return "questionInsert";
	}
	/**
	 * 상품 검색 팝업 띄우기
	 */
	@RequestMapping("/qna/pop")
	public String prodSelectPop() {
		return "questionproductSelect";
	}
	/**
	 * 상품 검색
	 */
	@RequestMapping(value = "/qna/search")
	public ModelAndView prodselect(String category, String searchValue, String prodNum, HttpServletRequest request) {
		System.out.println("검색할 내용 " + category + "\t" + searchValue);
		System.out.println("한페이지에 볼 상품 갯수 " + prodNum);
		String curPage = request.getParameter("curPage");
		if (curPage == null) {
			curPage = "1";
		}
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("category", category);
		map.put("searchValue", searchValue);
		
		PageDTO page = service.prodSelect(map, Integer.parseInt(curPage), Integer.parseInt(prodNum));
		System.out.println("검색된 항목 " + page); //검색된 항목
		
		int num = service.prodSelectCount(map); //검색된 갯수
		System.out.println("검색된 항목 갯수 " + num);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("prodSelect", page);
		mav.addObject("prodSelectCount", num);
		mav.addObject("category", category);
		mav.addObject("searchValue", searchValue);
		mav.addObject("prodNum", prodNum);
		mav.setViewName("questionproductSelect");
		
		return mav;
	}
	@RequestMapping(value = "/qna", method = RequestMethod.POST)
	public @ResponseBody String xxx2(UploadDTO dto, QuestionDTO qDTO) {//자동 주입 생성
		System.out.println("문의 등록 내용 " + qDTO);
		System.out.println("파일 업로드 " + dto);
		
		String theText= dto.getTheText();
		CommonsMultipartFile theFile= dto.getTheFile();
		
		long size = theFile.getSize();
		String name= theFile.getName();
		String originalFileName= theFile.getOriginalFilename();
		String contentType= theFile.getContentType();
		System.out.println("size:  "+ size);
		System.out.println("name:  "+ name);
		System.out.println("originalFileName:  "+ originalFileName);
		System.out.println("contentType:  "+ contentType);
		
		File f= new File("c://upload", originalFileName);
		try {
			//theFile.transferTo(f);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:qna";
	}
	
}
