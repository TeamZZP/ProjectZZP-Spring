<%@page import="com.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%
		NoticeDTO nDTO = (NoticeDTO)session.getAttribute("noticeOne");
		System.out.print("nDTO확인 " + nDTO);
		
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
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript">
			function NoticeList() {
				$("form").attr("action", "NoticeListServlet");
			}
	</script>
<div style="text-align: center; display: flex; justify-content:center; height: 100px; margin-bottom: 10px;" >
		<img src="images/notice3.png" alt="..." style="width: auto;">
</div>
	<form action="NoticeUpdateServlet" method="post">
	<div class="container justify-content-center">
	<div class="row">
		<input type="hidden" name="nId" value="${dto.notice_id()}">
		<table border="1" style="border-collapse: collapse;">
			<tr>
				<td colspan="2"> 
					<div class="input-group">
						 <span class="input-group-text">제목</span>
						 <input type="text" class="form-control" name="notice_tittle" id="nTittle"  value="${dto.notice_tittle}">
					</div>
				</td>
			</tr>
			<tr>
				<td>
					 작성일 <input type="text" class="form-control" value="${dto.notice_created}">
				</td>
				<td>
					조회수 <input type="text" class="form-control" value="${dto.notice_hits}">
				</td>
			</tr>
			<tr>
				<td colspan="2"> 
					<textarea rows="10" cols="50" name="notice_content"  class="form-control">${dto.notice_content}</textarea> 
				</td>
			</tr>
			<tr>
				<td><button onclick="NoticeList()" class="btn btn-success">목록보기</button></td>
				<td style="text-align: right;">
					<button type="submit" class="btn btn-success">수정 완료</button>
				</td>
			</tr>
		</table>
	</div>
	</div>
	</form>