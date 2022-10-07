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
import com.dto.ReportDTO;
import com.dto.StampDTO;

@Repository
public class ChallengeDAO {
	@Autowired
	private SqlSessionTemplate session;

	public List<ChallengeDTO> getList() {
		return session.selectList("ChallengeMapper.getList");
	}

	public PageDTO selectAllChallenge(HashMap<String, String> map) {
		int curPage = Integer.parseInt(map.getOrDefault("page", "1"));
		
		PageDTO pDTO = new PageDTO();
		pDTO.setPage(curPage);
		pDTO.setPerPage(8);
		int perPage = pDTO.getPerPage();
		int offset = (curPage - 1)*perPage;
		
		List<ChallengeDTO> list = session.selectList("ChallengeMapper.selectAllChallenge", map, new RowBounds(offset, perPage));
		
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
	
	public void insertChallenge(HashMap<String, String> map) {
		int n = session.insert("ChallengeMapper.insertChallenge", map);
		System.out.println("insert 개수 : "+n);
	}

	public int deleteChallenge(String chall_id) {
		return session.delete("ChallengeMapper.deleteChallenge", chall_id);
	}

	public int updateChallenge(HashMap<String, String> map) {
		return session.update("ChallengeMapper.updateChallenge", map);
	}
	
	public PageDTO selectChallengeByUserid(HashMap<String, String> map, int perPage) {
		int curPage = Integer.parseInt(map.getOrDefault("page", "1"));
		
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(perPage);
		int offset = (curPage - 1)*perPage;
		
		List<ChallengeDTO> list = session.selectList("ChallengeMapper.selectChallengeByUserid", map, new RowBounds(offset, perPage));
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(countTotalUserChallenge(map));
		
		pDTO.setStartEndPages();
		
		return pDTO;
	}
	
	public int countTotalUserChallenge(HashMap<String, String> map) {
		return session.selectOne("ChallengeMapper.countTotalUserChallenge", map);
	}

	public PageDTO selectAllComments(HashMap<String, String> map) {
		int curPage = Integer.parseInt(map.getOrDefault("page", "1"));
		
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(5);
		pDTO.setTotalCount(countComments(map.get("chall_id")));
		
		int perPage = pDTO.getPerPage();
		int totalCount = pDTO.getTotalCount();
		
		int totalPage = (int) Math.ceil((double)totalCount/perPage);
		if (curPage > totalPage) curPage = totalPage; //넘어온 페이지가 전체 페이지를 넘을 경우 마지막 페이지로 변경
		
		int offset = (curPage - 1)*perPage;
		
		List<CommentsDTO> list = session.selectList("ChallengeMapper.selectAllComments", map, new RowBounds(offset, perPage));
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
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

	public int getNewestComment(String userid) {
		return session.selectOne("ChallengeMapper.getNewestComment", userid);
	}

	public int getCommentPage(HashMap<String, Integer> map) {
		return session.selectOne("ChallengeMapper.getCommentPage", map);
	}

	public void updateComment(CommentsDTO dto) {
		int n = session.update("ChallengeMapper.updateComment", dto);
		System.out.println("update된 댓글 수 "+n);
	}

	public int checkReportExist(HashMap<String, String> map) {
		return session.selectOne("ChallengeMapper.checkReportExist", map);
	}

	public void insertReport(HashMap<String, String> map) {
		int n = session.insert("ChallengeMapper.insertReport", map);
		System.out.println("insert된 신고 수 "+n);
	}

	public PageDTO selectMemberStampByUserid(HashMap<String, String> map, int perPage) {
		int curPage = Integer.parseInt(map.getOrDefault("page", "1"));
		
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(perPage);
		int offset = (curPage - 1)*perPage;
		
		List<StampDTO> list = session.selectList("ChallengeMapper.selectMemberStampByUserid", map, new RowBounds(offset, perPage));
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(countTotalPageStamp(map));
		
		pDTO.setStartEndPages();
		
		return pDTO;
	}
	
	private int countTotalPageStamp(HashMap<String, String> map) {
		return session.selectOne("ChallengeMapper.countTotalPageStamp", map);
	}

	public int countTotalStamp(HashMap<String, String> map) {
		return session.selectOne("ChallengeMapper.countTotalStamp", map);
	}

	public void updateStamp(HashMap<String, String> map) {
		int n = session.update("ChallengeMapper.updateStamp", map);
		System.out.println("update된 도장 수 "+n);
	}


	public void updateOrder(HashMap<String, String> map) {
		int n = session.update("ChallengeMapper.updateOrder", map);
		System.out.println("update된 주문 수 "+n);
	}

	public ReportDTO selectOneReport(String id) {
		return session.selectOne("ChallengeMapper.selectOneReport", id);
	}

	public int selectChallIdFromComment(int comment_id) {
		return session.selectOne("ChallengeMapper.selectChallIdFromComment", comment_id);
	}

	public void deleteReport(List<Integer> ids) {
		int n = session.delete("ChallengeMapper.deleteReport", ids);
		System.out.println("delete된 신고 수 "+n);
	}

	public void updateReport(HashMap<String, String> map) {
		int n = session.update("ChallengeMapper.updateReport", map);
		System.out.println("update된 신고 수 "+n);
	}


	

	

	

}
