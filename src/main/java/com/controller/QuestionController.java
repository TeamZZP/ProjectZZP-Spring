package com.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.AnswerDTO;
import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.dto.QuestionProductDTO;
import com.service.AnswerService;
import com.service.QuestionService;
import com.util.Upload;

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
	public String questionList(@RequestParam Map<String, String> map, Model m, HttpSession session) {
		PageDTO pDTO = new PageDTO();
		int curPage = Integer.parseInt(map.getOrDefault("page", "1"));
		
		pDTO = qService.questionPage(curPage);
		System.out.println("pDTO " + pDTO);
		
		m.addAttribute("pDTO", pDTO);
		m.addAttribute("mDTO", session.getAttribute("login"));
		
		return "question";
	}
	/**
	 * 큐엔에이 글 쓰러가기
	 */
	@RequestMapping(value = "/qna/write", method = RequestMethod.GET)
	public String questionInsert(HttpSession session, Model m, @RequestParam Map<String,String> map) {
		System.out.println("상품상세보기에서 글쓰기 " + map);
		
		m.addAttribute("mDTO", session.getAttribute("login"));
		m.addAttribute("prodQnaInserInfo", map);
		
		return "questionInsert";
	}
	/**
	 * 상품 검색 팝업 띄우기
	 */
	@RequestMapping(value = "/qna/pop", method = RequestMethod.GET)
	public String prodSelectPop() {
		return "questionproductSelect";
	}
	/**
	 * 상품 검색 팝업
	 */
	@RequestMapping(value = "/qna/search", method = RequestMethod.GET)
	public ModelAndView prodselect(@RequestParam Map<String, String> map, 
			String category, String searchValue, String prodNum, HttpServletRequest request) {
		System.out.println("검색할 내용 " + category + "\t" + searchValue);
		System.out.println("한페이지에 볼 상품 갯수 " + prodNum);
		
		System.out.println(map);
		
		PageDTO page = qService.prodSelect(map, Integer.parseInt(prodNum));
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
	/**
	 * 큐엔에이 게시글 작성
	 */
	@RequestMapping(value = "/qna", method = RequestMethod.POST)
	public String questionInsert (@RequestParam HashMap<String, String> map, 
			@RequestParam("qna_img") CommonsMultipartFile uploadFile, RedirectAttributes attr) {
		
		String originalFileName= uploadFile.getOriginalFilename();
		String location = "qna";
		
		Upload.uploadFile(location, uploadFile);
		map.put("qna_img", originalFileName);
		
		qService.questionInsert(map);
		
		attr.addFlashAttribute("mesg", "게시물이 작성되었습니다.");
		
		return "redirect:/qna";
	}
	/**
	 * 게시글 수정 페이지 가기
	 */
	@RequestMapping(value = "/qna/write/{q_id}", method = RequestMethod.GET)
	public String questionUpdatePage(@PathVariable String q_id, Model m) {
		System.out.println("수정할 게시글 번호 " + q_id);
		QuestionProductDTO dto = qService.questionDetail(q_id);
		m.addAttribute("dto", dto);
		return "questionUpdate";
	}
	/**
	 * 게시글 수정
	 */
	@RequestMapping(value = "/qna/{q_id}", method = RequestMethod.POST)
	public String questionUpdate(@PathVariable String q_id, @RequestParam Map<String, String> map, 
			@RequestParam("qna_img") CommonsMultipartFile uploadFile, RedirectAttributes attr) {
		
		System.out.println("수정할 게시글 " + map);
		
		String originalFileName= uploadFile.getOriginalFilename();
		String location = "qna";
		
		String oldFile = map.get("oldFile");
		
		if(oldFile == null || oldFile.length() == 0) { //사진을 업로드 하는 경우 : 추가
			Upload.uploadFile(location, uploadFile);
			map.put("qna_img", originalFileName); 
		} else if (originalFileName != oldFile) { //사진을 업로드 했었고 수정하는 경우 : 수정
			Upload.uploadFile(location, uploadFile);
			Upload.uploadFile(location, uploadFile);
			map.put("qna_img", originalFileName);
		} else { //사진 첫 업로드
			map.put("qna_img", oldFile);
		}
		Upload.uploadFile(location, uploadFile);
		map.put("qna_img", originalFileName);
		
		qService.questionUPdate(map);
		
		attr.addFlashAttribute("mesg", "게시글이 수정 되었습니다.");
		
		return "redirect:/qna";
	}
	/**
	 * 큐엔에이 상세보기
	 */
	@RequestMapping(value = "/qna/{q_id}", method = RequestMethod.GET)
	public String questionDetail(@PathVariable String q_id, HttpSession session, RedirectAttributes attr, Model m) {
		System.out.println("상세보기할 정보 " + q_id);
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		
		QuestionProductDTO qDTO = qService.questionDetail(q_id);
		AnswerDTO aDTO = aService.answerSelect(q_id);
		System.out.println("상세보기할 게시글 " + qDTO);
		System.out.println("게시글 답변 " + aDTO);
			
		m.addAttribute("qDTO", qDTO);
		m.addAttribute("aDTO", aDTO);
		m.addAttribute("mDTO", mDTO);
			
		return "questionDetail";
	}
	/**
	 * 큐엔에이 삭제
	 */
	@RequestMapping(value = "/qna/{q_id}", method = RequestMethod.DELETE)
	public String questionDelete(@PathVariable String q_id, RedirectAttributes attr) {
		System.out.println("삭제할 게시글 번호 " + q_id);
		qService.questionDelete(q_id);
		attr.addFlashAttribute("mesg", "게시글이 삭제 되었습니다.");
		
		QuestionProductDTO dto = qService.questionDetail(q_id);
		if(dto != null) {
			String qna_img = dto.getQ_img();
			
			if(qna_img != null) {
				System.out.println("리뷰 사진 삭제");
				String location = "qna";
				Upload.deleteFile(location, qna_img);
			}
		}
		return "redirect:../qna";
	}
	/**
	 * 개시글 답변
	 */     
	@RequestMapping(value = "/qna/{q_id}/answer", method = RequestMethod.POST)
	public @ResponseBody String questionAnswer(@PathVariable String q_id, @RequestParam String answer, 
			HttpSession session, RedirectAttributes attr, HttpServletRequest request) {
		System.out.println("답변할 게시글번호:  " + q_id + "\t" + "내용 " +answer);
		System.out.println(answer);
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		
		AnswerDTO aDTO = aService.answerSelect(q_id);
		System.out.println("게시들에 달린 댓글 여부 확인 " + aDTO);
		
		String data = "";
		if (aDTO != null) { //달린 댓글이 있으면 업데이트
			if (mDTO.getRole() == 1) {
				AnswerDTO dto = new AnswerDTO();
				dto.setAnswer_content(answer);
				dto.setQ_id(Integer.parseInt(q_id));
				
				aService.answerUpdate(dto); //답변 수정
				
				attr.addFlashAttribute("dto", dto);
				
				data = dto.getAnswer_content();
			} 
		} else {//달린 댓글이 없으면 추가
			if (mDTO.getRole() == 1) {
				AnswerDTO dto = new AnswerDTO();
				dto.setAnswer_content(answer);
				dto.setQ_id(Integer.parseInt(q_id));

				aService.answerInsert(dto);
				
				attr.addFlashAttribute("dto", dto);
				
				data = dto.getAnswer_content();
			} 
		}
		qService.questionStatus(q_id); //답변 상태 수정
		return data; 
	}
	/**
	 * 이미지 상세보기 팝업
	 */
	@RequestMapping(value = "/showImg")
	public String showImg(HttpServletRequest request, Model m) {
		String img = request.getParameter("img");
		System.out.println("이미지 주소 " + img);
		m.addAttribute("img", img);
		return "showImg";
	}
}
