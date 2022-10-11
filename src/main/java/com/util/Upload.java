package com.util;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class Upload {
	//private static final String filePath = "C://eclipse//upload//";
	private static String getPath() {
		//String filePath = "C://eclipse//upload//";
		String filePath = "/upload/";
		
//		try {
//			String strIp = InetAddress.getLocalHost().getHostAddress();
//			if (strIp.equals("152.67.194.190")) {
//				filePath = "/upload/";
//			}
//		} catch (UnknownHostException e) {
//			e.printStackTrace();
//			log.error(e.getMessage());
//		}
		
		return filePath;
	}
	
	/**
	 * 파일 업로드
	 */
	public static void uploadFile(String location, CommonsMultipartFile uploadFile) {
		long size = uploadFile.getSize();
		String name= uploadFile.getName();
		String originalFileName= uploadFile.getOriginalFilename();
		String contentType= uploadFile.getContentType();
		
		System.out.println("size:  "+ size);
		System.out.println("name:  "+ name);
		System.out.println("originalFileName:  "+ originalFileName);
		System.out.println("contentType:  "+ contentType);
		
		File f= new File(getPath()+location, originalFileName);
		try {
			uploadFile.transferTo(f);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
		}
	}
	/**
	 * 파일 삭제
	 */
	public static void deleteFile(String location, String fileName) {
		Path file = Paths.get(getPath()+location+"//"+fileName);
		try {
			Files.deleteIfExists(file);
		} catch (IOException e) {
			e.printStackTrace();
			log.error(e.getMessage());
		}
	}
}
