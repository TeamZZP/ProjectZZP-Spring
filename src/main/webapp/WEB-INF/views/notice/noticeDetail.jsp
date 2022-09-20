<%@page import="com.dto.MemberDTO"%>
<%@page import="com.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String mesg = (String)session.getAttribute("mesg");
		if(mesg != null){
	%>
		<script>
			alert("<%=mesg%>");
		</script>
	<%
		}
		session.removeAttribute("mesg");
	%>
    <%
		NoticeDTO nextDTO = (NoticeDTO)request.getAttribute("nextDTO");
	%>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript">
				function NoticeList() {
					$("#DetailForm").attr("action", "NoticeListServlet");
				}
				function NoticeDelete() {
					$("#DetailForm").attr("action", "NoticeDeleteServlet");
				}
	</script>
	<div style="text-align: center; display: flex; justify-content:center; height: 100px; margin-bottom: 10px;" >
		<img src="resources/images/notice/notice3.png" alt="..." style="width: auto;">
	</div>
	<form action="NoticeUpdate.jsp" method="post" id="DetailForm">
	<div class="container justify-content-center">
	<div class="row">
		<input type="hidden" name="nId" value="${nDTO.notice_id}">
		<table style="border-collapse: collapse;" >
			<tr>
				<td colspan="2">
					<div class="input-group shadow-none">
						 <span class="input-group-text">글번호</span>
						 <input type="text" class="form-control shadow-none"  value="${nDTO.notice_id}" readonly="readonly">
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="input-group shadow-none">
						 <span class="input-group-text">제목</span>
						 <input type="text" class="form-control shadow-none"  value="${nDTO.notice_tittle}" readonly="readonly">
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="input-group mb-3">
					  <span class="input-group-text">작성일</span>
					  <input type="text" class="form-control shadow-none" value="${nDTO.notice_created.substring(0,10)}" readonly="readonly">
					</div>
				</td>
				<td>
					<div class="input-group mb-3">
					  <span class="input-group-text">조회</span>
					  <input type="text" class="form-control shadow-none" value="${nDTO.notice_hits" readonly="readonly">
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea class="form-control shadow-none" rows="15" cols="50" readonly="readonly"> ${nDTO.notice_content} </textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="input-group col-mb-3">
						 <button class="btn btn-outline-success col-md-2" onclick="NoticeList()">목록</button>
						  <% if(nextDTO != null) { %>
							  <button class="btn btn-outline-success col-md-2" type="button" 
							  	onclick="location.href=href='NoticeOneSelectServlet?NOTICE_ID=${nextDTO.notice_id}">
							  	다음글
							  </button>
							  <a class="col-md-8" href="NoticeOneSelectServlet?NOTICE_ID=${nextDTO.notice_id}" 
							  	style="text-decoration: none;">
								 <input style="text-align: center;" type="url" class="form-control shadow-none" 
								 	value="${nextDTO.notice_tittle}" readonly="readonly">
							  </a>
						  <% } %>
					</div>
				</td>
			</tr>
			<tr>
				<%
					MemberDTO mDTO = (MemberDTO)session.getAttribute("login");
					if(mDTO != null){
						int admin = mDTO.getRole();
						if (admin == 1){
				%>
				<td colspan="2" style="text-align: right;">
					<button type="submit" id="NoticeUpdate" class="btn btn-outline-success" >수정</button>
					<button onclick="NoticeDelete()" class="btn btn-outline-success" >글 삭제</button>				
				</td>
				<%
						}
					}
				%>
			</tr>
		</table>
	</div>
	</div>
	</form>