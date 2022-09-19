package com.dto;

import java.util.List;

public class PageDTO {
	private List list;   // 현재페이지에 들어갈 레코드를 perPage만큼만 저장 
	private int curPage;    //현재 볼 페이지 번호 
	private int perPage;  //한페이지에 보여질 목록 수 
	private int totalCount; //전체 레코드 갯수
	
	public PageDTO() {
		super();
	}
	
	public PageDTO(List list, int curPage, int perPage, int totalCount) {
		super();
		this.list = list;
		this.curPage = curPage;
		this.perPage = perPage;
		this.totalCount = totalCount;
	}
	
	public List getList() {
		return list;
	}
	public void setList(List list) {
		this.list = list;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getPerPage() {
		return perPage;
	}
	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	@Override
	public String toString() {
		return "PageDTO [list=" + list + ", curPage=" + curPage + ", perPage=" + perPage + ", totalCount=" + totalCount
				+ "]";
	}

}
