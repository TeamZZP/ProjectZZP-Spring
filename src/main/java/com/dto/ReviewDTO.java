package com.dto;

import org.apache.ibatis.type.Alias;

@Alias("ReviewDTO")
public class ReviewDTO {
	
	String userid;
	int p_id;
	int order_id;
	int review_id; 
	String review_title; 
	String review_content; 
	String review_rate; 
	String review_img; 
	String review_created; 
	
	public ReviewDTO() {
		super();
	}

	public ReviewDTO(String userid, int p_id, int order_id, int review_id, String review_title, String review_content,
			String review_rate, String review_img, String review_created) {
		super();
		this.userid = userid;
		this.p_id = p_id;
		this.order_id = order_id;
		this.review_id = review_id;
		this.review_title = review_title;
		this.review_content = review_content;
		this.review_rate = review_rate;
		this.review_img = review_img;
		this.review_created = review_created;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getP_id() {
		return p_id;
	}

	public void setP_id(int p_id) {
		this.p_id = p_id;
	}

	public int getOrder_id() {
		return order_id;
	}

	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}

	public int getReview_id() {
		return review_id;
	}

	public void setReview_id(int review_id) {
		this.review_id = review_id;
	}

	public String getReview_title() {
		return review_title;
	}

	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public String getReview_rate() {
		return review_rate;
	}

	public void setReview_rate(String review_rate) {
		this.review_rate = review_rate;
	}

	public String getReview_img() {
		return review_img;
	}

	public void setReview_img(String review_img) {
		this.review_img = review_img;
	}

	public String getReview_created() {
		return review_created;
	}

	public void setReview_created(String review_created) {
		this.review_created = review_created;
	}

	@Override
	public String toString() {
		return "ReviewDTO [userid=" + userid + ", p_id=" + p_id + ", order_id=" + order_id + ", review_id=" + review_id
				+ ", review_title=" + review_title + ", review_content=" + review_content + ", review_rate="
				+ review_rate + ", review_img=" + review_img + ", review_created=" + review_created + "]";
	}

}
