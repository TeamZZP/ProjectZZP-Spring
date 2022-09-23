package com.dto;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class UploadDTO {
	
	String theText;  //uploadForm의 name과 일치 시킴 
	CommonsMultipartFile theFile;
	
	public String getTheText() {
		return theText;
	}
	public void setTheText(String theText) {
		this.theText = theText;
	}
	public CommonsMultipartFile getTheFile() {
		return theFile;
	}
	public void setTheFile(CommonsMultipartFile theFile) {
		this.theFile = theFile;
	}
	
}
