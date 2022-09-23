<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
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
</style>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="resources/js/challenge/challengeMain.js"></script>
<c:set value="${pDTO.list}" var="challList" />

<form action="">
<div class="container">
   <div class="row">
     <div class="col-sm-6">
       <a href="challenge/${challThisMonth.chall_id}">${challThisMonth.chall_title}
        <span class="challThisMonth">참여하러가기</span> </a> 
        <a data-bs-toggle="tooltip" data-bs-placement="top" data-bs-custom-class="custom-tooltip"
        		title="매달 바뀌는 챌린지 도전 과제에 참여해 보세요! '이 달의 챌린지' 카테고리를 선택해 챌린지 인증 사진을 올려주세요. 참여시 받을 수 있는 예쁜 도장을 모아보세요!">
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
		<a href="challenge/write" class="btn btn-outline-success" style="margin-bottom: 5px;">글쓰기</a>
	   </div>
	 </div>
	 <div style="height: 10px"></div>
	 
	 
	 <c:forEach var="c" items="${challList}">
					
     <div class="col-lg-3 col-md-4 col-sm-6">
       <div class="p-3">
	       <a href="profile/${c.userid}"><img src="resources/upload/profile/${c.profile_img}" width="30" height="30"></a>&nbsp;&nbsp;
	       <a href="profile/${c.userid}">${c.userid}</a><br>
       </div>
       <div class="hover-zoomin">
	       <a href="challenge/${c.chall_id}"> 
			<img src="resources/upload/challenge/${c.chall_img}" border="0" onerror="this.src='resources/images/challenge/uploadarea.png'">
			<c:if test="${!empty c.stamp_img}">
				<img src="resources/upload/challenge/${c.stamp_img}" class="stamp">
			</c:if>
		   </a>
	   </div>
	   <div class="p-2 text-center liked_area" id="liked_area${c.chall_id}">
	   	   <!-- 해당 게시글을 현재 로그인한 회원이 좋아요했던 경우 -->
	   	   <%-- <c:set var="likedList" value="${likedList}" /> --%>
	   	   <%-- <c:if test="${fn:contains(likedList, '${c.chall_id}')}"></c:if>
	   	   <% if (resultLikedMap.containsKey(chall_id)) { %>
	   	   <img src="images/liked.png" width="30" height="30" class="liked" data-cid="${c.chall_id}">
	   	   <!-- 그외의 경우 -->
	   	   <% } else { %>
	       <img src="images/like.png" width="30" height="30" class="liked" data-cid="${c.chall_id}">
		   <% } %> --%>
		   <span id="likeNum${c.chall_id}">${c.chall_liked}</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   <img src="resources/images/challenge/bubble.png" width="30" height="25"> ${c.chall_comments}
	   </div>
	   <div class="pb-5 text-center">
	   		<a href="ChallengeDetailServlet?chall_id=${c.chall_id}">${c.chall_title}</a>
	   </div>
     </div>
	</c:forEach>

	<!-- 검색기능 -->
	<div class="d-flex justify-content-center p-2">
		<select name="searchName" class="form-select p-2">
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
	  <c:set var="totalPage" value="${pDTO.totalCount/pDTO.perPage}" />
	  <c:forEach var="p" begin="1" end="${totalPage+(1-(totalPage%1))%1}">
	  	<c:choose>
	  		<c:when test="${p==pDTO.curPage}"><b>${p}</b>&nbsp;&nbsp;</c:when>
	  		<c:otherwise><a href="challenge?curPage=${p}&searchName=${searchName}&searchValue=${searchValue}&sortBy=${sortBy}">${p}&nbsp;&nbsp;</a></c:otherwise>
	  	</c:choose>
	  </c:forEach>
	<%--   <% 
		    int curPage = pDTO.getCurPage(); 
		    int perPage = pDTO.getPerPage(); 
		    int totalCount = pDTO.getTotalCount();
		    int totalPage = totalCount/perPage;
		    if (totalCount%perPage!=0) totalPage++;
		    for (int p=1; p<=totalPage; p++) {
		    	if (p==curPage) {
		    		out.print("<b>"+p+"</b>&nbsp;&nbsp;");
		    	} else {
		    		out.print("<a href='ChallengeListServlet?curPage="+p
		    				+"&searchName="+searchName+"&searchValue="+searchValue
		    				+"&sortBy="+sortBy+"'>"+p+"</a>&nbsp;&nbsp;");
		    	} 
		    }
	  %> --%>
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
	        <h5 class="modal-title" id="exampleModalLabel">도장을 획득했습니다! <${challThisMonth.stamp_img}></h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body text-center">
	      <img src="resources/upload/${challThisMonth.stamp_img}" width="400">
	      </div>
	      <div class="modal-footer mb-3 text-center">
	       ${challThisMonth.stamp_content}
	      </div>
	    </div>
	  </div>
	 </div>
