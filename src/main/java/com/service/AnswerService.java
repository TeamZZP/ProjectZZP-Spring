package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.AnswerDAO;
import com.dto.AnswerDTO;

@Service
public class AnswerService {

	@Autowired
	AnswerDAO dao;

	public AnswerDTO answerSelect(String q_id) {
		AnswerDTO dto = dao.answerSelect(q_id);
		return dto;
	}
	
}
