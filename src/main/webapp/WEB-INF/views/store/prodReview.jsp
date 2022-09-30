<%@page import="com.dto.ReviewProfileDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	table.review {
	  border-collapse: separate;
	  border-spacing: 0px;
	  text-align: left;
	  line-height: 1.5;
	  margin : 20px 10px;
	}
	table.review td {
	  width: 350px; 
	  padding: 10px;
	  vertical-align: top;
	  border-bottom: 1px solid #8FBC8F;
	  vertical-align: middle;
	}
</style>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		$(".show").click(function() {
			var review = $(this).attr("data-review");
			var show = $("#show" + review);
			console.log(show);
			$("#hiden" + review).slideToggle("slow");
		});
	});//end ready
</script>

<c:if test="${!empty pordReview}">
<div style="text-align: center; color: gray;"> 구매후기 </div>
	<table class="review" style="text-align: center;">
		<tr>
			<td colspan="6" style="background-color: #8FBC8F;"></td>
		</tr>
		<tr>
			<td></td>
			<td>번호</td>
			<td>작성자</td>
			<td>제목</td>
			<td>작성일</td>
			<td>만족도</td>
		</tr>
		<c:forEach var="rDTO" items="${prodReview}">
		<tr class="show" id="show${rDTO.review_id}" data-review="${rDTO.review_id}">
			<td><img alt="리뷰" src="/zzp/resources/images/review/review.png" width="45px" height="45px"></td>
			<td>${rDTO.review_id}</td>
			<td>
				<a style="text-decoration: none; color: black;" href="ProfileMainServlet?userid=${rDTO.userid}"> 
					<img alt="프로필" src="/zzp/resources/upload/profile/${rDTO.profile_img}" width="40px" height="40px">
					&nbsp;&nbsp; ${rDTO.userid} 
				</a>
			</td>
			<td>${rDTO.review_title}</td>
			<td>${rDTO.review_created.substring(0,10)}</td>
			<td>${rDTO.review_rate}</td>
		</tr>
		<tr id="hiden${rDTO.review_id}" style="display: none;">
			<td colspan="6" style="text-align: right; padding-right: 50px;">${rDTO.review_content}</td>
		</tr>
		</c:forEach>
	</table>
</c:if>