package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dto.NoticeDTO;
import com.service.NoticeService;

@Controller
public class NoticeController {
	
	@Autowired
	NoticeService service;
	
	@RequestMapping(value = "/notice")
	public @ResponseBody String noticeList() {
		List<NoticeDTO> noticeList = service.noticeList();
		System.out.println(noticeList);
		return "";
	}

}
