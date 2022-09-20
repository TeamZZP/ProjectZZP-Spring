<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.dto.PageDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	a{
		text-decoration: none;
		color: black;
	}
</style>
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
	<div style="text-align: center; display: flex; justify-content:center; height: 100px; margin-bottom: 10px;" >
		<img src="resources/images/notice/notice3.png" alt="..." style="width: auto;">
	</div>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script>
		$(function () {
			$("#NoticeInsert").click(function () {
				$("#NoticeInsertFrom").attr("action", "noticeInsert.jsp");
			});
		});
	</script>
<%-- 	<%
		MemberDTO mDTO = (MemberDTO)session.getAttribute("login");
		if(mDTO != null){
			int admin = mDTO.getRole();
			if (admin == 1){
	%>
	<form method="post" action="noticeInsert.jsp" id="NoticeInsertFrom">
		<div style="text-align: right; padding-right: 10px;">
			<button id="NoticeInsert" type="submit" class="btn btn-outline-success">공지 글쓰기</button> 
		</div>
	</form>
	<%
			}
		}
	%> --%> 
   <table border="1" style="text-align: center; border-collapse: collapse;" class="table table-hover">
		<tr style="background-color: #8FBC8F">
			<td>번호</td>
			<td>제목</td>
			<td>작성일</td>
			<td>조회</td>
		</tr>
    	<c:forEach var="point" items="${NoticePointList}">
    	<tr style="background: #DCDCDC">
    		<td> <b> ${point.notice_id} </b> </td>
    		<td> 
    			<a href="${point.notice_id}?category=${point.notice_category}"> 
    				<b> ${point.notice_tittle} </b> 
    			</a> 
    		</td>
    		<td> <b>  ${point.notice_created.substring(0, 10)} </b> </td>
    		<td> <b>  ${point.notice_hits} </b> </td>
    	</tr>
    	</c:forEach>
    	
    	<%
	 		PageDTO pDTO = (PageDTO)request.getAttribute("pDTO");
	 		List<NoticeDTO> list = pDTO.getList();
	 		for(int i = 0; i < list.size(); i++){
	 			NoticeDTO nDTO = list.get(i);
	 			String day = nDTO.getNotice_created().substring(0,10);
		%>
    	<tr>
    		<td> <%= nDTO.getNotice_id() %> </td>
    		<td><a href="<%=nDTO.getNotice_id()%>?category=<%=nDTO.getNotice_category() %>"> <%= nDTO.getNotice_tittle() %> </a> </td>
    		<td> <%= day %> </td>
    		<td> <%= nDTO.getNotice_hits() %> </td>
    	</tr>
    	<%
			}
		%>
		<tr>
			<td colspan="4">
			 <%
		        int curPage = pDTO.getCurPage();
		        int perPage = pDTO.getPerPage();
				int totalCount = pDTO.getTotalCount();
				int totalPage = totalCount/perPage; //페이지수 구하기
				if(totalCount%perPage!=0) totalPage++; //페이지수 구하기 나머지가 있으면 +1
		        for(int i=1; i <= totalPage; i++){//1페이지부터 시작함으로 i=1
		          	if(i== curPage){
		          		out.print(i+"&nbsp;"); //현재페이지
		          	}else{
		          		out.print("<a style='color: green;' href = 'notice?curPage="+i+"'>" + i + " </a>");  
		          	} //다른 페이지 선택시 링크로 이동
		        }//end for
		  	 %>
			</td>
		</tr>
    </table>