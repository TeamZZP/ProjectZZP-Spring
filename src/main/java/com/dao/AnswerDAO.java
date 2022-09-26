package com.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.AnswerDTO;

@Repository
public class AnswerDAO {

	@Autowired
	SqlSessionTemplate session;

	public AnswerDTO answerSelect(String q_id) {
		AnswerDTO dto = session.selectOne("AnswerMapper.answerSelect", q_id);
		return dto;
	}
	
}
