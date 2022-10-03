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
import com.dto.ImagesDTO;
import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.dto.ProductByCategoryDTO;
import com.dto.ProductDTO;

@Repository
public class AdminDAO {
	@Autowired
	SqlSessionTemplate session;

	//상품관리 : 전체 상품 목록
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
	//상품관리 : 전체 상품 목록 페이징 countTotal
	private int countTotalAdmin(HashMap<String, String> map) {
		return session.selectOne("AdminMapper.countTotalAdmin", map);
	}
	
	//회원 관리 : 전체 회원 목록
	public PageDTO selectAllMember(HashMap<String, String> map) {
		int curPage=Integer.parseInt(
				  Optional.ofNullable(map.get("page"))//현재 페이지 null이면
				  .orElse(("1"))//1로 설정
		);
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
	//회원 관리 : 전체 회원 목록 페이징 countTotal
	private int countTotalMember(HashMap<String, String> map) {
		return session.selectOne("AdminMapper.countTotalMember", map);
	}
	
	//회원 관리 : 회원 삭제
	public void deleteMember(String userid) {
		int n=session.delete("MypageMapper.deleteMember", userid);
		System.out.println("회원 삭제 : "+n);
	}
	
	//회원 관리 : 회원 정보 조회
	public MemberDTO selectMember(String userid) {
		return session.selectOne("MypageMapper.selectMember", userid);
	}
	
	//회원 관리 : 회원 배송지 목록 조회
	public List<AddressDTO> selectAllAddress(String userid) {
		return session.selectList("MypageMapper.selectAllAddress", userid);
	}
	
	//회원 관리 : 회원 정보 수정
	public void updateMember(HashMap<String, String> map) {
		int n=session.update("AdminMapper.updateMember", map);
		System.out.println("회원 수정 : "+n);
	}
	
	//상품관리 : 상품 삭제
	public void deleteProduct(List<String> ids) {
		int num = session.delete("AdminMapper.deleteProduct",ids);
		System.out.println("productDelete num : "+num);
	}
	
	//상품관리 : 상품 수정페이지(상품)
	public ProductDTO productRetrieve(int p_id) {
		return session.selectOne("AdminMapper.productRetrieve", p_id);
	}
	
	//상품관리 : 상품 수정페이지(이미지)
	public List<ImagesDTO> ImagesRetrieve(int p_id) {
		return session.selectList("AdminMapper.ImagesRetrieve",p_id);
	}

}
