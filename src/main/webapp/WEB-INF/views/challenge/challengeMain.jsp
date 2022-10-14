<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
	.paging, .liked {
		cursor: pointer;
	}
	a {
		text-decoration: none;
		color: black;
	}
	/*ZoomIn Hover Effect*/  
     .hover-zoomin a {
      display: block;
      position: relative;
      overflow: hidden;
      border-radius: 15px;
    }
    .hover-zoomin img:not(.stamp) {
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
    
    .form-select {
    	display: inline;
    	width: 150px;
    }
    
    .stamp {
    	position: absolute; 
		/* left: 198px;  
		top: -15px; */
		left: 62%;
		top: -6%; 
		width: 40%;
    }
    .challThisMonth {
    	font-weight: bold;
    	color: green;
    	margin-left: 10px;
    }
    .challThisMonth:hover {
    	font-weight: bold;
    	color: #006600;
    	margin-left: 10px;
    }
    
    .custom-tooltip {
  		--bs-tooltip-bg: var(--bs-success);
	}
	.tooltip-inner {
  		max-width: 430px;
	}
	#modalBtn{
		display: none;
	}
	.modal-body{
		text-align: center;
	}
	#mesg{
		margin: 0;
	}
</style>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- <script type="text/javascript" src="/zzp/resources/js/challenge/challengeMain.js" defer></script> -->
<script>
	$(document).ready(function () {
 		//페이징
 		$('.paging').on('click', function() {
			$('#page').val($(this).attr('data-page'));
			$('form').attr('action', 'challenge').submit();
		})
 		//정렬 기준 선택시 form 제출
		$('#sortBy').on('change', function () {
			$('form').attr('action', 'challenge').submit();
		});
		//좋아요 추가/삭제
		$('.liked_area').on('click', '.liked', function () {
			if ('${empty login}' == 'true') {
				$("#modalBtn").trigger("click");
				$("#mesg").text("로그인이 필요합니다.");
			} else {
				let cid = $(this).attr("data-cid");
				$.ajax({
					type:"post",
					url:"challenge/"+cid+"/like",
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
				url:"challenge/"+cid+"/like",
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
		
		//툴팁 활성화
		let tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
		let tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
				  			return new bootstrap.Tooltip(tooltipTriggerEl)
						})
		
	}); 
</script>


<c:set value="${pDTO.list}" var="challList" />

<form action="">
<input type="hidden" name="page" value="1" id="page">
 
<div class="container">
   <div class="row">
     <div class="col-sm-6">
       <a href="challenge/${challThisMonth.chall_id}">${challThisMonth.chall_title}
        <span class="challThisMonth">참여하러가기</span> </a> 
        <a data-bs-toggle="tooltip" data-bs-placement="top" data-bs-custom-class="custom-tooltip"
        		title="매달 바뀌는 챌린지 도전 과제에 참여해 보세요! '이 달의 챌린지' 카테고리를 선택해 챌린지 인증 사진을 올리면 예쁜 도장을 받을 수 있어요!">
        	<img src="resources/images/challenge/help.png" width="25" style="margin-top: -5px;">
        </a>
     </div>
     <div class="col-sm-6">
       <div class="float-end">
		<select name="sortBy" id="sortBy" class="form-select">
			<option selected disabled hidden>정렬</option>
			<option value="c.chall_id" <c:if test="${sortBy=='c.chall_id'}">selected</c:if>>최신순</option>
			<option value="chall_liked" <c:if test="${sortBy=='chall_liked'}">selected</c:if>>인기순</option>
			<option value="chall_comments" <c:if test="${sortBy=='chall_comments'}">selected</c:if>>댓글 많은순</option>
		</select> 
		<c:if test="${login.role != 1}">
			<a href="challenge/write" class="btn btn-outline-success" style="margin-bottom: 5px;">글쓰기</a>
		</c:if>
	   </div>
	 </div>
	 <div style="height: 10px"></div>
	 
	 
	 <c:forEach var="c" items="${challList}">
					
     <div class="col-lg-3 col-md-4 col-sm-6">
       <div class="p-3">
	       <a href="profile/${c.userid}"><img src="/upload/profile/${c.profile_img}" width="30" height="30" class="rounded-circle" onerror="this.src='resources/images/error/user.png'"></a>&nbsp;&nbsp;
	       <a href="profile/${c.userid}">${c.userid}</a><br>
       </div>
       <div class="hover-zoomin">
	       <a href="challenge/${c.chall_id}"> 
			<img src="/upload/challenge/${c.chall_img}" border="0" onerror="this.src='resources/images/error/salad.jpg'">
			<c:if test="${!empty c.stamp_img}">
				<img src="/upload/challenge/${c.stamp_img}" class="stamp">
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
	   		<a href="challenge/${c.chall_id}">${c.chall_title}</a>
	   </div>
     </div>
	</c:forEach>

	<!-- 검색기능 -->
	<div class="d-flex justify-content-center p-2">
		<select name="searchName" class="form-select p-2">
			<option selected disabled hidden>검색</option>
			<option value="c.userid" <c:if test="${searchName=='c.userid'}">selected</c:if>>아이디</option>
			<option value="chall_title" <c:if test="${searchName=='chall_title'}">selected</c:if>>제목</option>
			<option value="chall_content" <c:if test="${searchName=='chall_content'}">selected</c:if>>내용</option>
		</select>
		&nbsp;
		<input type="text" name="searchValue" class="form-control" style="width: 200px;"
			<c:if test="${!empty searchValue && searchValue!='null'}">value="${searchValue}"</c:if>>
		&nbsp;
		<button class="btn btn-outline-success">검색</button>
	</div>
		
	<!-- 페이징 -->
	  <div class="p-2 text-center">
		  <c:if test="${pDTO.prev}">
		  	<a class="paging" data-page="${pDTO.startPage-1}">prev&nbsp;&nbsp;</a>
		  </c:if>
		  <c:forEach var="p" begin="${pDTO.startPage}" end="${pDTO.endPage}">
			  <c:choose>
		  		<c:when test="${p==pDTO.page}"><b>${p}</b>&nbsp;&nbsp;</c:when>
		  		<c:otherwise><a class="paging" data-page="${p}">${p}&nbsp;&nbsp;</a></c:otherwise>
		  	  </c:choose>
		  </c:forEach>
		  <c:if test="${pDTO.next}">
		  	<a class="paging" data-page="${pDTO.endPage+1}">next</a>
		  </c:if>
	  </div>
	  
	  
   </div>
</div> 	
</form>    
    
    
  
<button id="stampBtn" type="button" data-bs-toggle="modal" data-bs-target="#stampModal" style="display: none;"></button>
 <!-- Modal -->
	<div class="modal fade" id="stampModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">도장을 획득했습니다! <${challThisMonth.stamp_name}></h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body text-center">
	      <img src="/upload/challenge/${challThisMonth.stamp_img}" width="400">
	      </div>
	      <div class="modal-footer mb-3 text-center">
	       ${challThisMonth.stamp_content}
	      </div>
	    </div>
	  </div>
	 </div>

	<script type="text/javascript">
	 if ('${empty stampMesg}'=='false') {
		 $('#stampBtn').trigger('click')
	 }
	</script>
	
	
<!-- 모달 -->
<div class="modal" id="checkVal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">ZZP</h5>
      </div>
      <div class="modal-body">
        <p id="mesg"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<button type="button" id="modalBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#checkVal">modal</button>

