package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.NoticeDAO;
import com.dto.NoticeDTO;
import com.dto.PageDTO;

@Service
public class NoticeService {
	
	@Autowired
	NoticeDAO dao;

	public List<NoticeDTO> pointNotice() {
		List<NoticeDTO> list = dao.pointNotice();
		return list;
	}

	public PageDTO noticePage(int curPage) {
		PageDTO dto = dao.noticePage(curPage);
		return dto;
	}

}
