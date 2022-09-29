package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.QuestionDAO;
import com.dto.PageDTO;
import com.dto.QuestionDTO;
import com.dto.QuestionProductDTO;

@Service
public class QuestionService {
	
	@Autowired
	QuestionDAO dao;

	public PageDTO questionPage(int curPage) {
		PageDTO dto = dao.questionPage(curPage);
		return dto;
	}

	public PageDTO prodSelect(Map<String, String> map, int prodNum) {
		PageDTO dto = dao.prodSelect(map, prodNum);
		return dto;
	}

	public int prodSelectCount(Map<String, String> map) {
		int num = dao.prodSelectCount(map);
		return num;
	}

	public QuestionProductDTO questionDetail(String q_id) {
		QuestionProductDTO dto = dao.questionDetail(q_id);
		return dto;
	}

	public void questionDelete(String q_id) {
		dao.questionDelete(q_id);
	}

	public void questionStatus(String q_id) {
		dao.questionStatus(q_id);
	}

	public void questionInsert(HashMap<String, String> map) {
		dao.questionInsert(map);
	}

	public void questionUPdate(Map<String, String> map) {
		dao.questionUpdate(map);
	}

	public List<QuestionDTO> prodQuestion(String p_id) {
		List<QuestionDTO> list = dao.prodQuestion(p_id);
		return list;
	}

	public PageDTO myQuestion(String userid, Map<String, String> map) {
		PageDTO list = dao.myQuestion(userid, map);
		return list;
	}

}
