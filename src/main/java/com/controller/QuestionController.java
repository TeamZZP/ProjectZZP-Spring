package com.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.AnswerDTO;
import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.dto.QuestionProductDTO;
import com.service.AnswerService;
import com.service.QuestionService;

@Controller
public class QuestionController {
	
	@Autowired
	QuestionService qService; 
	@Autowired
	AnswerService aService;
	
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
		pDTO = qService.questionPage(Integer.parseInt(curPage));
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
		
		PageDTO page = qService.prodSelect(map, Integer.parseInt(curPage), Integer.parseInt(prodNum));
		System.out.println("검색된 항목 " + page); //검색된 항목
		
		int num = qService.prodSelectCount(map); //검색된 갯수
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
/*	@RequestMapping(value = "/qna", method = RequestMethod.POST)
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
	} */
	/**
	 * 큐엔에이 상세보기
	 */
	@RequestMapping(value = "/qna/{q_id}", method = RequestMethod.GET)
	public String questionDetail(@PathVariable String q_id, String userid, String before, HttpSession session,
			RedirectAttributes attr, Model m) {
		System.out.println("상세보기할 정보 " + q_id + "\t" + userid + "\t" + before);
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		String loginUser = mDTO.getUserid();
		
		String url = "";
		if (userid.equals(loginUser) || mDTO.getRole() == 1) {
			QuestionProductDTO qDTO = qService.questionDetail(q_id);
			AnswerDTO aDTO = aService.answerSelect(q_id);
			System.out.println("상세보기할 게시글 " + qDTO);
			System.out.println("게시글 답변 " + aDTO);
			
			m.addAttribute("qDTO", qDTO);
			m.addAttribute("aDTO", aDTO);
			m.addAttribute("mDTO", mDTO);
			m.addAttribute("before", before);
			
			url = "questionDetail";
		} else {
			attr.addFlashAttribute("mesg", "로그인이 필요합니다.");
			url = "redirect:../qna";
		}
		attr.addFlashAttribute("before", before);
		return url;
	}
	/**
	 * 큐엔에이 삭제
	 */
	@RequestMapping(value = "/qna/{q_id}", method = RequestMethod.DELETE)
	public String questionDelete(@PathVariable String q_id, RedirectAttributes attr) {
		System.out.println("삭제할 게시글 번호 " + q_id);
		qService.questionDelete(q_id);
		attr.addFlashAttribute("mesg", "게시글이 삭제 되었습니다.");
		return "redirect:../qna";
	}
	
}
