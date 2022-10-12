<%@page import="java.util.HashMap"%>
<%@page import="com.dto.CommentsDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.dto.MemberDTO"%>
<%@page import="com.dto.ChallengeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>

.container-xl {
	align-items: center;
}

.img {
	display: block;
	margin-left: auto;
	margin-right: auto;
}
#img_area {
	position: relative;
}
.container-xl input[type="text"] {
	width: 80%;
	padding: 10px 20px;
	margin: 5px 0;
	box-sizing: border-box;
}

td {
	align-items: center;
}

a {
	text-decoration: none;
	color: black;
}
.paging {
	cursor: pointer;
}

/* 댓글 목록 */
.card {
    background-color: #fff;
    border: none;
}
.container-xl .form-color {
    background-color: #fafafa
}
.container-xl .form-control {
    height: 48px;
    border-radius: 15px;
    display: inline;
}
.container-xl .form-control:focus {
    color: #495057;
    background-color: #fff;
    border-color: #35b69f;
    outline: 0;
    box-shadow: none;
}
.comment_content {
	text-indent: 10px;
}
.user-feed {
    font-size: 14px;
    margin-top: 12px;
}
.profile {
	padding: 10px; 
	padding-right: 20px;
}
.commentBtn {
	width: 10%;
	background: none;
	color: gray;
	border: none;
	display:inline;
    top: 0;
    right: 5px;
    box-sizing: border-box;
}
.commentBtn:hover {
	color: #35b69f;
}
.stamp {
	position: absolute; 
	left: 65%; 
	top: -3%; 
}
#modalBtn{
	display: none;
}
.modal-body:not(.report-body){
	text-align: center;
}
#mesg{
	margin: 0;
}
</style>


