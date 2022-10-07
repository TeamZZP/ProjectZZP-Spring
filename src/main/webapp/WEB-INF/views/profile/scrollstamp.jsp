<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:forEach var="s" items="${pDTO.list}">	
     <div class="oneStamp col-xl-4 col-md-6">
       <div class="position-relative">
	       <div class="hover-zoomin">
				<img src="/upload/challenge/${s.stamp_img}" border="0" 
						 data-bs-toggle="modal" data-bs-target="#stampModal${s.stamp_id}">
		   </div>
		   <span class="translate-middle badge rounded-pill bg-danger stamp-num">
	    	${s.stamp_num}
	  	   </span>
  	   </div>
     </div>
     
     <!-- Modal -->
	<div class="modal fade" id="stampModal${s.stamp_id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">${s.stamp_name}</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body text-center">
	      <img src="/upload/challenge/${s.stamp_img}" width="400">
	      </div>
	      <div class="modal-footer mb-3 text-center">
	       ${s.stamp_content}
	      </div>
	    </div>
	  </div>
	 </div>
</c:forEach>