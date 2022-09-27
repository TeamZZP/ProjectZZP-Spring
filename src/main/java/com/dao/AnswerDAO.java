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

	public void answerUpdate(AnswerDTO aDTO) {
		int num = session.update("AnswerMapper.answerUpdate", aDTO);
		System.out.println("답변 수정 갯수 " + num);
	}

	public void answerInsert(AnswerDTO aDTO) {
		int num = session.insert("AnswerMapper.answerInsert", aDTO);
		System.out.println("답변 추가 갯수 " + num);
			
	}
	
}