<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		//댓글 조회
		function getComments(chall_id, page) {
			$.ajax({
				url: '/zzp/challenge/comment',
				type: 'get',
				data: {
					chall_id:chall_id,
					page:page
				},
				dataType:"html",
				success: function (data) {
					$("#comment_area").html(data);
				},
				error: function () {
					alert('문제가 발생했습니다. 다시 시도해 주세요.');
				}
			})
		}
		//처음 페이지 로딩시 댓글 조회
		getComments('${cDTO.chall_id}', 1);
		//챌린지 삭제 모달
	 	$("#deleteModal").on("shown.bs.modal", function (e) {
	 		let button = e.relatedTarget;
			let cid = button.getAttribute("data-bs-cid")
			$("#delchall_id").val(cid);
		});
		//챌린지 삭제
		$(".delChallBtn").on("click", function (e) {
			let chall_id = $("#delchall_id").val()
			$.ajax({
				url: '/zzp/challenge/${cDTO.chall_id}',
				type: 'DELETE',
				success: function () {
					let preUrl = document.referrer;
					if (preUrl.includes("mypage")) {
						location.href = "/zzp/mypage/${login.userid}/challenge";
					} else if (preUrl.includes("profile")) {
						location.href = "/zzp/profile/${login.userid}";
					} else {
						location.href = "/zzp/challenge";
					}
				},
				error: function () {
					alert('문제가 발생했습니다. 다시 시도해 주세요.');
				}
			})
		});
		//댓글 페이징
 		$('#comment_area').on('click', '.paging', function() {
 			getComments('${cDTO.chall_id}', $(this).attr('data-page'));
		})
		//댓글 입력
		$(".comment").on("click", ".commentAddBtn", function () {
			let content = $(".comment_content");
			if ("${empty login}" == "true") {
				$("#modalBtn").trigger("click");
				$("#mesg").text("로그인이 필요합니다.");
			} else if (content.val().length == 0) {
				content.focus();
			} else {
				let comment_content = content.val();
				$.ajax({
					type:"post",
					url:"/zzp/challenge/comment",
					data: {
						chall_id:"${cDTO.chall_id}",
						comment_content:comment_content.trim(),
						userid:"${login.userid}",
					},
					dataType:"text",
					success: function (data) {
						content.val("");
						getComments('${cDTO.chall_id}', data);
						countComments();
					},
					error: function () {
						alert("문제가 발생했습니다. 다시 시도해 주세요.");
					}
				});
			}
		});
		//답글 입력 
		$(".comment").on("click", ".commentReplyBtn", function () {
			let cid = $(this).attr("data-cid");
			let group = $(this).attr("data-group");
			let parent = $(this).attr("data-parent");
			let content = $("#reply_content"+cid);
			let comment_content = content.val().substring(parent.length+3);
			
			if ("${empty login}" == "true") {
				$("#modalBtn").trigger("click");
				$("#mesg").text("로그인이 필요합니다.");
			} else if (comment_content.trim().length == 0) {
				content.focus();
			} else {
				$.ajax({
					type:"post",
					url:"/zzp/challenge/comment",
					data: {
						chall_id:"${cDTO.chall_id}",
						comment_content:comment_content.trim(),
						userid:"${login.userid}",
						parent_id:cid,
						group_order:group
					},
					dataType:"text",
					success: function (data) {
						content.val("");
						getComments('${cDTO.chall_id}', data);
						countComments();
					},
					error: function () {
						alert("문제가 발생했습니다. 다시 시도해 주세요.");
					}
				});
			}
		});
		//댓글 삭제 모달
	 	$("#deleteCommentModal").on("shown.bs.modal", function (e) {
	 		let button = e.relatedTarget;
			let cid = button.getAttribute("data-bs-cid")
			$("#delcomment_id").val(cid);
		});
		//댓글 삭제
		$(".delCommentBtn").on("click", function (e) {
			let cid = $("#delcomment_id").val()
			$.ajax({
				type:"delete",
				url:"/zzp/challenge/comment/"+cid,
				headers: {
					"Content-Type":"application/json"
				},
				data: JSON.stringify( 
						{'chall_id':'${cDTO.chall_id}'} 
				),
				dataType:"text",
				success: function (data) {
					getComments('${cDTO.chall_id}', data);
					countComments();
					$('#deleteCommentModal').modal('hide');
				},
				error: function () {
					alert("문제가 발생했습니다. 다시 시도해 주세요.");
				}
			});
		});
		//댓글 수정 
		$("#comment_area").on("click", ".commentUpdateBtn", function () { 
			let cid = $(this).attr("data-cid");
			let content = $("#update_content"+cid);
			let parent = $(this).attr("data-parent");
			let comment_content = content.val();
			
			if (parent != "") {
				comment_content = content.val().substring(parent.length+3);
			}
			if (comment_content.trim().length == 0) {
				content.focus();
			} else {
				$.ajax({
					type:"put",
					url:"/zzp/challenge/comment/"+cid,
					headers: {
						"Content-Type":"application/json"
					},
					data: JSON.stringify( 
							{
								'chall_id':'${cDTO.chall_id}',
								'comment_id':cid,
								'comment_content':comment_content.trim(),
								'userid':'${login.userid}'
							} 
					),
					dataType:"text",
					success: function (data) {
						getComments('${cDTO.chall_id}', data);
						countComments();
					},
					error: function () {
						alert("문제가 발생했습니다. 다시 시도해 주세요.");
					}
				});
			}
		});
		//댓글 개수 구해오기
		function countComments() {
			$.ajax({
				type:"get",
				url:"/zzp/challenge/comment/count",
				data: {
					chall_id:"${cDTO.chall_id}",
				},
				dataType:"text",
				success: function (data) {
					$("#commentsNum").text(data);
				},
				error: function () {
					alert("문제가 발생했습니다. 다시 시도해 주세요.");
				}
			});
		}
		//댓글 답글 창 보이기
		$("#comment_area").on("click", ".reply", function () {
			if ("${empty login}" == "true") {
				$("#modalBtn").trigger("click");
				$("#mesg").text("로그인이 필요합니다.");
			} else {
				let comment_id = $(this).attr("data-cid");
				let commentUserid = $(this).attr("data-user");
				
				$("#update"+comment_id).css("display", "none");
				$("#reply"+comment_id).css("display", "block");
				$("#reply_content"+comment_id).focus();
				$("#reply_content"+comment_id).val("@"+commentUserid+"  ");
			}
		});
		//수정 답글 창 보이기 
		$("#comment_area").on("click", ".update", function () {
			let comment_id = $(this).attr("data-cid");
			let parent = $(this).attr("data-parent");
			let content = $(this).attr("data-content");
			
			$("#reply"+comment_id).css("display", "none");
			$("#update"+comment_id).css("display", "block");
			$("#update_content"+comment_id).val("");
			$("#update_content"+comment_id).focus();
			if (parent.length > 0) {
				$("#update_content"+comment_id).val("@"+parent+"  ");
			}
			$("#update_content"+comment_id).val($("#update_content"+comment_id).val()+content);
		});
		
		//좋아요 추가/삭제
		$("#liked_area").on("click", ".liked", function () {
			if ("${empty login}" == "true") {
				$("#modalBtn").trigger("click");
				$("#mesg").text("로그인이 필요합니다.");
			} else {
				$.ajax({
					type:"post",
					url:"/zzp/challenge/${cDTO.chall_id}/like",
					data: {
						chall_id:"${cDTO.chall_id}",
						userid:"${login.userid}"
					},
					dataType:"text",
					success: function (data) {
						$("#liked_area .liked").attr("src", data);
						countLikes();
					},
					error: function () {
						alert("문제가 발생했습니다. 다시 시도해 주세요.");
					}
				});
			}
		});
		//좋아요 개수 구해오기
		function countLikes() {
			$.ajax({
				type:"get",
				url:"/zzp/challenge/${cDTO.chall_id}/like",
				data: {
					chall_id:"${cDTO.chall_id}"
				},
				dataType:"text",
				success: function (data) {
					$("#likeNum").text(data);
				},
				error: function () {
					alert("문제가 발생했습니다. 다시 시도해 주세요.");
				}
			});
		}
		//목록으로 돌아가기
		$(".backList").on("click", function () {
			let preUrl = document.referrer;
			//게시글 업데이트한 후 이동한 페이지에서는 글작성 페이지로 돌아가지 않도록 최신글 화면으로 이동한다.
			if (preUrl.includes("write")) {
				location.href = "/zzp/challenge";
			} else {
				history.back();
			}
		});
		//신고 모달
		$("#reportModal").on("show.bs.modal", function (e) {
			let button = e.relatedTarget
			let cid = button.getAttribute("data-bs-cid")
			let category = button.getAttribute("data-bs-category")
			if (category == 1) {
				$("#report_chall_id").val(cid)
			} else {
				$("#report_comment_id").val(cid)
			}
		});
		//신고 버튼
		$(".reportBtn").on("click", function () {
			if ("${empty login}" == "true") {
				$("#modalBtn").trigger("click");
				$("#mesg").text("로그인이 필요합니다.");
			} else if ($("input[type='radio']:checked").length == 0) {
				alert("신고 사유를 선택해 주세요.")
			} else {
				let chall_id = $("#report_chall_id").val()
				let comment_id = $("#report_comment_id").val()
				let report_reason = $("input[type='radio']:checked").val()
				
				$.ajax({
					type:"post",
					url:"/zzp/challenge/report",
					data: {
						chall_id:chall_id,
						comment_id:comment_id,
						report_reason:report_reason,
						userid:"${login.userid}"
					},
					dataType:"text",
					success: function (data) {
						if (data=="true") {
							$("#modalBtn").trigger("click");
							$("#mesg").text("신고가 완료되었습니다.");
						} else {
							$("#modalBtn").trigger("click");
							$("#mesg").text("이미 신고한 글입니다.");
						}
						$("#reportModal").modal("toggle")
					},
					error: function () {
						alert("문제가 발생했습니다. 다시 시도해 주세요.")
					}
				});
			}
		});
		//신고 모달 저장 데이터 삭제
		$('#reportModal').on('hidden.bs.modal', function(e) {
  			$("#reportModal .modal-body").find('input:radio').prop('checked', false)
			$("#report_chall_id").val("")
			$("#report_comment_id").val("")
		})
		
	});
	

