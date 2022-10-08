<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		img {
			text-align: center;
			vertical-align: middle;
			background-size: cover;
			width: 100%;
			height: auto;
		}
	</style>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script>
		$(document).ready(function () {
			var img = opener.$("#upload").attr("src"); 
			$("#upload").attr("src", img);
		});//end ready
	</script>
</head>
<body>
	<div>
		<b>내 첨부파일</b>
	</div >
	<div id="img">
		<img alt="첨부파일" src='<c:if test="${img != null}">${img}</c:if>' id="upload" width="380px" height="500px" title="첨부파일">
	</div>	
</body>
</html>