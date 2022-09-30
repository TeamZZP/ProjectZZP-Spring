<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="commentsList" value="${pDTO.list}"/>
				<c:forEach var="c" items="${commentsList}">
                    <div class="d-flex flex-row p-3"> 
                      <c:if test="${c.step!=0}">
                      	<div style="width: 60px;"></div>
                      </c:if>
                    	<div class="profile">
                    		<a href="/zzp/profile/${c.userid}">
                    			<img src="/zzp/resources/upload/profile/${c.profile_img}" width="30" height="30" class="rounded-circle mr-3"></a>
                        </div>
                        <div class="w-100">
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="d-flex flex-row align-items-center"> 
                                	<a href="profile/${c.userid}">
                                	<span class="mr-2">${c.userid}</span></a> 
                                </div> 
                                <small id="commentTime${c.comment_id}"></small>
                                	<script>$("#commentTime${c.comment_id}").html(displayedAt('${c.comment_created}'));</script>
                            </div>
                            <p class="text-justify mb-0">
                            	<c:if test="${c.step!=0}"><span style="color: green;">@${c.parent_userid} &nbsp;</span></c:if>
                            	${c.comment_content}</p>
                            <div class="d-flex flex-row user-feed"> 
                            	<a class="reply ml-3" data-cid="${c.comment_id}" data-user="${c.userid}">답글 달기</a> &nbsp;&nbsp;
                            	<c:choose>
                            	  <%-- 해당 댓글의 작성자인 경우 --%>
                            	  <c:when test="${!empty login && login.userid==c.userid}">
									<a class="ml-3 update" data-cid="${c.comment_id}" 
											data-parent="${c.parent_userid}" data-content="${c.comment_content}">수정</a> &nbsp;&nbsp;
									<a class="ml-3 commentDelBtn" data-cid="${c.comment_id}">삭제</a> 
								  </c:when>
								  <%-- 관리자인 경우 --%>
								  <c:when test="${!empty login && login.role==1}">
									<a class="ml-3 commentDelBtn" data-cid="${c.comment_id}">삭제</a> 
								  </c:when>
								  <%-- 그외의 경우 --%> 
								  <c:otherwise>
									<a class="ml-3" data-bs-toggle="modal" data-bs-target="#reportModal" 
												data-bs-category="2" data-bs-cid="${c.comment_id}">신고</a> 
								  </c:otherwise>
								</c:choose>
                            </div>
                        </div>
                    </div>
                    
                    
                    <%-- 답글 입력창 --%>
                    <div id="reply${c.comment_id}" style="display: none;">
	                    <div class="d-flex flex-row p-3">
	                    	<div style="width: 60px;"></div>
	                    	<div class="profile">
	                    		<img src="/zzp/resources/upload/profile/${currProfile}" width="30" height="30" class="rounded-circle mr-3">
	                    	</div>
	                    	<div class="reply_box d-flex flex-row align-items-center w-100 text-justify mb-0">
	                    		<input type="text" class="reply_content form-control" name="comment_content" id="reply_content${c.comment_id}"> 
	                    		<button class="commentBtn commentReplyBtn" 
	                    			data-cid="${c.comment_id}" data-group="${c.group_order}"
	                    			data-parent="${c.userid}">입력</button>
	                    			<%-- 답글 대상 아이디 고정 --%>
		                    		<script type="text/javascript">
		                    		 $("#reply_content${c.comment_id}").on("input", function () {
		            					if (String($(this).val()).indexOf("@${c.userid}  ") == -1) {
		            						$(this).val("@${c.userid}  ");
		            					}
		            				 }); 
		                    		</script>
	                    	</div>
	                    </div>
                    </div>
                    
                    <%-- 수정 입력창 --%>
                    <div id="update${c.comment_id}" style="display: none;">
	                    <div class="d-flex flex-row p-3">
	                    	<div style="width: 60px;"></div>
	                    	<div class="profile">
	                    		<img src="/zzp/resources/upload/profile/${currProfile}" width="30" height="30" class="rounded-circle mr-3">
	                    	</div>
	                    	<div class="reply_box d-flex flex-row align-items-center w-100 text-justify mb-0">
	                    		<input type="text" class="update_content form-control" name="comment_content" id="update_content${c.comment_id}"> 
	                    		<button class="commentBtn commentUpdateBtn" data-cid="${c.comment_id}"
	                    					data-parent="${c.parent_userid}">입력</button>
	                    			<%-- 답글 대상 아이디 고정 --%>
		                    		<script type="text/javascript">
		                    		 $("#update_content${c.comment_id}").on("input", function () {
		            					if ("${c.parent_userid}" != "null" 
		            							&& String($(this).val()).indexOf("@${c.parent_userid}  ") == -1 ) {
		            						$(this).val("@${c.parent_userid}  ");
		            					}
		            				 }); 
		                    		</script>
	                    	</div>
	                    </div>
                    </div>
                    
                </c:forEach>
                
                
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
	  
                