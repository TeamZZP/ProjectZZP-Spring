<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
	<script type="text/javascript">
		if ('${empty mesg}'=='false') {
			alert('${mesg}');
		}
	</script>

<style>
	.paging {
		cursor: pointer;
	}
	.form-select {
		width: 140px; 
		display: inline;
	}
	.searchValue {
		width: 150px; 
		display: inline;
	}
	a {
		text-decoration: none;
		color: black;
	}
	.challengeDetail {
		cursor: pointer;
	}
</style>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function () {
	//페이징
	$('.paging').on('click', function() {
		$('#page').val($(this).attr('data-page'));
		$('form').attr('action', '/zzp/admin/challenge').submit();
	})
	//챌린지 작성
	$(".writeBtn").on("click", function () {
		location.href = "/zzp/admin/challenge/write";
	});
	//챌린지 상세보기
	$(".challengeDetail").on("click", function () {
		location.href = "/zzp/admin/challenge/"+$(this).attr("data-id");
	});
	//챌린지 수정
	$(".updateChallBtn").on("click", function () {
		let cid = $(this).attr("data-cid")
		location.href = "/zzp/admin/challenge/write/"+cid
	})
	
	//챌린지 삭제 모달
 	$("#deleteModal").on("shown.bs.modal", function (e) {
 		let button = e.relatedTarget;
		let cid = button.getAttribute("data-bs-cid")
		console.log(cid)
		$("#delchall_id").val(cid);
	});
	//챌린지 삭제
	$(".delChallBtn").on("click", function (e) {
		let chall_id = $("#delchall_id").val()
		$.ajax({
			url: '/zzp/admin/challenge/'+chall_id,
			type: 'DELETE',
			success: function () {
				location.href = '/zzp/admin/challenge';
			},
			error: function () {
				alert('문제가 발생했습니다. 다시 시도해 주세요.');
			}
		})
	});
	
});

</script>

<c:set var="list" value="${pDTO.list}" />
<div class="container mt-2 mb-2">
	<div class="row">
		  <div class="col">
		    <form action="/zzp/admin/challenge">
		    	<input type="hidden" name="page" value="1" id="page">
		  		<input type="hidden" name="category" value="challenge">
				  <select name="searchName" class="form-select searchName" data-style="btn-info" id="inputGroupSelect01">
					    <option selected disabled hidden>카테고리</option>
					    <option value="chall_title" <c:if test="${searchName=='chall_title'}">selected</c:if>>제목</option>
					    <option value="chall_content" <c:if test="${searchName=='chall_content'}">selected</c:if>>내용</option>
					    <option value="chall_created" <c:if test="${searchName=='chall_created'}">selected</c:if>>등록일</option>
				  </select>
		  		<input type="text" class="form-control searchValue" name="searchValue" 
		  			<c:if test="${!empty searchValue && searchValue!='null'}">value="${searchValue}"</c:if>>
	      		<input type="submit" class="btn btn-success" value="검색" style="margin-top: -5px;"></input>
	         </form>
	      </div>
	      <div class="col">
	      	<div class="float-end">
	      	<button class="writeBtn btn btn-success">이 달의 챌린지 등록하기</button>
	      	</div>
	      </div>
	</div>
</div>



<div class="container col-md-auto">
<div class="row justify-content-md-center">
<table class="table table-hover table-sm">
	<tr>
		<th>게시글 번호</th>
		<th>아이디</th>
		<th>챌린지 제목</th>
		<th>등록일</th>
		<th>관리</th>
	</tr>
	
<c:forEach var="c" items="${list}">
	<tr id="list">
		<td class="challengeDetail" data-id="${c.chall_id}">${c.chall_id}</td>
		<td class="challengeDetail" data-id="${c.chall_id}">${c.userid}</td>
		<td class="challengeDetail" data-id="${c.chall_id}">${c.chall_title}</td>
		<td class="challengeDetail" data-id="${c.chall_id}">${c.chall_created}</td>
		<td>
			<button type="button" class="updateChallBtn btn btn-outline-success btn-sm" data-cid="${c.chall_id}" >수정</button>
			<button type="button" class="btn btn-outline-dark btn-sm" 
					data-bs-toggle="modal" data-bs-target="#deleteModal" data-bs-cid="${c.chall_id}">삭제</button>
		</td>
	</tr>
</c:forEach>
</table>
</div>
</div>

	<!-- 페이징 -->
	<div class="container">
	  <!-- 페이징 -->
	  <div class="p-2 text-center challPage">
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
	  




		<!-- Modal -->
			<div id="deleteModal" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="staticBackdropLabel">게시글 삭제</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        선택한 게시글을 삭제하시겠습니까?
			      </div>
			      <div class="modal-footer">
			        <input type="hidden" id="delchall_id">
			        <button type="button" class="delChallBtn btn btn-success">삭제</button>
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			      </div>
			    </div> 
			  </div>
			</div>