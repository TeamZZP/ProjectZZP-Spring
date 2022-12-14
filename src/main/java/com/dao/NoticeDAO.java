package com.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.NoticeDTO;
import com.dto.PageDTO;

@Repository
public class NoticeDAO {
	
	@Autowired
	SqlSessionTemplate session;

	public List<NoticeDTO> pointNotice() {
		List<NoticeDTO> list = session.selectList("NoticeMapper.pointNotice");
		return list;
	}

	public PageDTO noticePage(int curPage) {
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(10);
		int perPage = pDTO.getPerPage();
		int offset = (curPage - 1) * perPage;
		
		List<NoticeDTO> list = session.selectList("NoticeMapper.noticePage", null, new RowBounds(offset, perPage));
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(noticeListCount());
		
		pDTO.setStartEndPages();
		
		return pDTO;
	}
	private int noticeListCount() {
		return session.selectOne("NoticeMapper.noticeListCount");
	}

	public NoticeDTO noticeDelite(int notice_id) {
		NoticeDTO dto = session.selectOne("NoticeMapper.noticeDelite", notice_id);
		return dto;
	}

	public int nextNoticeID(Map<String, String> map) {
		int num = session.selectOne("NoticeMapper.nextNoticeID", map);
		return num;
	}

	public int noticeHite(Map<String, Integer> hiteMap) {
		int num = session.update("NoticeMapper.noticeHite", hiteMap);
		return num;
	}

	public void noticeInsert(NoticeDTO dto) {
		int num = session.insert("NoticeMapper.noticeInsert", dto);
		System.out.println("공지 추가 갯수 " + num);
	}

	public void noticeUpdate(NoticeDTO dto) {
		int num = session.update("NoticeMapper.noticeUpdate", dto);
		System.out.println("공지 수정 갯수 " + num);
	}

	public void noticeDelete(String notice_id) {
		int num = session.delete("NoticeMapper.noticeDelete", notice_id);
		System.out.println("공지 삭제 갯수 " + num);
	}

}