//댓글 게시 시각 구하기
function displayedAt(createdAt) {
	  const milliSeconds = new Date() - new Date(createdAt);
	  
	  const seconds = milliSeconds / 1000;
	  const minutes = seconds / 60;
	  const hours = minutes / 60;
	  const days = hours / 24;
	  const weeks = days / 7;
	  const months = days / 30;
	  const years = days / 365;
	  
	  if (seconds < 60) {
		  return "방금 전";
	  } else if (minutes < 60) {
		  return Math.floor(minutes)+"분 전";
	  } else if (hours < 24) {
		  return Math.floor(hours)+"시간 전";
	  } else if (days < 7) {
		  return Math.floor(days)+"일 전";
	  } else if (weeks < 5) {
		  return Math.floor(weeks)+"주 전";
	  } else if (months < 12) {
		  return Math.floor(months)+"개월 전";
	  } else {
		  return Math.floor(years)+"년 전";
	  }
}
	
</script>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="commentsList" value="${pDTO.list}"/>
<c:if test="${empty currProfile}">
	<c:set var="currProfile" value="user.png"></c:set>
</c:if>

<div class="container-xl" id="">
  <div class="row justify-content-md-center">
	 <div class="col-lg-7">
	  <table class="table table-borderless" style="margin: 0 auto;">
		<tr>
			<td width="25%" style="vertical-align: bottom;"><span class="fs-6 badge bg-success">${cDTO.chall_category}</span></td>
			<td rowspan="2" class="fs-4 fw-bold text-center" style="vertical-align: bottom;">${cDTO.chall_title}</td>
			<td class="text-end">
				<c:choose>
				<%-- 해당 게시글의 글쓴이인 경우 --%>
					<c:when test="${!empty login && login.userid==cDTO.userid}">
						<a href="/zzp/challenge/write/${cDTO.chall_id}" class="btn btn-outline-success">수정</a> 
						<button type="button" class="btn btn-outline-success" 
								data-bs-toggle="modal" data-bs-target="#deleteModal" data-bs-cid="${cDTO.chall_id}">삭제</button>
					</c:when>
				<%-- 관리자인 경우 --%>
					<c:when test="${!empty login && login.role==1}">
						<button type="button" class="btn btn-outline-success" 
								data-bs-toggle="modal" data-bs-target="#deleteModal" data-bs-cid="${cDTO.chall_id}">삭제</button>
					</c:when>
				<%-- 그외의 경우 --%>
					<c:otherwise>
						<a class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#reportModal" 
												data-bs-category="1" data-bs-cid="${cDTO.chall_id}">신고</a>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td>${cDTO.chall_created}</td>
			<td class="text-end">조회수 ${cDTO.chall_hits}</td>
		</tr>
		<tr>
			<td colspan="2">
			    <a href="/zzp/profile/${cDTO.userid}">
				   <img src="/upload/profile/${cDTO.profile_img}" width="50" height="50" class="ms-5 mx-3 rounded-circle" onerror="this.src='/zzp/resources/images/error/user.png'"></a>
				<a href="/zzp/profile/${cDTO.userid}">${cDTO.userid}</a>
			</td>
		</tr>
		<tr id="img_area">
			<td colspan="3">
				<img src="/upload/challenge/${cDTO.chall_img}" class="img"
					onerror="this.src='/zzp/resources/images/error/salad.jpg'" width="80%">
				<c:if test="${!empty cDTO.stamp_img}">
					<img src="/upload/challenge/${cDTO.stamp_img}" class="stamp" width="25%">
				</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="3" class="text-center">
			  <div class="row">
				<div id="liked_area" class="col">
				  <c:choose>
					<%-- 해당 게시글을 현재 로그인한 회원이 좋아요했던 경우 --%>
					<c:when test="${likedIt == 1}">
						<img src="/zzp/resources/images/challenge/liked.png" width="40" height="40" class="liked">
					</c:when>
					<%-- 그외의 경우 --%>
					<c:otherwise>
						<img src="/zzp/resources/images/challenge/like.png" width="40" height="40" class="liked">
					</c:otherwise>
				  </c:choose>
					<span id="likeNum">${cDTO.chall_liked}</span>
				</div>
				<div class="col">
					<img src="/zzp/resources/images/challenge/bubble.png" width="37" height="35"> 
					<span id="commentsNum">${cDTO.chall_comments}</span>
				</div>
			  </div>
			</td>
		</tr>
		<tr>
			<td colspan="3">${cDTO.chall_content}</td>
		</tr>
	  </table>
	 </div>
  </div>
