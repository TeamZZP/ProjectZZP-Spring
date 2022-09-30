package com.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.dto.ChallengeDTO;
import com.dto.CommentsDTO;
import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.service.ChallengeService;

@Controller
public class ChallengeController {
	@Autowired
	private ChallengeService service;
	
	/**
	 * 챌린지 메인 화면
	 */
	@RequestMapping(value = "/challenge", method = RequestMethod.GET)
	public String main(@RequestParam HashMap<String, String> map, Model model, HttpSession session) {
		System.out.println(map);
		model.addAttribute("searchName", map.get("searchName"));
		model.addAttribute("searchValue", map.get("searchValue"));
		model.addAttribute("sortBy", map.get("sortBy"));
		
		//챌린지 전체 목록 가져오기
		PageDTO pDTO = service.selectAllChallenge(map);
		model.addAttribute("pDTO", pDTO);
		
		//현재 로그인한 회원이 좋아요 누른 게시글 가져오기
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		List<Integer> likedList = new ArrayList<Integer>();
		if (mDTO != null) {
			likedList = service.selectLikedChall(mDTO.getUserid());
		}
		model.addAttribute("likedList", likedList);
		
		//이달의 챌린지 가져오기
		ChallengeDTO challThisMonth = service.selectChallThisMonth();
		model.addAttribute("challThisMonth", challThisMonth);
		
		System.out.println(pDTO);
		 
		return "challengeMain";
	}
	/**
	 * 챌린지 상세 보기
	 */
	@RequestMapping(value = "/challenge/{chall_id}", method = RequestMethod.GET)
	public String detail(@PathVariable String chall_id, Model model, HttpSession session) {
		//조회수 +1 한 후 dto 가져오기
		service.updateChallHits(chall_id); 
		ChallengeDTO cDTO = service.selectOneChallenge(chall_id);
		model.addAttribute("cDTO", cDTO);
		System.out.println(cDTO);
		
		//현재 로그인한 회원이 해당 게시글에 좋아요를 눌렀는지 판단하기
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		if (mDTO != null) { 
			String userid = mDTO.getUserid(); 
			HashMap<String, String> likedMap = new HashMap<String, String>();
			likedMap.put("chall_id", chall_id);
			likedMap.put("userid", userid);
			int likedIt = service.countLikedByMap(likedMap);
			model.addAttribute("likedIt", likedIt);
		}
		
		return "challengeDetail";
	}
	/**
	 * 챌린지 작성 페이지
	 */
	@RequestMapping(value = "/challenge/write", method = RequestMethod.GET)
	public String write() {
		return "challengeWrite";
	}
	/**
	 * 챌린지 업로드
	 */
	@RequestMapping(value = "/challenge", method = RequestMethod.POST)
	public String upload(
			@RequestParam HashMap<String, String> map, 
			@RequestParam("chall_img") CommonsMultipartFile uploadFile) {
		String originalFileName= uploadFile.getOriginalFilename();
		String location = "C://eclipse//spring_zzp//workspace//ProjectZZP-Spring//src//main//webapp//resources//upload//challenge";
		
		uploadFile(location, uploadFile);
		
		map.put("chall_img", originalFileName);
		int n = service.insertChallenge(map);
		System.out.println("insert 개수 : "+n);
		
		return "redirect:/challenge";
	}
	private void uploadFile(String location, CommonsMultipartFile uploadFile) {
		long size = uploadFile.getSize();
		String name= uploadFile.getName();
		String originalFileName= uploadFile.getOriginalFilename();
		String contentType= uploadFile.getContentType();
		System.out.println("size:  "+ size);
		System.out.println("name:  "+ name);
		System.out.println("originalFileName:  "+ originalFileName);
		System.out.println("contentType:  "+ contentType);
		
		File f= new File(location, originalFileName);
		try {
			uploadFile.transferTo(f);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 챌린지 삭제
	 */
	@RequestMapping(value = "/challenge/{chall_id}", method = RequestMethod.DELETE)
	@ResponseBody
	public void delete(@PathVariable String chall_id) {
		String chall_img = service.selectOneChallenge(chall_id).getChall_img();
		int n = service.deleteChallenge(chall_id);
		System.out.println("delete 개수 : "+n);
		
		if (n > 0) {
			String location = "C://eclipse//spring_zzp//workspace//ProjectZZP-Spring//src//main//webapp//resources//upload//challenge";
			deleteFile(location, chall_img);
		}
	}
	private void deleteFile(String location, String fileName) {
		Path file = Paths.get(location+"//"+fileName);
		try {
			Files.deleteIfExists(file);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 챌린지 수정 페이지
	 */
	@RequestMapping(value = "/challenge/write/{chall_id}", method = RequestMethod.GET)
	public String update(@PathVariable String chall_id, Model model) {
		ChallengeDTO cDTO = service.selectOneChallenge(chall_id);
		model.addAttribute("cDTO", cDTO);
		return "challengeWrite";
	}
	/**
	 * 챌린지 수정 업로드
	 */
	@RequestMapping(value = "/challenge/{chall_id}", method = RequestMethod.POST)
	public String update(
			@PathVariable String chall_id,
			@RequestParam HashMap<String, String> map, 
			@RequestParam("chall_img") CommonsMultipartFile uploadFile) {
		String originalFileName= uploadFile.getOriginalFilename();
		String location = "C://eclipse//spring_zzp//workspace//ProjectZZP-Spring//src//main//webapp//resources//upload//challenge";
		String old_file = map.get("old_file");
		String chall_img = old_file;
		
		//사진이 바뀐 경우
		if (old_file == null || old_file.length() == 0) {
			old_file = service.selectOneChallenge(chall_id).getChall_img();
			deleteFile(location, old_file);
			uploadFile(location, uploadFile);
			
			chall_img = originalFileName;
		}
		
		map.put("chall_img", chall_img);
		int n = service.updateChallenge(map);
		System.out.println("update 개수 : "+n);
		
		return "redirect:/challenge/"+chall_id;
	}
	/**
	 * 좋아요 추가/삭제
	 */
	@RequestMapping(value = "/challenge/{chall_id}/like", method = RequestMethod.POST)
	@ResponseBody
	public String like(
			@PathVariable String chall_id, 
			@RequestParam HashMap<String, String> map) {
		return service.like(map);
	}
	/**
	 * 좋아요 개수 구하기
	 */
	@RequestMapping(value = "/challenge/{chall_id}/like", method = RequestMethod.GET)
	@ResponseBody
	public int countLiked(@PathVariable String chall_id) {
		return service.countLiked(chall_id);
	}
	/**
	 * 댓글 조회
	 */
	@RequestMapping(value = "/challenge/comment", method = RequestMethod.GET)
	public String comments(@RequestParam HashMap<String, String> map, Model model, HttpSession session) {
		//해당 게시글의 전체 댓글 목록 가져오기
		PageDTO pDTO = service.selectAllComments(map);
		model.addAttribute("pDTO", pDTO);
		
		//현재 로그인한 회원의 프로필 이미지 가져오기
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		String userid = "";
		if (mDTO != null) { 
			userid = mDTO.getUserid(); 
			String currProfile = service.selectProfileImg(userid);
			model.addAttribute("currProfile", currProfile);
		}
		
		return "challenge/comments";
	}
	
	/**
	 * 댓글 추가
	 */
	@RequestMapping(value = "/challenge/comment", method = RequestMethod.POST)
	@ResponseBody
	public int addComment(CommentsDTO dto, Model model, HttpSession session) {
		//댓글 추가 
		service.addComment(dto);
		
		//추가된 댓글의 번호 가져오기
		int comment_id = service.getNewestComment(dto.getUserid());
		System.out.println(comment_id);
		
		//해당 댓글의 페이지 구하기
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("chall_id", dto.getChall_id());
		map.put("comment_id", comment_id);
		int page = service.getCommentPage(map);
		System.out.println(page);
		
		return page;
	}
	/**
	 * 댓글 개수 구하기
	 */
	@RequestMapping(value = "/challenge/comment/count", method = RequestMethod.GET)
	@ResponseBody
	public int countComments(@RequestParam String chall_id) {
		return service.countComments(chall_id);
	}
	/**
	 * 댓글 삭제
	 */
	@RequestMapping(value = "/challenge/comment/{comment_id}", method = RequestMethod.DELETE)
	@ResponseBody
	public int deleteComment(@PathVariable String comment_id, @RequestBody CommentsDTO dto) {
		//해당 댓글의 페이지 구하기
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("chall_id", dto.getChall_id());
		map.put("comment_id", Integer.parseInt(comment_id));
		int page = service.getCommentPage(map);
		System.out.println(page);
		
		//댓글 삭제
		service.deleteComment(comment_id, String.valueOf(dto.getChall_id()));
		
		return page;
	}
	/**
	 * 댓글 수정
	 */
	@RequestMapping(value = "/challenge/comment/{comment_id}", method = RequestMethod.PUT)
	@ResponseBody
	public int updateComment(@PathVariable String comment_id, @RequestBody CommentsDTO dto) {
		//해당 댓글의 페이지 구하기
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("chall_id", dto.getChall_id());
		map.put("comment_id", Integer.parseInt(comment_id));
		int page = service.getCommentPage(map);
		System.out.println(page);
		
		//댓글 수정
		service.updateComment(dto);
		
		return page;
	}
	/**
	 * 신고 추가
	 */
	@RequestMapping(value = "/challenge/report", method = RequestMethod.POST)
	@ResponseBody
	public String report(@RequestParam HashMap<String, String> map) {
		//중복 신고 확인
		int count = service.checkReportExist(map);
		if (count == 0) {
			service.insertReport(map);
			return "true";
		} else {
			return "false";
		}
	}
	
}
