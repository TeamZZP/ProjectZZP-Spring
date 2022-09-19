package com.dao;

import java.util.List;

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
		
		pDTO.setCurPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(noticeListCount());
		
		return pDTO;
	}
	private int noticeListCount() {
		return session.selectOne("NoticeMapper.noticeListCount");
	}

}