</div>


<%-- 댓글 목록 --%>		
<div class="container-xl mt-5 mb-5 comment">
    <div class="row height d-flex justify-content-center align-items-center">
        <div class="col-lg-7">
         <hr>
            <div class="card">
                <div class="p-3">
                    <h6><b>댓글</b></h6>
                </div>
                <div class="mt-3 d-flex flex-row align-items-center p-3 form-color"> 
                	<img src="/upload/profile/${currProfile}" width="50" class="rounded-circle mr-2" > &nbsp;&nbsp;&nbsp;
                	<input type="text" class="comment_content form-control" name="comment_content"
                		placeholder="칭찬과 격려의 댓글은 작성자에게 큰 힘이 됩니다 :)"> 
                	<button class="commentBtn commentAddBtn">입력</button>
                </div>
                
                <%-- 댓글 목록  비동기로 추가 --%>	
                <div class="mt-2" id="comment_area"> 
                
                </div>
                
            </div>
        
        
        
        <div class="row pt-5">
		  <div class="col">
		  	<a class="backList btn btn-outline-success">목록</a>
		  </div>
		  <div class="col">
		    <div class="float-end">
		  	  <a href="/zzp/challenge/write" class="btn btn-outline-success">글쓰기</a>
		  	</div>
		  </div>
		</div>
		
		
        </div>
    </div>
