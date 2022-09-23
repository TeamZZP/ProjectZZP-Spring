package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.ChallengeDTO;
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
				Optional.ofNullable(map.get("curPage"))
				.orElse(("1"))
				);
		
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(8);
		int perPage = pDTO.getPerPage();
		int offset = (curPage - 1)*perPage;
		
		List<ChallengeDTO> list = session.selectList("ChallengeMapper.selectAllChallenge", map, new RowBounds(offset, perPage));
		
		pDTO.setCurPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(countTotalChall(map));
		
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
	
	//메인 - 뉴 챌린지
	public List<ChallengeDTO> selectNewChallenge() {
		return session.selectList("ChallengeMapper.selectNewChallenge");
	}
	

}
