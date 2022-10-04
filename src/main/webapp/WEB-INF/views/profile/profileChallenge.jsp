<%@page import="com.dto.PageDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.dto.ChallengeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
	/*ZoomIn Hover Effect*/
     .hover-zoomin a, .img {
      display: block;
      position: relative;
      overflow: hidden;
      border-radius: 15px;
    }
    .hover-zoomin img:not(.stamp), .img {
      width: 100%;
      height: auto;
      -webkit-transition: all 0.2s ease-in-out;
      -moz-transition: all 0.2s ease-in-out;
      -o-transition: all 0.2s ease-in-out;
      -ms-transition: all 0.2s ease-in-out;
      transition: all 0.2s ease-in-out;
    }
    .hover-zoomin:hover img:not(.stamp) {
      -webkit-transform: scale(1.1);
      -moz-transform: scale(1.1);
      -o-transform: scale(1.1);
      -ms-transform: scale(1.1);
      transform: scale(1.1);
    } 
    .stamp {
    	position: absolute; 
		left: 62%;
		top: -6%; 
		width: 40%;
    }
    .img {
    	border-radius: 15px;
    }
</style>

<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		
		//무한 스크롤
		$('.skeleton').hide();
		let curPage = 1;
		let isLoading = false;
		
		function infiniteScroll() {
			let challPost = document.querySelector('.challengePost:last-child')
			
			//인터섹션 옵저버 생성
			const io = new IntersectionObserver((entry, observer)=>{
				
				const ioTarget = entry[0].target //현재 보이는 타겟
				if (entry[0].isIntersecting) { //viewport에 타켓이 보일 때
					console.log('현재 보이는 타겟', ioTarget)
					io.unobserve(challPost) //현재 보이는 타겟 감시 취소
					
					//현재 페이지가 전체 페이지와 같거나 로딩 중인 경우 아래 실행 X
					if (curPage == '${pDTO.endPage}' || isLoading) { return; }
				
					isLoading = true //로딩중 true
					$('.skeleton').show() //로딩 이미지 띄우기
					curPage++; //요청할 페이지 증가
					getList(curPage); //추가 페이지 요청 함수
					
					challPost = document.querySelector('.challengePost:last-child') 
					io.observe(challPost) //새로운 타겟 감시
				}
			}, {
				threshold: 0.8 //viewport에 타겟이 80%이상 보일 때
			})
			
			io.observe(challPost) //타겟 감시
		}
		infiniteScroll() //최초 호출
		
		function getList(curPage) { //추가 페이지 요청 함수
			console.log('inscroll '+curPage)
			$.ajax({
				type:'get',
				url:'/zzp/profile/${userid}/scrollchallenge',
				data: {
					page:curPage
				},
				dataType:'html',
				success: function (data) {
					$('.challengeAll').append(data) //응답받은 데이터 추가
					$('.skeleton').hide() //로딩 이미지 숨기기
					isLoading = false; //로딩중 false
					infiniteScroll() //다시 호출
				},
				error: function () {
					alert('문제가 발생했습니다. 다시 시도해 주세요.');
				}
			})
		}
		
		//좋아요 추가/삭제
		$('.challengeAll').on('click', '.liked', function () {
			if ('${empty login}' == 'true') {
				alert('로그인이 필요합니다.');
			} else {
				let cid = $(this).attr("data-cid");
				$.ajax({
					type:"post",
					url:"/zzp/challenge/"+cid+"/like",
					data: {
						chall_id:cid,
						userid:"${login.userid}"
					},
					dataType:"text",
					success: function (data) {
						$("#liked_area"+cid+" .liked").attr("src", data);
						countLikes(cid);
					},
					error: function () {
						alert("문제가 발생했습니다. 다시 시도해 주세요.");
					}
				}); 
			}
		});
		//좋아요 개수 구해오기
		function countLikes(cid) {
			$.ajax({
				type:"get",
				url:"/zzp/challenge/"+cid+"/like",
				data: {
					chall_id:cid
				},
				dataType:"text",
				success: function (data) {
					$("#likeNum"+cid).text(data);
				},
				error: function () {
					alert("문제가 발생했습니다. 다시 시도해 주세요.");
				}
			});
		}
	});
</script>

<div class="row p-2 mx-4 mb-2">
	<div class="col">챌린지 <span class="text-success fw-bold">${pDTO.totalCount}</span></div>
</div>

<div class="challengeAll row ms-3">

<c:forEach var="c" items="${pDTO.list}">			
     <div class="challengePost col-xl-4 col-md-6">
       <div class="p-3">
	       <a href="/zzp/profile/${c.userid}"><img src="/zzp/resources/upload/profile/${c.profile_img}" width="30" height="30"></a>&nbsp;&nbsp;
	       <a href="/zzp/profile/${c.userid}">${c.userid}</a><br>
       </div>
       <div class="hover-zoomin">
	       <a href="/zzp/challenge/${c.chall_id}"> 
			<img src="/zzp/resources/upload/challenge/${c.chall_img}" border="0" onerror="this.src='/zzp/resources/images/challenge/uploadarea.png'">
			<c:if test="${!empty c.stamp_img}">
				<img src="/zzp/resources/upload/challenge/${c.stamp_img}" class="stamp">
			</c:if>
		   </a>
	   </div>
	   <div class="p-2 text-center liked_area" id="liked_area${c.chall_id}">
	   	  <c:if test="${!empty likedList}">
	   	 	 <spring:eval var="likedIt" expression="likedList.contains(${c.chall_id})" />
	   	  </c:if>
	       <c:choose>
	   	     <%-- 해당 게시글을 현재 로그인한 회원이 좋아요했던 경우 --%>
	   	     <c:when test="${likedIt}">
	   	     	<img src="/zzp/resources/images/challenge/liked.png" width="30" height="30" class="liked" data-cid="${c.chall_id}">
	   	     </c:when>
	   	     <%-- 그외의 경우 --%>
	   	     <c:otherwise>
	   	     	<img src="/zzp/resources/images/challenge/like.png" width="30" height="30" class="liked" data-cid="${c.chall_id}">
	   	     </c:otherwise>
	   	   </c:choose>
	       <span id="likeNum${c.chall_id}">${c.chall_liked}</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   <img src="/zzp/resources/images/challenge/bubble.png" width="30" height="25"> ${c.chall_comments}
	   </div>
	   <div class="pb-5 text-center">
	   		<a href="/zzp/challenge/${c.chall_id}">${c.chall_title}</a>
	   </div>
     </div>
</c:forEach>
	

</div>

<div class="row skeleton ms-3">
  <div class="col-xl-4 col-md-6"><img class="img" src="/zzp/resources/images/challenge/none.png"></div>
  <div class="col-xl-4 col-md-6"><img class="img" src="/zzp/resources/images/challenge/none.png"></div>
  <div class="col-xl-4 col-md-6"><img class="img" src="/zzp/resources/images/challenge/none.png"></div>
</div>
