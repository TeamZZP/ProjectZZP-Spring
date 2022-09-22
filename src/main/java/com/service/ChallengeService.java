package com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ChallengeDAO;
import com.dto.ChallengeDTO;
import com.dto.CommentsDTO;
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

	public void updateChallHits(String chall_id) {
		dao.updateChallHits(chall_id);
	}

	public ChallengeDTO selectOneChallenge(String chall_id) {
		return dao.selectOneChallenge(chall_id);
	}

	public List<CommentsDTO> selectAllComments(String chall_id) {
		return dao.selectAllComments(chall_id);
	}

	public String selectProfileImg(String userid) {
		return dao.selectProfileImg(userid);
	}

	public int countLikedByMap(HashMap<String, String> map) {
		return dao.countLikedByMap(map);
	}

}
