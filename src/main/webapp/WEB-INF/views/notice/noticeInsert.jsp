<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="/zzp/resources/js/notice/noticeInsert.js"></script> 

	<div style="text-align: center; display: flex; justify-content:center; height: 100px; margin-bottom: 10px;" >
		<img src="/zzp/resources/images/notice/notice3.png" alt="..." style="width: auto;">
	</div>

	<form method="post" action="">
	<div class="container justify-content-center">
	<div class="row">
	    <table border="1" style="border-collapse: collapse;">
	    	<tr>
	    		<td colspan="2"> 
		    		<div class="input-group">
						  <span class="input-group-text">제목</span>
						  <input type="text" class="form-control" name="notice_tittle" id="nTittle">
					</div>
	    			<div class="input-group">
					  <select class="form-select" name="notice_category">
					    <option value="main">point</option>
	    				<option value="notice" selected="selected">notice</option>
					  </select>
					</div>
	    		</td>
	    	</tr>
	    	<tr>
	    		<td colspan="2">
	    			<textarea class="form-control" rows="15" cols="50" name="notice_content" id="nContent" placeholder="공지사항 내용을 입력하십시오."></textarea>
	    		</td>
	    	</tr>
	    	<tr>
	    		<td style="text-align: left;">
	    			<button id="noticeList" class="btn btn-outline-success">목록</button>
	    		</td>
	    		<td style="text-align: right;">
	    			<button id="noticeInsert" class="btn btn-outline-success">글입력</button> 
	    			<button type="reset" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#aa">취소</button> 
	    			
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