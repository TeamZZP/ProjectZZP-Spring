package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.AddressDTO;
import com.dto.ImagesDTO;
import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.dto.ProductByCategoryDTO;
import com.dto.ProductDTO;
import com.dto.ProductOrderImagesDTO;
import com.dto.QuestionDTO;
import com.dto.ReportDTO;

@Repository
public class AdminDAO {
	@Autowired
	SqlSessionTemplate session;
	
	/**
	 * 메인화면
	 */
	//총 판매액
	public double getTotalSales() {
		return session.selectOne("AdminMapper.getTotalSales");
	}
	//오늘 판매액
	public double getTodaySales() {
		return session.selectOne("AdminMapper.getTodaySales");
	}
	//총 회원
	public int getTotalMember() {
		return session.selectOne("AdminMapper.getTotalMember");
	}
	//오늘 가입 회원
	public int getTodayMember() {
		return session.selectOne("AdminMapper.getTodayMember");
	}
	
	//오늘 방문자수
	public int countVisitToday() {
		return session.selectOne("AdminMapper.countVisitToday");
	}
	//총 방문자
	public int getTotalVisitor() {
		return session.selectOne("AdminMapper.getTotalVisitor");
	}
	//방문자수 추가
	public void addVisit() {
		int n = session.insert("AdminMapper.addVisit");
		System.out.println(n+"개의 counter 레코드 추가");
	}
	//방문자수 수정
	public void updateVisit() {
		int n = session.update("AdminMapper.updateVisit");
		System.out.println(n+"개의 counter 레코드 업데이트");
	}
	//어제 방문자수
	public int countVisitYesterday() {
		return session.selectOne("AdminMapper.countVisitYesterday");
	}
	
	//신규 주문
	public List<ProductOrderImagesDTO> selectNewOrders() {
		return session.selectList("AdminMapper.selectNewOrders");
	}
	//신규 회원
	public List<MemberDTO> selectNewMembers() {
		return session.selectList("AdminMapper.selectNewMembers");
	}
	//답변대기 문의
	public List<QuestionDTO> selectNewQuestion() {
		return session.selectList("AdminMapper.selectNewQuestion");
	}
	
	//월별 실적
	public List<HashMap<String, Object>> getMonthlySales() {
		return session.selectList("AdminMapper.getMonthlySales");
	}
	//카테고리별 판매 비율
	public List<HashMap<String, Object>> getSalesCategory() {
		return session.selectList("AdminMapper.getSalesCategory");
	}

	
	/**
	 * 회원관리
	 */
	//전체 회원 목록
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
	//전체 회원 목록 페이징 countTotal
	private int countTotalMember(HashMap<String, String> map) {
		return session.selectOne("AdminMapper.countTotalMember", map);
	}
	
	//회원 삭제
	public void deleteMember(String userid) {
		int n=session.delete("MypageMapper.deleteMember", userid);
		System.out.println("회원 삭제 : "+n);
	}
	
	//회원 정보 조회
	public MemberDTO selectMember(String userid) {
		return session.selectOne("MypageMapper.selectMember", userid);
	}
	
	//회원 배송지 목록 조회
	public List<AddressDTO> selectAllAddress(String userid) {
		return session.selectList("MypageMapper.selectAllAddress", userid);
	}
	
	//회원 정보 수정
	public void updateMember(HashMap<String, String> map) {
		int n=session.update("AdminMapper.updateMember", map);
		System.out.println("회원 수정 : "+n);
	}
	
	
	/**
	 * 상품관리
	 */
	//전체 상품 목록
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
	//전체 상품 목록 페이징 countTotal
	private int countTotalAdmin(HashMap<String, String> map) {
		return session.selectOne("AdminMapper.countTotalAdmin", map);
	}
	
	//상품 삭제
	public int deleteProduct(List<String> ids) {
		int num = session.delete("AdminMapper.deleteProduct", ids);
		System.out.println("productDelete num : "+num);
		return num;
	}
	
	//상품 삭제(이미지)
	public List<ImagesDTO> productImages(List<String> ids) {
		return session.selectList("AdminMapper.productImages", ids);
	}
	
	//상품 수정페이지(상품)
	public ProductDTO productRetrieve(int p_id) {
		return session.selectOne("AdminMapper.productRetrieve", p_id);
	}
	
