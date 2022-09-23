package com.dto;

import org.apache.ibatis.type.Alias;

@Alias("QuestionDTO")
public class QuestionDTO {

	int q_id; 
	int q_board_category;
    String q_category; 
    String q_title;
    String q_content; 
    String q_created; 
    String q_img; 
    String q_status;
    String userid;
    String p_id; 
    
	public QuestionDTO() {
		super();
	}

	public QuestionDTO(int q_id, int q_board_category, String q_category, String q_title, String q_content,
			String q_created, String q_img, String q_status, String userid, String p_id) {
		super();
		this.q_id = q_id;
		this.q_board_category = q_board_category;
		this.q_category = q_category;
		this.q_title = q_title;
		this.q_content = q_content;
		this.q_created = q_created;
		this.q_img = q_img;
		this.q_status = q_status;
		this.userid = userid;
		this.p_id = p_id;
	}

	public int getQ_id() {
		return q_id;
	}

	public void setQ_id(int q_id) {
		this.q_id = q_id;
	}

	public int getQ_board_category() {
		return q_board_category;
	}

	public void setQ_board_category(int q_board_category) {
		this.q_board_category = q_board_category;
	}

	public String getQ_category() {
		return q_category;
	}

	public void setQ_category(String q_category) {
		this.q_category = q_category;
	}

	public String getQ_title() {
		return q_title;
	}

	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}

	public String getQ_content() {
		return q_content;
	}

	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}

	public String getQ_created() {
		return q_created;
	}

	public void setQ_created(String q_created) {
		this.q_created = q_created;
	}

	public String getQ_img() {
		return q_img;
	}

	public void setQ_img(String q_img) {
		this.q_img = q_img;
	}

	public String getQ_status() {
		return q_status;
	}

	public void setQ_status(String q_status) {
		this.q_status = q_status;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getP_id() {
		return p_id;
	}

	public void setP_id(String p_id) {
		this.p_id = p_id;
	}

	@Override
	public String toString() {
		return "QuestionDTO [q_id=" + q_id + ", q_board_category=" + q_board_category + ", q_category=" + q_category
				+ ", q_title=" + q_title + ", q_content=" + q_content + ", q_created=" + q_created + ", q_img=" + q_img
				+ ", q_status=" + q_status + ", userid=" + userid + ", p_id=" + p_id + "]";
	}
	
}
