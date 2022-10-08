package com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.AdminDAO;
import com.dao.ChallengeDAO;
import com.dto.AddressDTO;
import com.dto.ImagesDTO;
import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.dto.ProductDTO;
import com.dto.ProductOrderImagesDTO;
import com.dto.QuestionDTO;
import com.dto.ReportDTO;

@Service
public class AdminService {
	
	@Autowired
	private AdminDAO dao;
	@Autowired
	private ChallengeDAO chDao;

	/**
	 * 메인화면
	 */
	//총 판매액
	public double getTotalSales() {
		return dao.getTotalSales();
	}
	//오늘 판매액
	public double getTodaySales() {
		return dao.getTodaySales();
	}
	//총 회원
	public int getTotalMember() {
		return dao.getTotalMember();
	}
	//오늘 가입 회원
	public int getTodayMember() {
		return dao.getTodayMember();
	}
	
	//오늘 방문자
	public int countVisitToday() {
		return dao.countVisitToday();
	}
	//총 방문자
	public int getTotalVisitor() {
		return dao.getTotalVisitor();
	}
	//방문자수 추가
	public void addVisit() {
		dao.addVisit();
	}
	//방문자수 수정
	public void updateVisit() {
		dao.updateVisit();
	}
	//어제 방문자수
	public int countVisitYesterday() {
		return dao.countVisitYesterday();
	}

	//신규 주문
	public List<ProductOrderImagesDTO> selectNewOrders() {
		return dao.selectNewOrders();
	}
	//신규 회원
	public List<MemberDTO> selectNewMembers() {
		return dao.selectNewMembers();
	}
	//답변대기 문의
	public List<QuestionDTO> selectNewQuestion() {
		return dao.selectNewQuestion();
	}
	
	//월별 실적
	public List<HashMap<String, Object>> getMonthlySales() {
		return dao.getMonthlySales();
	}
	//카테고리별 판매 비율
	public List<HashMap<String, Object>> getSalesCategory() {
		return dao.getSalesCategory();
	}
	
	
	/**
	 * 회원관리
	 */
	//전체 회원 목록
	public PageDTO selectAllMember(HashMap<String, String> map) {
		return dao.selectAllMember(map);
	}
	
	//회원 삭제
	public void deleteMember(String userid) {
		dao.deleteMember(userid);
	}
	
	//회원 정보 조회
	public MemberDTO selectMember(String userid) {
		return dao.selectMember(userid);
	}
	
	//회원 배송지 목록 조회
	public List<AddressDTO> selectAllAddress(String userid) {
		return dao.selectAllAddress(userid);
	}
	
	//회원 정보 수정
	public void updateMember(HashMap<String, String> map) {
		dao.updateMember(map);
	}
	
	
	/**
	 * 상품관리
	 */
	//전체 상품 목록
		public PageDTO selectAllProduct(HashMap<String, String> map) {
			return dao.selectAllProduct(map);
	}
		
	//상품 삭제
	public int deleteProduct(List<String> ids) {
		return dao.deleteProduct(ids);
	}
	
	//상품 삭제(이미지)
	public List<ImagesDTO> productImages(List<String> ids) {
		return dao.productImages(ids);
	}
	
	//상품 수정페이지(상품)
	public ProductDTO productRetrieve(int p_id) {
		return dao.productRetrieve(p_id);
	}
	
	//상품 수정페이지(이미지)
	public List<ImagesDTO> ImagesRetrieve(int p_id) {
		return dao.ImagesRetrieve(p_id);
	}
	
	//상품 등록
	public void insertProduct(HashMap<String, String> map) {
		dao.insertProduct(map);
	}
	
	//상품관리 : 상품 수정
	@Transactional
	public void productUpdate(HashMap<String, String> map) {
		//DB 이미지 삭제
		dao.deleteImages(map);
		//DB 상품 수정
		dao.updateProduct(map);
		//DB 이미지 등록
		dao.insertImages(map);
	}


	/**
	 * 주문관리
	 */
	//전체 조회
	public PageDTO selectAllOrders(HashMap<String, String> map) {
		return dao.selectAllOrders(map);
	}
	
	//주문 상태 변경
	public void updateOrder(HashMap<String, String> map) {
		dao.updateOrder(map);
	}
	
	
	/**
	 * 쿠폰관리
	 */
	
	
	
	/**
	 * 챌린지관리
	 */
	//챌린지 등록
	@Transactional
	public void addAdminChallenge(HashMap<String, String> map) {
		//현재 진행중인 이 달의 챌린지 게시글 1=>0으로 변경
		HashMap<String, Integer> updateMap = new HashMap<String, Integer>();
		updateMap.put("before", 1);
		updateMap.put("after", 0);
		dao.updateChallThisMonth(updateMap);
		
		//챌린지 게시글 추가
		dao.insertAdminChallenge(map);
	}
	
	//챌린지 수정
	@Transactional
	public void updateAdminChallenge(HashMap<String, String> map) {
		//챌린지 업데이트
		chDao.updateChallenge(map);
		//도장 업데이트
		dao.updateStamp(map);
	}

	//챌린지 삭제
	@Transactional
	public void deleteAdminChallenge(String chall_id) {
		//챌린지 삭제
		chDao.deleteChallenge(chall_id);

		//해당 게시글을 제외하고 가장 마지막에 작성한 게시글의 chall_this_month 값 1로 설정 
		HashMap<String, Integer> updateMap = new HashMap<String, Integer>();
		updateMap.put("before", 0);
		updateMap.put("after", 1);
		dao.updateChallThisMonth(updateMap);
	}


	/**
	 * 신고관리
	 */
	//전체 조회
	public PageDTO selectAllReport(HashMap<String, String> map) {
		return dao.selectAllReport(map);
	}

	//신고 상세 보기
	public ReportDTO selectOneReport(String id) {
		return dao.selectOneReport(id);
	}

	//신고된 댓글의 챌린지 게시글번호 구하기
	public int selectChallIdFromComment(int comment_id) {
		return dao.selectChallIdFromComment(comment_id);
	}

	//신고 삭제
	public void deleteReport(List<Integer> ids) {
		dao.deleteReport(ids);
	}

	//신고 상태 변경
	public void updateReport(HashMap<String, String> map) {
		dao.updateReport(map);
	}
	

}
