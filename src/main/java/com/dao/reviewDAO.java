package com.dao;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.PageDTO;
import com.dto.ReviewProductImagesDTO;
import com.dto.ReviewProfileDTO;

@Repository
public class reviewDAO {

	@Autowired
	SqlSessionTemplate session;

	public List<ReviewProfileDTO> pordReview(String p_id) {
		List<ReviewProfileDTO> list = session.selectList("ReviewMapper.pordReview", p_id);
		return list;
	}

	public PageDTO myReview(String userid, Map<String, String> map) {
		int curPage = Integer.parseInt(Optional.ofNullable(map.get("page")).orElse("1"));
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(10);
		int perPage = pDTO.getPerPage();
		int offset = (curPage - 1) * perPage;
		
		List<ReviewProductImagesDTO> list = session.selectList("ReviewMapper.myReview", userid, new RowBounds(offset, perPage));
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(myReviewCount(userid));
		
		pDTO.setStartEndPages();
		
		return pDTO;
	}
	private int myReviewCount(String userid) {
		return session.selectOne("ReviewMapper.myReviewCount", userid);
	}
	
}
