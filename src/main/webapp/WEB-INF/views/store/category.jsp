<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<style type="text/css">

	#category{
	
		float: left;
		padding-left: 50px;
		text-decoration: none;
		font-size: 20px;
		
		}
		
		
	a:hover{
		color: green;
		font-weight: bold;
		cursor: pointer;
	}	
</style>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>  


/*ajax로 카테고리 변경
	function categoryChange(c_id) {

		console.log(c_id);
		$.ajax({
			type : "get",
			url : "productByCategory",
			data : {
				c_id: c_id
			},
			dataType : "text",
			success : function(data,status,xhr) {
				console.log("카테고리 변경 ajax 성공");
			},
			error : function(xhr, status,error) {
				console.log(error);
			}
		})
		
	}*/   

</script>  
 

<!-- <a>카테고리jsp</a> <br> -->
<div id="category">
	<a href="${contextPath}/store">베스트</a><br>
	<c:forEach var="cList" items="${categoryList}">
		<%-- <a onClick="categoryChange('${cList.c_id}')">${cList.c_name}</a><br> --%><!-- ajax로할경우 -->
		
		<a href="${contextPath}/store/${cList.c_id}">${cList.c_name}</a>
		<br>
	</c:forEach>
</div>
