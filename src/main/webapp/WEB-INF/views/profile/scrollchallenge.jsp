<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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