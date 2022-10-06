package com.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.ChallengeDTO;
import com.dto.ReportDTO;
import com.service.AdminService;
import com.service.ChallengeService;
import com.util.Upload;

@Controller
public class yeram {
	@Autowired
	private AdminService service;
	@Autowired
	private ChallengeService chservice;
	
	/**
	 * 챌린지 수정 업로드
	 */
	@RequestMapping(value = "/admin/challenge/{chall_id}", method = RequestMethod.POST)
	public String updateUploadChallenge(
			@PathVariable String chall_id,
			@RequestParam HashMap<String, String> map, 
			@RequestParam("chall_img") CommonsMultipartFile chall_img,
			@RequestParam("stamp_img") CommonsMultipartFile stamp_img) {
		String challOriginalFileName= chall_img.getOriginalFilename();
		String stampOriginalFileName= stamp_img.getOriginalFilename();
		String location = "C://eclipse//spring_zzp//workspace//ProjectZZP-Spring//src//main//webapp//resources//upload//challenge";
		
		String old_file = map.get("old_file");
		String old_stamp = map.get("old_stamp");
		
		//챌린지 사진이 바뀐 경우
		if (old_file == null || old_file.length() == 0) {
			old_file = chservice.selectOneChallenge(chall_id).getChall_img();
			Upload.deleteFile(location, old_file);
			Upload.uploadFile(location, chall_img);
			map.put("chall_img", challOriginalFileName);
		} else {
			map.put("chall_img", old_file);
		}
		//도장 사진이 바뀐 경우
		if (old_stamp == null || old_stamp.length() == 0) {
			old_stamp = chservice.selectOneChallenge(chall_id).getStamp_img();
			Upload.deleteFile(location, old_stamp);
			Upload.uploadFile(location, stamp_img);
			map.put("stamp_img", stampOriginalFileName);
		} else {
			map.put("stamp_img", old_stamp);
		}
		
		chservice.updateAdminChallenge(map);
		
		return "redirect:/admin/challenge/"+chall_id;
	}
	/**
	 * 챌린지 삭제
	 */
	@RequestMapping(value = "/admin/challenge/{chall_id}", method = RequestMethod.DELETE)
	@ResponseBody
	public void deleteChallenge(@PathVariable String chall_id, RedirectAttributes rttr) {
		//관리자가 작성한 이달의 챌린지 개수 가져오기
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", "admin1");
		int challNum = chservice.countTotalUserChallenge(map);
		
		//유일한 이달의 챌린지 게시글인 경우 삭제 불가
		if (challNum == 1) {
			rttr.addFlashAttribute("mesg", "다른 챌린지 게시글을 작성한 후 삭제 가능합니다.");
		} else {
			String location = "C://eclipse//spring_zzp//workspace//ProjectZZP-Spring//src//main//webapp//resources//upload//challenge";
			ChallengeDTO dto = chservice.selectOneChallenge(chall_id);
			Upload.deleteFile(location, dto.getChall_img());
			Upload.deleteFile(location, dto.getStamp_img());
			chservice.deleteAdminChallenge(chall_id);
		}
	}
	
	/**
	 * 주문관리 : 주문 상태 변경
	 */
	@RequestMapping(value = "/admin/order/{id}", method = RequestMethod.PUT)
	@ResponseBody
	public void updateOrder(@PathVariable String id, @RequestBody HashMap<String, String> map) {
		System.out.println(map);
		chservice.updateOrder(map);
	}
	
	/**
	 * 신고관리 : 신고 상세 보기
	 */
	@RequestMapping(value = "/admin/report/{id}", method = RequestMethod.GET)
	public String detailReport(@PathVariable String id) {
		ReportDTO dto = chservice.selectOneReport(id);
		String url = null;
		
		//신고된 글이 게시글인 경우 - 해당 게시글로 이동
		if (dto.getChall_id() != 0) {
			url = "/challenge/"+dto.getChall_id();
			
		//신고된 글이 댓글인 경우 - 해당 게시글의 해당 댓글 위치로 이동
		} else {
			int chall_id = chservice.selectChallIdFromComment(dto.getComment_id());
			url = "/challenge/"+chall_id+"#commentTime"+dto.getComment_id();
			
		}
		return "redirect:"+url;
	}
}
