<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 <script src="resources/js/question/questionInsert.js"></script>
 
<div style="text-align: center; display: flex; justify-content:center; height: 100px; margin-bottom: 10px;" >
		<img src="${pageContext.request.contextPath}/resources/images/question/question.png" alt="..." style="width: auto;">
</div>

<form action="" id="questionForm"  method="post">
<input type="hidden" name="userid" value="${mDTO.userid}">
<input type="hidden" name="oldFile" value="">
<div class="container justify-content-center">
<div class="row">
		<table>
			<tr>
				<td colspan="2"> 
					<div class="input-group">
					  <span class="input-group-text">제목</span>
					  <input type="text" class="form-control" name="q_title" id="qTittle">
					</div>
				</td>
			</tr>
			<tr>
				<th colspan="2"> 
					<div class="input-group">
					<% 
						String P_ID = request.getParameter("P_ID");		
						String P_Name = request.getParameter("P_Name");	
					%>
					  <button id="pID" class="btn btn-outline-secondary" type="button">상품 정보</button>
					  <input type="text" class="form-control shadow-none" name="P_Name" id="p_name" readonly="readonly" <%if(P_Name != null){ %>value="<%=P_Name%>"<%} %>>
					  <input type="hidden" id="p_id" name="p_id" <%if(P_Name != null){ %>value="<%=P_ID%>"<%} %>>
					</div>
				</th>
			</tr>
			<tr>
				<td colspan="2"> 
					<div class="input-group">
					  <label class="input-group-text" for="inputGroupSelect01">문의 글 카테고리</label>
					  <select class="form-select"  name="q_board_category">
					    <option value="1" selected>상품문의</option>
					    <option value="2">문의 게시판</option>
					  </select>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2"> 
					<div class="input-group">
					  <label class="input-group-text" for="inputGroupSelect01">문의 카테고리</label>
					  <select name="q_category" class="form-select">
					    <option>상품</option>
					    <option>배송</option>
					    <option>교환</option>
					    <option>환불</option>
					    <option selected>기타</option>
					  </select>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div>
					  <textarea class="form-control" rows="15" cols="50" name="q_content" id="qContent" placeholder="내용을 입력하십시오."></textarea>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div>
					  <input class="form-control" accept="image/*" type="file" name=theText id="qFile" multiple>
					</div>
				</td>
			</tr>
			<tr>
				<td> <button id="questionList" class="btn btn-success">목록</button> </td>
				<td style="text-align: right;">
					<button id="questionInsert" data-userid="${mDTO.userid}" data-operate="upload" class="btn btn-success">등록</button>
					<button id="questionCancel" type="reset" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#aa">취소</button>
					
					<div class="modal fade" id="aa" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="staticBackdropLabel">취소</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body" style="text-align: left;">
					        	이전 페이지로 돌아가시겠습니까?
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-success" onclick="history.back()">확인</button>
					        <button type="button" class="btn btn-success" data-bs-dismiss="modal">취소</button>
					      </div>
					    </div>
					  </div>
					</div>
				</td>
			</tr>
		</table>
</div>
</div>
</form>