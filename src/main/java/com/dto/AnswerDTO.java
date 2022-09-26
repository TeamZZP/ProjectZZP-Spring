package com.dto;

public class AnswerDTO {

	int answer_id; 
	String answer_content; 
	int q_id; 
	String answer_created;
	
	public AnswerDTO() {
		super();
	}

	public AnswerDTO(int answer_id, String answer_content, int q_id, String answer_created) {
		super();
		this.answer_id = answer_id;
		this.answer_content = answer_content;
		this.q_id = q_id;
		this.answer_created = answer_created;
	}

	public int getAnswer_id() {
		return answer_id;
	}

	public void setAnswer_id(int answer_id) {
		this.answer_id = answer_id;
	}

	public String getAnswer_content() {
		return answer_content;
	}

	public void setAnswer_content(String answer_content) {
		this.answer_content = answer_content;
	}

	public int getQ_id() {
		return q_id;
	}

	public void setQ_id(int q_id) {
		this.q_id = q_id;
	}

	public String getAnswer_created() {
		return answer_created;
	}

	public void setAnswer_created(String answer_created) {
		this.answer_created = answer_created;
	}

	@Override
	public String toString() {
		return "AnswerDTO [answer_id=" + answer_id + ", answer_content=" + answer_content + ", q_id=" + q_id
				+ ", answer_created=" + answer_created + "]";
	}
	
}