	//상품 수정페이지(이미지)
	public List<ImagesDTO> ImagesRetrieve(int p_id) {
		return session.selectList("AdminMapper.ImagesRetrieve",p_id);
	}
	
	//상품 등록
	public void insertProduct(HashMap<String, String> map) {
		int num = session.insert("AdminMapper.insertProduct", map);
		System.out.println("insertProduct num : "+num);
	}
	
	//상품 수정
	public void updateProduct(HashMap<String, String> map) {
		int num = session.update("AdminMapper.updateProduct", map);
		System.out.println("updateProduct num : "+num);
	}
	
	//상품 수정(기존 이미지 삭제)
	public void deleteImages(HashMap<String, String> map) {
		int num = session.delete("AdminMapper.deleteImages", map);
		System.out.println("deleteImages num : "+num);
	}
	
	//상품 수정(새 이미지 등록)
	public void insertImages(HashMap<String, String> map) {
		int num = session.insert("AdminMapper.insertImages", map);
		System.out.println("insertImages num : "+num);
	}
	
	
	/**
	 * 주문관리
	 */
	//전체 조회
	public PageDTO selectAllOrders(HashMap<String, String> map) {
		int curPage = Integer.parseInt(map.getOrDefault("page", "1"));
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(10);
		int perPage = pDTO.getPerPage();
		int offset = (curPage-1)*perPage;
		
		List<ProductOrderImagesDTO> list = session.selectList("AdminMapper.selectAllOrders", map, new RowBounds(offset, perPage));
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(countTotalOrders(map));
		
		pDTO.setStartEndPages();
		
		return pDTO;
	}
	private int countTotalOrders(HashMap<String, String> map) {
		return session.selectOne("AdminMapper.countTotalOrders", map);
	}	
	
	//주문 상태 변경
	public void updateOrder(HashMap<String, String> map) {
		int n = session.update("AdminMapper.updateOrder", map);
		System.out.println("update된 주문 수 "+n);
	}
	
	
	/**
	 * 쿠폰관리
	 */
	
	
	
	
	/**
	 * 챌린지관리
	 */
	//이달의 챌린지 변경
	public void updateChallThisMonth(HashMap<String, Integer> map) {
		int n = session.update("AdminMapper.updateChallThisMonth", map);
		System.out.println(n+"개의 이달의 챌린지 레코드 상태 변경");
	}

	//챌린지 등록
	public void insertAdminChallenge(HashMap<String, String> map) {
		int n = session.insert("AdminMapper.insertAdminChallenge", map);
		System.out.println(n+"개의 챌린지와 도장 레코드 추가");
	}
	
	//도장 수정
	public void updateStamp(HashMap<String, String> map) {
		int n = session.update("AdminMapper.updateStamp", map);
		System.out.println("update된 도장 수 "+n);
	}

	
	/**
	 * 신고관리
	 */
	//전체 조회
	public PageDTO selectAllReport(HashMap<String, String> map) {
		int curPage = Integer.parseInt(map.getOrDefault("page", "1"));
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(10);
		int perPage = pDTO.getPerPage();
		int offset = (curPage-1)*perPage;
		
		List<ReportDTO> list = session.selectList("AdminMapper.selectAllReport", map, new RowBounds(offset, perPage));
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(countTotalReport(map));
		
		pDTO.setStartEndPages();
		
		return pDTO;
	}
	private int countTotalReport(HashMap<String, String> map) {
		return session.selectOne("AdminMapper.countTotalReport", map);
	}
		
	//신고 상세 보기
	public ReportDTO selectOneReport(String id) {
		return session.selectOne("AdminMapper.selectOneReport", id);
	}

	//신고된 댓글의 챌린지 게시글번호 구하기
	public int selectChallIdFromComment(int comment_id) {
		return session.selectOne("AdminMapper.selectChallIdFromComment", comment_id);
	}

	//신고 삭제
	public void deleteReport(List<Integer> ids) {
		int n = session.delete("AdminMapper.deleteReport", ids);
		System.out.println("delete된 신고 수 "+n);
	}

	//신고 상태 변경
	public void updateReport(HashMap<String, String> map) {
		int n = session.update("AdminMapper.updateReport", map);
		System.out.println("update된 신고 수 "+n);
	}
	
	


}
