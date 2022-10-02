package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.AddressDTO;
import com.dto.CategoryDTO;
import com.dto.PageDTO;
import com.dto.ProductByCategoryDTO;

@Repository
public class AdminDAO {
	@Autowired
	SqlSessionTemplate session;

	//관리자페이지 상품관리 : 전체 상품 목록
	public PageDTO selectAllProduct(HashMap<String, String> map) {
		int curPage = Integer.parseInt(
					  Optional.ofNullable(map.get("page")) //현제 페이지 null이면
					  .orElse(("1"))//1로 설정
				);
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(10);//한 페이지 당 record 10개 씩
		int perPage = pDTO.getPerPage();
		int offset = (curPage-1)*perPage; //페이지 시작 idx
		
		List<ProductByCategoryDTO> list = session.selectList("AdminMapper.selectAllProduct", map, new RowBounds(offset, perPage));
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(countTotalAdmin(map));
		
		pDTO.setStartEndPages();//startPage, endPage, prev, next 생성 함수 호출
		
		return pDTO;
	}
	//관리자페이지 상품관리 : 전체 상품 목록 페이징 countTotal
	private int countTotalAdmin(HashMap<String, String> map) {
		return session.selectOne("AdminMapper.countTotalAdmin", map);
	}
	
	//관리자페이지 회원 관리 : 전체 회원 목록
	public PageDTO selectAllMember(HashMap<String, String> map) {
		int curPage=Integer.parseInt(
				  Optional.ofNullable(map.get("page"))//현재 페이지 null이면
				  .orElse(("1"))//1로 설정
		);
		String sortBy=Optional.ofNullable(map.get("sortBy")).orElse("created_at");//초기 정렬
		map.put("sortBy", sortBy);
		PageDTO pDTO=new PageDTO();
		pDTO.setPerPage(5);//한 페이지 당 record 5개 씩
		int perPage=pDTO.getPerPage();
		int offset=(curPage-1)*perPage;//페이지 시작 idx
		
		List<AddressDTO> list=session.selectList("AdminMapper.selectAllMember", map, new RowBounds(offset, perPage));
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(countTotalMember(map));
		
		pDTO.setStartEndPages();//startPage, endPage, prev, next 생성 함수 호출
		
		return pDTO;
	}
	//관리자페이지 회원 관리 : 전체 회원 목록 페이징 countTotal
	private int countTotalMember(HashMap<String, String> map) {
		return session.selectOne("AdminMapper.countTotalMember", map);
	}

}
