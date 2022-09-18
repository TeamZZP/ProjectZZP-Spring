package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ChallengeDAO;
import com.dto.ChallengeDTO;

@Service
public class ChallengeService {
	@Autowired
	private ChallengeDAO dao;

	public List<ChallengeDTO> getList() {
		return dao.getList();
	}

}
