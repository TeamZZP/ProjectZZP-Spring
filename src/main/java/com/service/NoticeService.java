package com.service;

import java.util.List;
import java.util.Map;

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

	public NoticeDTO noticeDelite(int notice_id) {
		NoticeDTO dto = dao.noticeDelite(notice_id);
		return dto;
	}

	public int nextNoticeID(Map<String, String> map) {
		int num = dao.nextNoticeID(map);
		return num;
	}

	public int noticeHite(Map<String, Integer> hiteMap) {
		int num = dao.noticeHite(hiteMap);
		return num;
	}

	public void noticeInsert(NoticeDTO dto) {
		dao.noticeInsert(dto);
	}

	public void noticeUpdate(NoticeDTO dto) {
		dao.noticeUpdate(dto);
	}

	public void noticeDelete(String notice_id) {
		dao.noticeDelete(notice_id);
	}

}
