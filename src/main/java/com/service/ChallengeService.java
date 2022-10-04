package com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	//메인 - 뉴 챌린지
	public List<ChallengeDTO> selectNewChallenge() {
		return dao.selectNewChallenge();
	}

	public void updateChallHits(String chall_id) {
		dao.updateChallHits(chall_id);
	}

	public ChallengeDTO selectOneChallenge(String chall_id) {
		return dao.selectOneChallenge(chall_id);
	}

	public PageDTO selectAllComments(HashMap<String, String> map) {
		return dao.selectAllComments(map);
	}

	public String selectProfileImg(String userid) {
		return dao.selectProfileImg(userid);
	}

	public int countLikedByMap(HashMap<String, String> map) {
		return dao.countLikedByMap(map);
	}

	public int insertChallenge(HashMap<String, String> map) {
		return dao.insertChallenge(map);
	}

	public int deleteChallenge(String chall_id) {
		return dao.deleteChallenge(chall_id);
	}

	public int updateChallenge(HashMap<String, String> map) {
		return dao.updateChallenge(map);
	}
	
	public PageDTO selectChallengeByUserid(HashMap<String, String> map, int perPage) {
		return dao.selectChallengeByUserid(map, perPage);
	}

	@Transactional
	public String like(HashMap<String, String> map) {
		//해당 게시글에 현재 회원이 좋아요를 눌렀는지 확인
		int likedIt = dao.countLikedByMap(map);
		String img = null;
		
		//좋아요 추가
		if (likedIt == 0) {
			dao.insertLike(map);
			img = "/zzp/resources/images/challenge/liked.png";
		
		//좋아요 삭제
		} else if (likedIt == 1) {
			dao.deleteLike(map);
			img = "/zzp/resources/images/challenge/like.png";
		}
		
		//해당 게시글의 좋아요 수 변경
		dao.updateChallLiked(map.get("chall_id"));
		
		return img;
	}

	public int countLiked(String chall_id) {
		return dao.countLiked(chall_id);
	}

	@Transactional
	public void addComment(CommentsDTO dto) {
		//댓글 추가
		if (dto.getParent_id() == 0) {
			dao.insertComment(dto);
			
		//답글 추가
		} else {
			dao.insertReply(dto);
		}
		
		//해당 게시글의 댓글수 변경
		dao.updateChallComments(String.valueOf(dto.getChall_id()));
	}

	public int countComments(String chall_id) {
		return dao.countComments(chall_id);
	}

	@Transactional
	public void deleteComment(String comment_id, String chall_id) {
		//댓글 삭제
		dao.deleteAllComments(comment_id);
		
		//해당 게시글의 댓글수 변경
		dao.updateChallComments(chall_id);
	}

	public int getNewestComment(String userid) {
		return dao.getNewestComment(userid);
	}

	public int getCommentPage(HashMap<String, Integer> map) {
		return dao.getCommentPage(map);
	}

	public void updateComment(CommentsDTO dto) {
		dao.updateComment(dto);
	}

	public int checkReportExist(HashMap<String, String> map) {
		return dao.checkReportExist(map);
	}

	public void insertReport(HashMap<String, String> map) {
		dao.insertReport(map);
	}

	public PageDTO selectMemberStampByUserid(HashMap<String, String> map, int perPage) {
		return dao.selectMemberStampByUserid(map, perPage);
	}

	public int countTotalStamp(HashMap<String, String> map) {
		return dao.countTotalStamp(map);
	}

	



}
