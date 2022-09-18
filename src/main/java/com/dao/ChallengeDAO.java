package com.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.ChallengeDTO;

@Repository
public class ChallengeDAO {
	@Autowired
	private SqlSessionTemplate session;

	public List<ChallengeDTO> getList() {
		return session.selectList("ChallengeMapper.getList");
	}
	

}
