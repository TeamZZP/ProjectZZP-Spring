package com.controller;

import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.MemberDTO;
import com.dto.NoticeDTO;
import com.dto.PageDTO;
import com.service.NoticeService;

@Controller
public class NoticeController {
	
	@Autowired
	NoticeService service;
	
	/**
	 * 공지 출력
	 */
	@RequestMapping(value = "/notice", method = RequestMethod.GET)
	public String noticeList(@RequestParam Map<String, String> map, Model m, HttpSession session) {
		PageDTO pDTO = new PageDTO();
		int curPage = Integer.parseInt(map.getOrDefault("page", "1"));
		
		System.out.println(map);
		
		List<NoticeDTO> NoticePointList = service.pointNotice();//고정공지
		
		pDTO = service.noticePage(curPage);
		System.out.println("pDTO " + pDTO);
		
		m.addAttribute("NoticePointList", NoticePointList);
		m.addAttribute("mDTO", session.getAttribute("login"));
		m.addAttribute("pDTO", pDTO);
		
		return "noticeList";
	}
	/**
	 * 공지 상세보기
	 */
	@RequestMapping(value = "/notice/{notice_id}", method = RequestMethod.GET)
	public ModelAndView noticeDelite (@PathVariable String notice_id, @RequestParam String category, HttpSession session) {
		System.out.println("파씽 값 " + notice_id + "\t" + category);
		ModelAndView mav = new ModelAndView();
		
		NoticeDTO nDTO = service.noticeDelite(Integer.parseInt(notice_id)); 
		System.out.println("상세보기 " + nDTO);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("noticeID", notice_id);
		map.put("category", category);

		int nextID = 0;
		try {
			nextID = service.nextNoticeID(map);
			System.out.println("nextID" + nextID); // 다음 게시물 번호
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (nextID != 0) {
			NoticeDTO nextDTO = service.noticeDelite(nextID);
			System.out.println("nextDTO " + nextDTO); // 다음 게시물

			mav.addObject("nextDTO", nextDTO); // 다음글 보기
		} else {
			mav.addObject("nextDTO", null); // 다음글 보기
		}
		Map<String, Integer> hiteMap = new HashMap<String, Integer>();
		hiteMap.put("noticeID", nDTO.getNotice_id());
		hiteMap.put("noticeHite", nDTO.getNotice_hits() + 1);

		int hiteUpdateNum = service.noticeHite(hiteMap);
		System.out.println("hiteUpdateNum " + hiteUpdateNum); //조회수		
		
		mav.addObject("nDTO", nDTO); //상세보기
		mav.addObject("mDTO", session.getAttribute("login")); //로그인 정보
		mav.setViewName("noticeDetail");
		return mav;
	}
	/**
	 * 공지 글쓰로 가기
	 */
	@RequestMapping("/notice/write")
	public String noticeInsert() {
		return "noticeInsert";
	}
	/**
	 * 공지 추가
	 */
	@RequestMapping(value = "/notice", method = RequestMethod.POST)
	public String noticeInsert(NoticeDTO dto, HttpSession session, RedirectAttributes attr) {
		System.out.println("공지 입력 내용 " + dto);
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		String userid = mDTO.getUserid();
		dto.setUserid(userid);
		
		service.noticeInsert(dto);
		
		attr.addFlashAttribute("mesg", "게시글 작성이 완료되었습니다.");
		
		return "redirect:notice";
	}
	/**
	 * 공지 수정 페이지 가기
	 */
	@RequestMapping(value = "/notice/write/{notice_id}", method = RequestMethod.GET)
	public String noticeSelect(@PathVariable String notice_id, Model m) {
		System.out.println("공지 수정할 ID " + notice_id);
		NoticeDTO dto = service.noticeDelite(Integer.parseInt(notice_id));
		System.out.println("수정할 내용 가져오기 " + dto);
		
		m.addAttribute("dto", dto);
		
		return "noticeUpdate";
	}
	/**
	 * 공지 수정
	 */
	@RequestMapping(value = "/notice/{notice_id}", method = RequestMethod.PUT)
	public String noticeUpdate(@PathVariable String notice_id, NoticeDTO dto, RedirectAttributes attr) {
		System.out.println("공지 수정할 내용" + dto);
		service.noticeUpdate(dto);
		attr.addFlashAttribute("mesg", "게시글 수정이 완료되었습니다.");
		return "redirect:../notice";
	}
	/**
	 * 공지 삭제
	 */
	@RequestMapping(value = "/notice/{notice_id}", method = RequestMethod.DELETE)
	public String noticeDelete(@PathVariable String notice_id, RedirectAttributes attr) {
		System.out.println("삭제할 공지 " + notice_id);
		service.noticeDelete(notice_id);
		attr.addFlashAttribute("mesg", "게시글 삭제가 완료되었습니다.");
		return "redirect:../notice";
	}
	
}
