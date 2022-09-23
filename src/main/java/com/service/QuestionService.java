package com.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.QuestionDAO;
import com.dto.PageDTO;

@Service
public class QuestionService {
	
	@Autowired
	QuestionDAO dao;

	public PageDTO questionPage(int curPage) {
		PageDTO dto = dao.questionPage(curPage);
		return dto;
	}

	public PageDTO prodSelect(Map<String, String> map, int curPage, int prodNum) {
		PageDTO dto = dao.prodSelect(map, curPage, prodNum);
		return dto;
	}

	public int prodSelectCount(Map<String, String> map) {
		int num = dao.prodSelectCount(map);
		return num;
	}

}
