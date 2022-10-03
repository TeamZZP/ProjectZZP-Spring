<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<style>
	a {
		text-decoration: none;
		color: black;
	}
	.form-select {
		width: 140px; 
		display: inline;
	}
	.searchValue {
		width: 150px; 
		display: inline;
	}
	.paging {
		cursor: pointer;
	}
</style>
<c:set value="${pDTO.list}" var="member_list"/>
<!-- 관리자 페이지 회원 관리 -->
<form action="/zzp/admin/${category}" id="sortForm">
<div class="container mt-2 mb-2">
	<div class="row"><!-- 상단 카테고리, 검색, 정렬 -->
		<div class="col">
			<!-- 검색 searchName 같으면 selected -->
				<select class="form-select" name="searchName" data-style="btn-info" id="inputGroupSelect01">
					<option selected disabled hidden>검색 기준</option>
					<option value="userid"<c:if test="${searchName eq 'userid'}">selected</c:if>>아이디</option>
					<option value="username"<c:if test="${searchName eq 'username'}">selected</c:if>>이름</option>
					<option value="phone"<c:if test="${searchName eq 'phone'}">selected</c:if>>전화번호</option>
					<option value="address"<c:if test="${searchName eq 'address'}">selected</c:if>>주소</option>
				</select>
			  <input type="text" name="searchValue" class="form-control searchValue"
			  	<c:if test="${not empty searchName && searchValue != 'null'}">value="${searchValue}"</c:if>>
			  	<!-- 검색어 value로 저장, 정렬-폼 제출시  searchValue 데이터 유지 -->
		      <button type="button" id="searchMember" class="btn btn-success" style="margin-top: -5px;">검색</button>
	    </div>
		<div class="col">
	    	<div class="float-end">
			<!-- 정렬 -->
			<select class="form-select sortBy" name="sortBy" id="sortBy" data-style="btn-info">
				<option value="created_at" selected disabled hidden>정렬</option>
				<option value="created_at"<c:if test="${sortBy eq 'created_at'}">selected</c:if>>가입일자</option>
				<option value="userid"<c:if test="${sortBy eq 'userid'}">selected</c:if>>아이디</option>
				<option value="username"<c:if test="${sortBy eq 'username'}">selected</c:if>>이름</option>
				<option value="addr1"<c:if test="${sortBy eq 'addr1'}">selected</c:if>>주소</option>
			</select>
			</div>
		</div>
	</div>
</div>
</form>
<div class="container col-md-auto">
<!-- <div class="container col col-lg-9"> -->
<div class="row justify-content-md-center">
<br>
<table class="table table-hover table-sm">
	<tr>
		<th>아이디</th>
		<th>이름</th>
		<th>전화번호</th>
		<th>기본 주소</th>
		<th>가입일자</th>
		<th>관리</th>
	</tr>
<form id="memberForm">
<!-- 페이징 할 때도 검색, 정렬 조건 유지하도록 -->
<input type="hidden" name="searchName" value="${searchName}">
<input type="hidden" name="searchValue" value="${searchValue}">
<input type="hidden" name="sortBy" value="${sortBy}">
<input type="hidden" id="page" name="page" value="1">
<c:forEach var="member" items="${member_list}">
	<tr id="list">
		<td>${member.userid}</td>
		<td>${member.username}</td>
		<td>${member.phone}
		</td>
		<td>
			<span style="font-size: 14px;">${member.post_num}</span><br>
			${member.addr1}
			${member.addr2}
		</td>
		<td>${member.created_at.substring(0, 10)}</td>
		<td>
			<!-- Modal -->
			<div class="modal fade" id="deleteMember${member.userid}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="staticBackdropLabel"></h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			      	회원 <b>${member.userid}</b>님을 삭제하시겠습니까?
			      </div>
			      <div class="modal-footer">
			        <button type="button" id="delete${member.userid}" data-id="${member.userid}" name="delete" class="btn btn-success">삭제</button>
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			      </div>
			    </div>
			  </div>
			</div>
			<!-- Button trigger modal -->
			<button type="button" id="change${member.userid}" data-id="${member.userid}" class="btn btn-outline-success btn-sm" name="change">수정</button>
			<button type="button" id="checkDelete${member.userid}" class="btn btn-outline-dark btn-sm" name="checkDelete" data-bs-toggle="modal" data-bs-target="#deleteMember${member.userid}">
				삭제
			</button><!-- open modal -->
		</td>
	</tr>
</c:forEach>
</form>
</table>
	<!-- 페이징 -->
	<div class="p-2 text-center productPage">
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
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//페이징
 		$('.paging').on('click', function() {
			$('#page').val($(this).attr('data-page'));
			$('#memberForm').submit();
		})
		
		//정렬
		$("#sortBy").on("change", function() {
			$("#sortForm").submit();
		});//end fn
		
		//검색
		$("#searchMember").on("click", function() {
			$("#sortForm").submit();
		});//end fn
		
		//회원 삭제
		$("button[name=delete]").on("click", function() {//모달의 삭제 버튼 클릭시 회원 삭제
			var userid=$(this).data("id");
			console.log(userid);
 			//*****ajax
  			$.ajax({
				type : "delete",
				url : "${contextPath}/admin/member/"+userid,
				dataType : "text",
				contentType:"application/json;charset=UTF-8",//매개변수 map으로 받을 수 있도록
				data : JSON.stringify({//서버에 전송할 데이터
					userid : userid
				}),
				success : function(data, status, xhr) {
					$("#openModal").trigger("click");
					$("#modalMesg").text("해당 회원이 삭제되었습니다.");
					//console.log("success");
					$("#checkDelete"+userid).parents("tr").remove();
				},
				error: function(xhr, status, error) {
					alert(error);
				}						
			});//end ajax
		});//end fn
		
		//수정 버튼 클릭//회원 정보 출력 페이지로 이동
		$("button[name=change]").on("click", function() {
			var id=$(this).attr("data-id");
			console.log(id);
			location.href="${contextPath}/admin/member/"+id;
		});//end fn
	});//end ready
</script>
<!-- Button trigger modal -->
<button type="button" id="openModal" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#adminModal" style="display: none;"></button>

<!-- Modal -->
<div class="modal fade" id="adminModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="text-align: center;">
        <span id="modalMesg"></span>
      </div>
      <div class="modal-footer">
        <button type="button" id="confirm" class="btn btn-outline-success" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>