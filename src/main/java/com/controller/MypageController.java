package com.controller;


import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.AddressDTO;
import com.dto.CartDTO;
import com.dto.MemberCouponDTO;
import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.dto.ProfileDTO;
import com.dto.ReviewDTO;
import com.service.AnswerService;
import com.service.CartService;
import com.service.ChallengeService;
import com.service.CouponService;
import com.service.MypageService;
import com.service.OrderService;
import com.service.QuestionService;
import com.service.ReviewService;
import com.util.Upload;


@Controller
public class MypageController {
	@Autowired
	MypageService service;
	@Autowired
	QuestionService qService;
	@Autowired
	ReviewService rService;
	@Autowired
	AnswerService aService;
	@Autowired
	OrderService oService;
	@Autowired
	CouponService cService;
	@Autowired
	ChallengeService chService;
	
	/**
	 * 마이페이지 메인
	 */
	@RequestMapping(value = "/mypage/{userid}", method = RequestMethod.GET)
	public ModelAndView mypage(@PathVariable("userid") String userid) {
		//interceptor 인증 후
		System.out.println("마이페이지 메인 userid : "+userid);
		ProfileDTO profile=service.selectProfile(userid);
		System.out.println("프로필 >>> "+profile);
		//review, member_coupon, member_stamp, challenge
		int myReview=service.countReview(userid);
		int myCoupon=service.countCoupon(userid);
		int myStamp=service.countStamp(userid);
		int myChallenge=service.countChallenge(userid);
		//System.out.println("리뷰:"+myReview+" 쿠폰:"+myCoupon+" 스탬프:"+myStamp+" 챌린지:"+myChallenge);
		
		HashMap<String, Integer> map=new HashMap<String, Integer>();
		map.put("myReview", myReview);
		map.put("myCoupon", myCoupon);
		map.put("myStamp", myStamp);
		map.put("myChallenge", myChallenge);
		System.out.println("map>>>"+map);
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("profile", profile);
		mav.addObject("map", map);
		mav.setViewName("mypage");//mypage.jsp 요청
		return mav;
	}
	/**
	 * 마이페이지 계정 인증//=>(RequestParam 속성을 필수가 아니도록 하고, 파라미터가 있으면 탈퇴, 없으면 계정 수정)=>url 수정하는 방법으로 진행
	 */
	@RequestMapping(value = "/mypage/{userid}/check", method = RequestMethod.GET)
	public String accountCheck() {
		//interceptor 인증 후
		System.out.println("계정 인증");
		return "checkAccount";
	}
	/**
	 * 마이페이지 계정 삭제 인증//=>url 수정, method get으로 수정하기(폼 제출 불필요, 링크로 이동)
	 */
	@RequestMapping(value = "/mypage/{userid}/quit", method = RequestMethod.GET)
	public String deleteCheck(Model model) {
		//interceptor 인증 후
		System.out.println("계정 삭제 인증");
		model.addAttribute("accountDelete", "quit");
		return "checkAccount";
	}
	/**
	 * 마이페이지 계정관리
	 */
	@RequestMapping(value = "/mypage/{userid}/user", method = RequestMethod.POST)
	//@ResponseBody
	public String myAccount(@PathVariable("userid") String userid, Model model) {
		//interceptor 인증 후
		System.out.println("계정 관리 userid : "+userid);
		
		//회원 기본 배송지
		AddressDTO address=service.selectDefaultAddress(userid);
		System.out.println(address);
		
		//ModelAndView mav=new ModelAndView();
		//mav.addObject("address", address);
		//mav.setViewName("accountForm");//accountForm.jsp 요청
		model.addAttribute("address", address);
		return "accountForm";
	}
	/**
	 * 마이페이지 회원 정보 수정
	 */
	@RequestMapping(value = "/mypage/{userid}/user", method = RequestMethod.PUT)
	public String updateAccount(@PathVariable("userid") String userid, MemberDTO member,
			AddressDTO address, String changedPasswd, HttpSession session, RedirectAttributes m) {
		//interceptor 인증 후
		System.out.println("계정 수정 userid : "+userid);
		
		HashMap<String, Object> map=new HashMap<String, Object>();
		if (changedPasswd.length() != 0) {
			System.out.println("비밀번호 변경");
			map.put("changedPasswd", changedPasswd);
		}
		map.put("userid", userid);
		map.put("email1", member.getEmail1());
		map.put("email2", member.getEmail2());
		map.put("address_id", address.getAddress_id());
		map.put("post_num", address.getPost_num());
		map.put("addr1", address.getAddr1());
		map.put("addr2", address.getAddr2());
		System.out.println(map);
		service.updateAccount(map);
		
		//업데이트 회원 정보
		MemberDTO dto=service.selectMember(userid);
		System.out.println(dto);
		session.setAttribute("login", dto);
		m.addFlashAttribute("mesg", "회원 정보가 수정되었습니다.");
		return "redirect:/mypage/"+userid;
	}
	/**
	 * 마이페이지 회원 계정 삭제
	 */
	@RequestMapping(value = "/mypage/{userid}/user", method = RequestMethod.DELETE)
	public String accountDelete(@PathVariable("userid") String userid, HttpSession session, RedirectAttributes m) {
		//interceptor 인증 후
		System.out.println("계정 삭제 userid : "+userid);
		service.accountDelete(userid);
		session.invalidate();
		m.addFlashAttribute("mesg", "회원 탙퇴가 완료되었습니다.");
		return "redirect:/";
	}
	/**
	 * 마이페이지 배송지 관리
	 */
	@RequestMapping(value = "/mypage/{userid}/address", method = RequestMethod.GET)
	public ModelAndView addressList(@PathVariable("userid") String userid) {
		//interceptor 인증 후
		System.out.println("배송지 관리 userid : "+userid);
		
		//회원 배송지 목록
		List<AddressDTO> addressList=service.selectAllAddress(userid);
		ModelAndView mav=new ModelAndView();
		mav.addObject("addressList", addressList);
		mav.setViewName("addressList");
		return mav;
	}
	/**
	 * 마이페이지 배송지 추가 폼
	 */
	@RequestMapping(value = "/mypage/address", method = RequestMethod.GET)
	public String addressForm() {
		//interceptor 인증 후
		System.out.println("배송지 추가 폼");
		return "addressForm";
	}
	/**
	 * 마이페이지 배송지 수정 폼//=>url에 address id 추가하고 get 요청으로 수정, 같은 jsp 출력
	 */
	@RequestMapping(value = "/mypage/address/{address_id}", method = RequestMethod.GET)
	public String addressUpdateForm(@PathVariable("address_id") String address_id, Model model) {
		//interceptor 인증 후
		System.out.println("배송지 수정 폼 : "+address_id);
		//int?
		AddressDTO address=service.selectAddress(address_id);
		System.out.println("address 출력>>>"+address);
		model.addAttribute("address", address);
		return "addressForm";
	}
	/**
	 * 마이페이지 배송지 추가
	 */
	@RequestMapping(value = "/mypage/{userid}/address", method = RequestMethod.POST)
	public String addAddress(@PathVariable("userid") String userid, AddressDTO address,
			String chk, RedirectAttributes m) {
		//interceptor 인증 후
		System.out.println("배송지 추가 "+address);
		System.out.println("기본 배송지 : "+chk);//체크하면 on//체크 안 하면 null
		
		if (chk == null) {
			System.out.println("기본 배송지 아님");
			service.addAddress(address);
		} else {
			System.out.println("기본 배송지 체크");
			address.setDefault_chk(1);
			//기존 기본 배송지의 default_chk=0으로 변경
			service.changeNotDefaultAddress(userid);
			
			service.addAddress(address);
		}
		
		m.addFlashAttribute("mesg", "배송지가 추가되었습니다.");
		return "redirect:/mypage/"+userid+"/address";
	}
	/**
	 * 마이페이지 배송지 삭제
	 */
	@RequestMapping(value = "/mypage/{userid}/address", method = RequestMethod.DELETE)
	@ResponseBody
	public int deleteAddress(@RequestBody HashMap<String, String> map,
			@PathVariable("userid") String userid) {//@RequestBody 없으면 null 출력
		//interceptor 인증 후
		System.out.println("배송지 삭제 : "+map);
		String id=map.get("address_id");
		int address_id=Integer.parseInt(id);
		service.deleteAddress(address_id);
		List<AddressDTO> list=service.selectAllAddress(userid);
		int size=list.size();
		return size;
	}
	/**
	 * 마이페이지 배송지 수정
	 */
	@RequestMapping(value = "/mypage/{userid}/address", method = RequestMethod.PUT)
	public String updateAddress(String addressId, AddressDTO address,
			String chk, RedirectAttributes m) {
		//interceptor 인증 후
		System.out.println("배송지 수정 address_id : "+addressId);
		System.out.println("기본 배송지 : "+chk);//체크하면 on//체크 안 하면 null
		String userid=address.getUserid();
		
		if (chk != null) {
			System.out.println("기본 배송지 체크");
			address.setDefault_chk(1);
			//기존 기본 배송지의 default_chk=0으로 변경
			service.changeNotDefaultAddress(userid);
		}
		
		int id=Integer.parseInt(addressId);
		address.setAddress_id(id);
		System.out.println(address);
		service.updateAddress(address);
		
		m.addFlashAttribute("mesg", "배송지가 수정되었습니다.");
		return "redirect:/mypage/"+userid+"/address";
	}
	/**
	 * 마이페이지 내 문의 글
	 */
	@RequestMapping(value = "/mypage/{userid}/question", method = RequestMethod.GET)
	public String myQuestion(@PathVariable String userid, @RequestParam Map<String, String> map, Model m, HttpSession session) {
		PageDTO pDTO =  qService.myQuestion(userid, map);
		System.out.println("내 문의 게시글 " + pDTO);
		
		m.addAttribute("orderList", pDTO);
		m.addAttribute("mDTO", session.getAttribute("login"));
		
		return "myQuestion";
	}
	/**
	 * 마이페이지 내 리뷰 내역
	 */
	@RequestMapping(value = "/mypage/{userid}/review", method = RequestMethod.GET)
	public String myReview(@PathVariable String userid, 
			@RequestParam Map<String, String> map, Model m, HttpSession session) {
		PageDTO pDTO = rService.myReview(userid, map);
		System.out.println("내 리뷰 내역 " + pDTO);
		
		m.addAttribute("myReview", pDTO);
		m.addAttribute("mDTO", session.getAttribute("login"));
		
		return "myReview";
	}
	/**
	 * 마이페이지 내 구매내역
	 */
	@RequestMapping(value = "/mypage/{userid}/order", method = RequestMethod.GET)
	public String myOrder(@PathVariable String userid, 
			@RequestParam Map<String, String> map, Model m, HttpSession session) {
		map.put("userid", userid);
		System.out.println(map);
		
		PageDTO pDTO = oService.myOrder(map);
		System.out.println("내 주문 내역 " + pDTO);
		
		m.addAttribute("myOrder", pDTO);
		m.addAttribute("search", map);
		m.addAttribute("mDTO", session.getAttribute("login"));
		return "myOrder";
	}
	/**
	 * 마이페이지 리뷰 작성 여부 확인 ajax
	 */
	@RequestMapping(value = "/orders/review", method = RequestMethod.POST)
	public @ResponseBody int reviewCheck(@RequestParam Map<String,String> map) {
		System.out.println(map);
		ReviewDTO dto = rService.reviewCheck(map);
		System.out.println("리뷰 작성 여부 " + dto);
		
		int review_id = 0;
		if (dto != null) {
			review_id = dto.getReview_id();
		} else {
			review_id = 0;
		}
		return review_id;
	}
	/**
	 * 마이페이지 내 쿠폰함
	 */
	@RequestMapping(value = "/mypage/{userid}/coupon", method = RequestMethod.GET)
	public String myCoupon(@PathVariable String userid,
			@RequestParam Map<String, String> map, Model m, HttpSession session) {
		map.put("userid", userid);
		System.out.println(map);
		System.out.println("페이지, 검색어, 유저아이디 " + map);
		
		PageDTO pDTO = cService.myCoupon(map);
		System.out.println("내 쿠폰 내역 " + pDTO);
		
		m.addAttribute("myCoupon", pDTO);
		m.addAttribute("search", map);
		m.addAttribute("mDTO", session.getAttribute("login"));
		return "myCoupon";
	}
	/**
	 * 마이페이지 내 챌린지
	 */
	@RequestMapping(value = "/mypage/{userid}/challenge", method = RequestMethod.GET)
	public String myChallenge(
			@PathVariable String userid, 
			@RequestParam HashMap<String, String> map,
			Model model,
			HttpSession session) {
		//회원의 챌린지 목록 가져오기
		map.put("userid", userid);
		PageDTO pDTO = chService.selectChallengeByUserid(map, 6);
		model.addAttribute("pDTO", pDTO);
		
		//회원이 좋아요 누른 게시글 가져오기
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		List<Integer> likedList = new ArrayList<Integer>();
		if (mDTO != null) {
			likedList = chService.selectLikedChall(mDTO.getUserid());
		}
		model.addAttribute("likedList", likedList);
		
		return "myChallenge";
	}
	/**
	 * 마이페이지 내 도장
	 */
	@RequestMapping(value = "/mypage/{userid}/stamp", method = RequestMethod.GET)
	public String myStamp(
			@PathVariable String userid, 
			@RequestParam HashMap<String, String> map,
			Model model) {
		//회원의 도장 목록 가져오기
		map.put("userid", userid);
		PageDTO pDTO = chService.selectMemberStampByUserid(map, 6);
		model.addAttribute("pDTO", pDTO);
		
		//전체 도장 개수
		int stampTotalNum = chService.countTotalStamp(map);
		model.addAttribute("stampTotalNum", stampTotalNum);
		
		return "myStamp";
	}
	/**
	 * 마이페이지 프로필 수정
	 */
	@RequestMapping(value = "/mypage/{userid}/profile", method = RequestMethod.POST)
	public String updateProfile(@PathVariable("userid") String userid,
			@RequestParam HashMap<String, String> map,//모든 name, value 값을 map으로 받아옴
			@RequestParam("imgFile") CommonsMultipartFile uploadFile,
			RedirectAttributes m) {
		System.out.println(userid+" 프로필 수정 "+map);
		String originalFileName= uploadFile.getOriginalFilename();//업로드 한 파일명
		String old_file=map.get("old_file");//기존 파일
		String profile_txt=map.get("profile_txt");
		String profile_img="";
		System.out.println(
				"uploadFile : "+uploadFile
				+" originalFileName : "+originalFileName
				+" oldfile : "+old_file
				+" profile_txt : "+profile_txt);
		//업로드 파일 저장 location
//		String location = "C://eclipse//spring_zzp//workspace//ProjectZZP-Spring//src//main//webapp//resources//upload//profile";
		String location = "profile";
		
		if (originalFileName==null || originalFileName.length()==0) {//파일 업로드가 없는 경우
			//이미지 변경 없음
			profile_img=old_file;//기존 파일을 그대로 유지
		} else {
			//이미지 변경
			profile_img=originalFileName;//새로운 파일로 변경
//			uploadFile(location, uploadFile);//해당 위치에 파일을 업로드
			Upload.uploadFile(location, uploadFile);
			if (!old_file.equals("user.png")) {//기존 이미지가 기본 설정이 아닌 경우--삭제
//				deleteFile(location, old_file);
				Upload.deleteFile(location, old_file);
			}
		}
		map.put("userid", userid);
		map.put("profile_img", profile_img);//파일명을 map 저장
		map.put("profile_txt", profile_txt);
		System.out.println("업데이트 map >>> "+map);
		service.updateProfile(map);
		ProfileDTO profile=service.selectProfile(userid);
		m.addFlashAttribute("profile", profile);//유무 상관없이 랜덤으로 이미지 엑박 문제 발생
		m.addFlashAttribute("mesg", "프로필이 수정되었습니다.");
		return "redirect:/mypage/"+userid;
	}
/*	private void uploadFile(String location, CommonsMultipartFile uploadFile) {
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
	private void deleteFile(String location, String fileName) {
		Path file = Paths.get(location+"//"+fileName);
		try {
			Files.deleteIfExists(file);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}	*/

}
