package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.ChallengeDTO;
import com.dto.CommentsDTO;
import com.dto.PageDTO;

@Repository
public class ChallengeDAO {
	@Autowired
	private SqlSessionTemplate session;

	public List<ChallengeDTO> getList() {
		return session.selectList("ChallengeMapper.getList");
	}

	public PageDTO selectAllChallenge(HashMap<String, String> map) {
		int curPage = Integer.parseInt(
				Optional.ofNullable(map.get("page"))
				.orElse(("1"))
				);
		
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(8);
		int perPage = pDTO.getPerPage();
		int offset = (curPage - 1)*perPage;
		
		List<ChallengeDTO> list = session.selectList("ChallengeMapper.selectAllChallenge", map, new RowBounds(offset, perPage));
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(countTotalChall(map));
		
		pDTO.setStartEndPages();
		
		return pDTO;
	}

	private int countTotalChall(HashMap<String, String> map) {
		return session.selectOne("ChallengeMapper.countTotalChall", map);
	}

	public ChallengeDTO selectChallThisMonth() {
		return session.selectOne("ChallengeMapper.selectChallThisMonth");
	}

	public List<Integer> selectLikedChall(String userid) {
		return session.selectList("ChallengeMapper.selectLikedChall", userid);
	}

	public void updateChallHits(String chall_id) {
		session.update("ChallengeMapper.updateChallHits", chall_id);
	}

	public ChallengeDTO selectOneChallenge(String chall_id) {
		return session.selectOne("ChallengeMapper.selectOneChallenge", chall_id);
	}

	public PageDTO selectAllComments(HashMap<String, String> map) {
		int curPage = Integer.parseInt(
				Optional.ofNullable(map.get("page"))
				.orElse(("1"))
				);
		
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(5);
		int perPage = pDTO.getPerPage();
		int offset = (curPage - 1)*perPage;
		
		List<CommentsDTO> list = session.selectList("ChallengeMapper.selectAllComments", map, new RowBounds(offset, perPage));
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(countComments(map.get("chall_id")));
		
		pDTO.setStartEndPages();
		
		return pDTO;
	}

	public String selectProfileImg(String userid) {
		return session.selectOne("ChallengeMapper.selectProfileImg", userid);
	}

	public int countLikedByMap(HashMap<String, String> map) {
		return session.selectOne("ChallengeMapper.countLikedByMap", map);
	}
	
	//메인 - 뉴 챌린지
	public List<ChallengeDTO> selectNewChallenge() {
		return session.selectList("ChallengeMapper.selectNewChallenge");
	}


	public int insertChallenge(HashMap<String, String> map) {
		return session.insert("ChallengeMapper.insertChallenge", map);
	}

	public int deleteChallenge(String chall_id) {
		return session.delete("ChallengeMapper.deleteChallenge", chall_id);
	}

	public int updateChallenge(HashMap<String, String> map) {
		return session.update("ChallengeMapper.updateChallenge", map);
	}

	public void insertLike(HashMap<String, String> map) {
		int n = session.insert("ChallengeMapper.insertLike", map);
		System.out.println("insert된 좋아요 수 "+n);
	}

	public void deleteLike(HashMap<String, String> map) {
		int n = session.delete("ChallengeMapper.deleteLike", map);
		System.out.println("delete된 좋아요 수 "+n);
	}

	public void updateChallLiked(String chall_id) {
		int n = session.update("ChallengeMapper.updateChallLiked", chall_id);
		System.out.println("update된 게시글 수 "+n);
	}

	public int countLiked(String chall_id) {
		return session.selectOne("ChallengeMapper.countLiked", chall_id);
	}

	public void insertComment(CommentsDTO dto) {
		int n = session.insert("ChallengeMapper.insertComment", dto);
		System.out.println("insert된 댓글 수 "+n);
	}

	public void insertReply(CommentsDTO dto) {
		int n = session.insert("ChallengeMapper.insertReply", dto);
		System.out.println("insert된 댓글 수 "+n);
	}

	public void updateChallComments(String chall_id) {
		int n = session.update("ChallengeMapper.updateChallComments", chall_id);
		System.out.println("update된 게시글 수 "+n);
	}

	public int countComments(String chall_id) {
		return session.selectOne("ChallengeMapper.countComments", chall_id);
	}

	public void deleteAllComments(String comment_id) {
		int n = session.delete("ChallengeMapper.deleteAllComments", comment_id);
		System.out.println("delete된 댓글 수 "+n);
	}

	

}
