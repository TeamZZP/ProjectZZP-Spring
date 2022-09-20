package com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
	public String noticeList(HttpServletRequest request, Model m) {
		PageDTO pDTO = new PageDTO();
		String curPage = request.getParameter("curPage"); //현재 페이지
		if (curPage == null) {
			curPage = "1";
		}
		List<NoticeDTO> NoticePointList = service.pointNotice();//고정공지
		
		pDTO = service.noticePage(Integer.parseInt(curPage));
		System.out.println("pDTO " + pDTO);
		
		m.addAttribute("NoticePointList", NoticePointList);
		m.addAttribute("pDTO", pDTO);
		
		return "noticeList";
	}
	/**
	 * 공지 상세보기
	 */
	@RequestMapping(value = "/notice/{notice_id}", method = RequestMethod.GET)
	public ModelAndView noticeDelite (@PathVariable String notice_id, @RequestParam String category) {
		System.out.println(notice_id + category);
		ModelAndView mav = new ModelAndView();
		
		NoticeDTO nDTO = service.noticeDelite(notice_id); 
		System.out.println("상세보기 " + nDTO);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("noticeID", notice_id);
		map.put("notice_category", category);

		int nextID = 0;
		try {
			nextID = service.nextNoticeID(map);
			System.out.println("nextID" + nextID); // 다음 게시물 번호
		} catch (Exception e) {
			e.printStackTrace();
		}
		NoticeDTO nextDTO = service.noticeDelite(notice_id);
		System.out.println("nextDTO " + nextDTO); // 다음 게시물

		mav.addObject("nextDTO", nextDTO); // 다음글 보기

		Map<String, Integer> hiteMap = new HashMap<String, Integer>();
		hiteMap.put("noticeID", nDTO.getNotice_id());
		hiteMap.put("noticeHite", nDTO.getNotice_hits() + 1);

		int hiteUpdateNum = service.noticeHite(hiteMap);
		System.out.println("hiteUpdateNum " + hiteUpdateNum); //조회수		
		
		mav.addObject("nDTO", nDTO); //상세보기
		mav.setViewName("noticeDetail");
		return mav;
	}

}
