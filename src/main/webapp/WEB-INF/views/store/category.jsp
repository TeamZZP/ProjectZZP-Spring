<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>  
$(function() {
	

})

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
 
</head>
<body>
<a>카테고리jsp</a> <br>
<a href="store">베스트</a><br>
<c:forEach var="cList" items="${categoryList}">
<%-- <a onClick="categoryChange('${cList.c_id}')">${cList.c_name}</a><br> --%> <!-- ajax로할경우 -->
<a href="productByCategory?c_id=${cList.c_id}">${cList.c_name}</a><br>
</c:forEach> 

</body>
</html>