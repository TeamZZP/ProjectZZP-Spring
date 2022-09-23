package com.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	public String challengeMain(@RequestParam HashMap<String, String> map, Model model, HttpSession session) {
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
		
		return "challengeMain";
	}
	/**
	 * 챌린지 상세 보기
	 */
	@RequestMapping(value = "/challenge/{chall_id}", method = RequestMethod.GET)
	public String challengeDetail(@PathVariable String chall_id, Model model, HttpSession session) {
		//조회수 +1 한 후 dto 가져오기
		service.updateChallHits(chall_id); 
		ChallengeDTO cDTO = service.selectOneChallenge(chall_id);
		model.addAttribute("cDTO", cDTO);
		System.out.println(cDTO);
		
		//해당 게시글의 전체 댓글 목록 가져오기
		List<CommentsDTO> commentsList = service.selectAllComments(chall_id);
		model.addAttribute("commentsList", commentsList);
		//대댓글 위해 Map으로 따로 저장
		HashMap<Integer, String> parentMap = new HashMap<Integer, String>();
		for (CommentsDTO c : commentsList) {
			parentMap.put(c.getComment_id(), c.getUserid());
		}
		model.addAttribute("parentMap", parentMap);
		
		//현재 로그인한 회원의 프로필 이미지 가져오기
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		String userid = "";
		if (mDTO != null) { userid = mDTO.getUserid(); }
		String currProfile = service.selectProfileImg(userid);
		model.addAttribute("currProfile", currProfile);
		
		//현재 로그인한 회원이 해당 게시글에 좋아요를 눌렀는지 판단하기
		HashMap<String, String> likedMap = new HashMap<String, String>();
		likedMap.put("chall_id", chall_id);
		likedMap.put("userid", userid);
		int likedIt = service.countLikedByMap(likedMap);
		model.addAttribute("likedIt", likedIt);
		
		return "challengeDetail";
	}
	/**
	 * 챌린지 작성 페이지
	 */
	@RequestMapping(value = "/challenge/write", method = RequestMethod.GET)
	public String challengeWrite() {
		return "challengeWrite";
	}
	/**
	 * 챌린지 업로드
	 */
	@RequestMapping(value = "/challenge", method = RequestMethod.POST)
	public String challengeUpload(
			@RequestParam HashMap<String, String> map, 
			@RequestParam("chall_img") CommonsMultipartFile uploadFile) {
		
		long size = uploadFile.getSize();
		String name= uploadFile.getName();
		String originalFileName= uploadFile.getOriginalFilename();
		String contentType= uploadFile.getContentType();
		System.out.println("size:  "+ size);
		System.out.println("name:  "+ name);
		System.out.println("originalFileName:  "+ originalFileName);
		System.out.println("contentType:  "+ contentType);
		
		String location = "C://eclipse//spring_zzp//workspace//ProjectZZP-Spring//src//main//webapp//resources//upload//challenge";
		
		File f= new File(location, originalFileName);
		try {
			uploadFile.transferTo(f);
		} catch (Exception e) {
			e.printStackTrace();
		}
		map.put("chall_img", originalFileName);
		
		int n = service.insertChallenge(map);
		System.out.println("insert 개수 : "+n);
		
		return "redirect:/challenge";
	}

}
