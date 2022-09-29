package com.dto;

import org.apache.ibatis.type.Alias;

@Alias("ReviewProductDTO")
public class ReviewProductDTO {

	private String userid;
	private int p_id;
	private int order_id;
	private int review_id; 
	private String review_title; 
	private String review_content; 
	private String review_rate; 
	private String review_img; 
	private String review_create; 
	private String p_name;
	private String p_content;
	private int c_id;
	private int p_cost_price;
	private int p_selling_price;
	private int p_discount;
	private String p_created;
	private int p_stock;
	
	public ReviewProductDTO() {
		super();
	}

	public ReviewProductDTO(String userid, int p_id, int order_id, int review_id, String review_title,
			String review_content, String review_rate, String review_img, String review_create, String p_name,
			String p_content, int c_id, int p_cost_price, int p_selling_price, int p_discount, String p_created,
			int p_stock) {
		super();
		this.userid = userid;
		this.p_id = p_id;
		this.order_id = order_id;
		this.review_id = review_id;
		this.review_title = review_title;
		this.review_content = review_content;
		this.review_rate = review_rate;
		this.review_img = review_img;
		this.review_create = review_create;
		this.p_name = p_name;
		this.p_content = p_content;
		this.c_id = c_id;
		this.p_cost_price = p_cost_price;
		this.p_selling_price = p_selling_price;
		this.p_discount = p_discount;
		this.p_created = p_created;
		this.p_stock = p_stock;
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

	public String getReview_create() {
		return review_create;
	}

	public void setReview_create(String review_create) {
		this.review_create = review_create;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public String getP_content() {
		return p_content;
	}

	public void setP_content(String p_content) {
		this.p_content = p_content;
	}

	public int getC_id() {
		return c_id;
	}

	public void setC_id(int c_id) {
		this.c_id = c_id;
	}

	public int getP_cost_price() {
		return p_cost_price;
	}

	public void setP_cost_price(int p_cost_price) {
		this.p_cost_price = p_cost_price;
	}

	public int getP_selling_price() {
		return p_selling_price;
	}

	public void setP_selling_price(int p_selling_price) {
		this.p_selling_price = p_selling_price;
	}

	public int getP_discount() {
		return p_discount;
	}

	public void setP_discount(int p_discount) {
		this.p_discount = p_discount;
	}

	public String getP_created() {
		return p_created;
	}

	public void setP_created(String p_created) {
		this.p_created = p_created;
	}

	public int getP_stock() {
		return p_stock;
	}

	public void setP_stock(int p_stock) {
		this.p_stock = p_stock;
	}

	@Override
	public String toString() {
		return "ReviewProductDTO [userid=" + userid + ", p_id=" + p_id + ", order_id=" + order_id + ", review_id="
				+ review_id + ", review_title=" + review_title + ", review_content=" + review_content + ", review_rate="
				+ review_rate + ", review_img=" + review_img + ", review_create=" + review_create + ", p_name=" + p_name
				+ ", p_content=" + p_content + ", c_id=" + c_id + ", p_cost_price=" + p_cost_price
				+ ", p_selling_price=" + p_selling_price + ", p_discount=" + p_discount + ", p_created=" + p_created
				+ ", p_stock=" + p_stock + "]";
	}
	
}
