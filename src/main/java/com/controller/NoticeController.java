package com.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	@RequestMapping(value = "/notice")
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

}
