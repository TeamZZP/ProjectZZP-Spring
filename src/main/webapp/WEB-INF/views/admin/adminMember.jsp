<%@page import="com.dto.PageDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Set"%>
<%@page import="com.dto.AddressDTO"%>
<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</style>
<%
	PageDTO pDTO=(PageDTO) request.getAttribute("pDTO");
	String searchName=(String) request.getAttribute("searchName");
	String searchValue=(String) request.getAttribute("searchValue");
	String sortBy=(String) request.getAttribute("sortBy");
%>
<!-- 관리자 페이지 회원 관리 -->
<form action="AdminCategoryServlet" id="memberForm">
<input type="hidden" name="category" value="member">
<div class="container mt-2 mb-2">
	<div class="row"><!-- 상단 카테고리, 검색, 정렬 -->
		<div class="col">
			<!-- 검색 searchName 같으면 selected -->
				<select class="form-select" name="searchName" data-style="btn-info" id="inputGroupSelect01">
					<option selected disabled hidden>카테고리</option>
					<option value="userid" <% if("userid".equals(searchName)){ %>selected<% } %>>아이디</option>
					<option value="username"<% if("username".equals(searchName)){ %>selected<% } %>>이름</option>
					<option value="phone"<% if("phone".equals(searchName)){ %>selected<% } %>>전화번호</option>
					<option value="address"<% if("address".equals(searchName)){ %>selected<% } %>>주소</option>
				</select>
			  <input type="text" name="searchValue" class="form-control searchValue" 
			  			<% if(searchValue != null && !searchValue.equals("null")){ %>value="<%= searchValue %>"<% } %>>
		      <button type="button" id="searchMember" class="btn btn-success" style="margin-top: -5px;">검색</button>
	    </div>
		<div class="col">
	    	<div class="float-end">
			<!-- 정렬 -->
			<select class="form-select sortBy" name="sortBy" id="sortBy" data-style="btn-info">
				<option value="created_at" selected>정렬</option>
				<option value="created_at" <% if("created_at".equals(sortBy)){%>selected<%}%>>가입일자</option>
				<option value="userid" <% if("userid".equals(sortBy)){%>selected<%}%>>아이디</option>
				<option value="username" <% if("username".equals(sortBy)){%>selected<%}%>>이름</option>
				<option value="addr1" <% if("addr1".equals(sortBy)){%>selected<%}%>>주소</option>
			</select>
			</div>
		</div>
	</div>
</div>
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
<%
	List<AddressDTO> list=pDTO.getList();
	for(int i=0; i<list.size(); i++){
		String userid=list.get(i).getUserid();
		String username=list.get(i).getUsername();
		String phone=list.get(i).getPhone();
		String post_num=list.get(i).getPost_num();
		String addr1=list.get(i).getAddr1();
		String addr2=list.get(i).getAddr2();
		String created_at=list.get(i).getCreated_at();
%>
<form>
	<tr id="list">
		<td><%= userid %></td>
		<td><%= username %></td>
		<td><%= phone.substring(0, 3)+"-"
				+ phone.substring(3, 7)+"-"
				+ phone.substring(7, 11) %>
		</td>
		<td>
			<span style="font-size: 14px;"><%= post_num %></span>
			<%= "&nbsp;&nbsp;&nbsp;" + addr1+ "&nbsp;" + addr2 %>
		</td>
		<td><%= created_at %></td>
		<td>
			<!-- Modal -->
			<div class="modal fade" id="deleteMember<%= userid %>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="staticBackdropLabel"></h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			      	회원 <b><%= userid %></b>님을 삭제하시겠습니까?
			      </div>
			      <div class="modal-footer">
			        <button type="button" id="delete<%= userid %>" data-id="<%= userid %>" name="delete" class="btn btn-success">삭제</button>
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			      </div>
			    </div>
			  </div>
			</div>
			<!-- Button trigger modal -->
			<button type="button" id="change<%= userid %>" data-id="<%= userid %>" class="btn btn-outline-success btn-sm" name="change">수정</button>
			<button type="button" id="checkDelete<%= userid %>" class="btn btn-outline-dark btn-sm" name="checkDelete" data-bs-toggle="modal" data-bs-target="#deleteMember<%= userid %>">
				삭제
			</button><!-- open modal -->
		</td>
<%
	}
%>
	</tr>
</form>
</table>
	<!-- 페이징 -->
	 <div class="p-2 text-center memberPage">
	<%
		int curPage = pDTO.getCurPage();
		int perPage = pDTO.getPerPage();
		int totalCount = pDTO.getTotalCount();
		int totalPage = totalCount/perPage;
		if(totalCount % perPage != 0) totalPage++;
		for(int p=1; p<=totalPage; p++){
			if(p==curPage){
				out.print("<b>"+p+"</b>&nbsp;&nbsp;");
			} else {
				out.print("<a id='search' href='AdminCategoryServlet?curPage="+p
	    				+"&searchName="+searchName+"&searchValue="+searchValue
	    				+"&sortBy="+sortBy+"&category=member'>"+p+"</a>&nbsp;&nbsp;");
			}
		} 
	%>
	</div>
</div>
</div>
</form>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#sortBy").on("change", function() {
			$("#memberForm").submit();
		});//end fn
		
		$("#searchMember").on("click", function() {
			$("#memberForm").submit();
		});//end fn
		
		$("button[name=delete]").on("click", function() {//모달의 삭제 버튼 클릭시 회원 삭제
			var userid=$(this).data("id");
			console.log(userid);
 			//*****ajax
 			$.ajax({
				type : "post",
				url : "AccountDeleteServlet",//페이지 이동 없이 해당 url에서 작업 완료 후 데이터만 가져옴
				dataType : "text",
				data : {//서버에 전송할 데이터
					userid : userid
				},
				success : function(data, status, xhr) {
					//alert("해당 회원이 삭제되었습니다.");
					$("#modalBtn").trigger("click");
					$("#mesg").text("해당 회원이 삭제되었습니다.");
					$("#deleteMember"+userid).modal("hide");
					$(".modal-backdrop").hide();//모달창 닫고 백드롭 hide
					console.log("success");
					$("#checkDelete"+userid).parents("tr").remove();
				},
				error: function(xhr, status, error) {
					alert(error);
				}						
			});//end ajax
		});//end fn
		
		$("button[name=change]").on("click", function() {//수정 버튼 클릭//회원 정보 출력 페이지로 이동
			var id=$(this).attr("data-id");
//			console.log(id);
			location.href="AccountManagementServlet?memberId="+id;
		});//end fn
	});//end ready
</script>