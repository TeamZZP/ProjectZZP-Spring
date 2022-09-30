package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.PageDTO;
import com.dto.ProductOrderReviewDTO;
import com.dto.ReviewDTO;
import com.dto.ReviewProductImagesDTO;
import com.dto.ReviewProfileDTO;

@Repository
public class ReviewDAO {

	@Autowired
	SqlSessionTemplate session;

	public List<ReviewProfileDTO> prodReview(String p_id) {
		List<ReviewProfileDTO> list = session.selectList("ReviewMapper.prodReview", p_id);
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

	public ReviewDTO reviewCheck(Map<String, String> map) {
		ReviewDTO dto = session.selectOne("ReviewMapper.reviewCheck", map);
		return dto;
	}

	public void reviewInsert(HashMap<String, String> map) {
		int num = session.insert("ReviewMapper.reviewInsert", map);
		System.out.println("리뷰 추가 갯수 " + num);
	}

	public ProductOrderReviewDTO reviewOneSelect(String review_id) {
		ProductOrderReviewDTO dto = session.selectOne("ReviewMapper.reviewOneSelect", review_id);
		return dto;
	}

	public void reviewUpate(HashMap<String, String> map) {
		int num = session.update("ReviewMapper.reviewUpate", map);
		System.out.println("리뷰 수정 갯수 " + num);
	}

	public int reviewDelete(String review_id) {
		int num = session.delete("ReviewMapper.reviewDelete", review_id);
		return num;
	}

	
}
