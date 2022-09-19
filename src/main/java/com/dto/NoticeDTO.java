package com.dto;

import org.apache.ibatis.type.Alias;

@Alias("NoticeDTO")
public class NoticeDTO {

	int notice_id; 
	String notice_tittle; 
	String notice_content;
	String notice_created; 
	String userid; 
	String notice_category; 
	int notice_hits; 
	
	public NoticeDTO() {
		super();
	}

	public NoticeDTO(int notice_id, String notice_tittle, String notice_content, String notice_created, String userid,
			String notice_category, int notice_hits) {
		super();
		this.notice_id = notice_id;
		this.notice_tittle = notice_tittle;
		this.notice_content = notice_content;
		this.notice_created = notice_created;
		this.userid = userid;
		this.notice_category = notice_category;
		this.notice_hits = notice_hits;
	}

	public int getNotice_id() {
		return notice_id;
	}

	public void setNotice_id(int notice_id) {
		this.notice_id = notice_id;
	}

	public String getNotice_tittle() {
		return notice_tittle;
	}

	public void setNotice_tittle(String notice_tittle) {
		this.notice_tittle = notice_tittle;
	}

	public String getNotice_content() {
		return notice_content;
	}

	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}

	public String getNotice_created() {
		return notice_created;
	}

	public void setNotice_created(String notice_created) {
		this.notice_created = notice_created;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getNotice_category() {
		return notice_category;
	}

	public void setNotice_category(String notice_category) {
		this.notice_category = notice_category;
	}

	public int getNotice_hits() {
		return notice_hits;
	}

	public void setNotice_hits(int notice_hits) {
		this.notice_hits = notice_hits;
	}

	@Override
	public String toString() {
		return "NoticeDTO [notice_id=" + notice_id + ", notice_tittle=" + notice_tittle + ", notice_content="
				+ notice_content + ", notice_created=" + notice_created + ", userid=" + userid + ", notice_category="
				+ notice_category + ", notice_hits=" + notice_hits + "]";
	}

}
