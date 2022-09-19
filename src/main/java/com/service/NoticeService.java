package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.NoticeDAO;
import com.dto.NoticeDTO;

@Service("NoticeService")
public class NoticeService {
	
	@Autowired
	NoticeDAO dao;

	public List<NoticeDTO> noticeList() {
		List<NoticeDTO> list = dao.noticeList();
		return list;
	}

}
