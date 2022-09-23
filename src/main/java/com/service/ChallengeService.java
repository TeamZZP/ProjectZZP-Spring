package com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ChallengeDAO;
import com.dto.ChallengeDTO;
import com.dto.PageDTO;

@Service
public class ChallengeService {
	@Autowired
	private ChallengeDAO dao;

	public List<ChallengeDTO> getList() {
		return dao.getList();
	}

	public PageDTO selectAllChallenge(HashMap<String, String> map) {
		return dao.selectAllChallenge(map);
	}

	public ChallengeDTO selectChallThisMonth() {
		return dao.selectChallThisMonth();
	}

	public List<Integer> selectLikedChall(String userid) {
		return dao.selectLikedChall(userid);
	}
	
	//메인 - 뉴 챌린지
	public List<ChallengeDTO> selectNewChallenge() {
		return dao.selectNewChallenge();
	}

}
