package com.dao;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.CouponDTO;
import com.dto.CouponMemberCouponDTO;
import com.dto.PageDTO;

@Repository
public class CouponDAO {

	@Autowired
	SqlSessionTemplate session;

	public PageDTO myCoupon(Map<String, String> map) {
		int curPage = Integer.parseInt(Optional.ofNullable(map.get("page")).orElse("1"));
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(10);
		int perPage = pDTO.getPerPage();
		int offset = (curPage - 1) * perPage;
		
		List<CouponMemberCouponDTO> list = session.selectList("CouponMapper.myCoupon", map, new RowBounds(offset, perPage));
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(myCouponCount(map));
		
		pDTO.setStartEndPages();
		
		return pDTO;
	}
	
	private int myCouponCount(Map<String, String> map) {
		int num = session.selectOne("CouponMapper.myCouponCount", map);
		return num;
	}

	public PageDTO couponSelect(Map<String, String> map) {
		int curPage = Integer.parseInt(Optional.ofNullable(map.get("page")).orElse("1"));
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(10);
		int perPage = pDTO.getPerPage();
		int offset = (curPage - 1) * perPage;
		
		List<CouponDTO> list = session.selectList("CouponMapper.couponSelect", map, new RowBounds(offset, perPage));
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(couponCount(map));
		
		pDTO.setStartEndPages();
		
		return pDTO;
	}
	
	private int couponCount(Map<String, String> map) {
		int num = session.selectOne("CouponMapper.couponCount", map);
		return num;
	}

	public void couponInsert(CouponDTO dto) {
		int num = session.insert("CouponMapper.couponInsert", dto);
		System.out.println("쿠폰 추가 갯수 " + num);
	}

	public CouponDTO couponOneSelect(String coupon_id) {
		CouponDTO dto = session.selectOne("CouponMapper.couponOneSelect", coupon_id);
		return dto;
	}

	public void couponUpdate(CouponDTO dto) {
		int num = session.update("CouponMapper.couponUpdate", dto);
		System.out.println("쿠폰 수정 갯수 " + num);
	}

	public void couponDelete(String coupon_id) {
		int num = session.delete("CouponMapper.couponDelete", coupon_id);
		System.out.println("쿠폰 삭제 갯수 " + num);
	}

	public void couponAllDel(List<String> delCoupon) {
		int num = session.delete("CouponMapper.couponAllDel", delCoupon);
		System.out.println("쿠폰 삭제 갯수 " + num);
	}

	public void memberAddCoupon(String userid) {
		int num = session.insert("CouponMapper.memberAddCoupon", userid);
		System.out.println("회원가입 축하 쿠폰 지급 갯수 " + num);
	}

	public CouponDTO couponSelect(String coupon) {
		CouponDTO dto = session.selectOne("CouponMapper.couponSelect", coupon);
		return dto;
	}
	
}