</div>
		
		
		

		


<%-- modal --%>
<div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
   
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">신고 사유를 선택해 주세요</h5>
      </div>
      <div class="modal-body report-body">
          <div class="mb-3">
            <div class="form-check mb-2">
  				<input class="form-check-input" type="radio" name="report_reason" value="1">
  				<label class="form-check-label" for="report_reason">지나친 광고성 글</label>
			</div>
			<div class="form-check mb-2">
  				<input class="form-check-input" type="radio" name="report_reason" value="2">
  				<label class="form-check-label" for="report_reason">스팸홍보/도배 글</label>
			</div>
			<div class="form-check mb-2">
  				<input class="form-check-input" type="radio" name="report_reason" value="3">
  				<label class="form-check-label" for="report_reason">욕설/비방이 심함</label>
			</div>
			<div class="form-check mb-2">
  				<input class="form-check-input" type="radio" name="report_reason" value="4">
  				<label class="form-check-label" for="report_reason">외설적인 글</label>
			</div>
			<div class="form-check mb-2">
  				<input class="form-check-input" type="radio" name="report_reason" value="5">
  				<label class="form-check-label" for="report_reason">개인정보 노출</label>
			</div>
			<div class="form-check mb-2">
  				<input class="form-check-input" type="radio" name="report_reason" value="6">
  				<label class="form-check-label" for="report_reason">저작권 침해가 우려됨</label>
			</div>
			<div class="form-check mb-2">
  				<input class="form-check-input" type="radio" name="report_reason" value="7">
  				<label class="form-check-label" for="report_reason">기타</label>
			</div>
          </div>
        
      </div>
      <div class="modal-footer">
        <input type="hidden" name="report_chall_id" id="report_chall_id">
        <input type="hidden" name="report_comment_id" id="report_comment_id">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="reportBtn btn btn-success">신고하기</button>
      </div>
    </div>
  
  </div>
</div>


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


			<!-- Modal -->
			<div id="deleteModal" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="delete-title">ZZP</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        정말 삭제하시겠습니까?
			      </div>
			      <div class="modal-footer">
			        <input type="hidden" id="delchall_id">
			        <button type="button" class="delChallBtn btn btn-success">삭제</button>
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			      </div>
			    </div> 
			  </div>
			</div>
			
			<!-- Modal -->
			<div id="deleteCommentModal" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="delete-title">ZZP</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        정말 삭제하시겠습니까?
			      </div>
			      <div class="modal-footer">
			        <input type="hidden" id="delcomment_id">
			        <button type="button" class="delCommentBtn btn btn-success">삭제</button>
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			      </div>
			    </div> 
			  </div>
			</div>