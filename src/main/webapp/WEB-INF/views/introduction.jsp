<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>ZZP</title>
</head>
<body>
	<div id="intTop">
		<jsp:include page="common/header.jsp" flush="true"></jsp:include><br>
		<jsp:include page="introduction/introduction.jsp" flush="true"></jsp:include><br>
	</div>
	<div style="text-align: right; padding-right: 50px;">
		<a class="btn btn-outline-success" href="#intTop" role="button" style="text-decoration: none; color: green;">위로가기</a>
	</div>
	<jsp:include page="common/footer.jsp" flush="true"></jsp:include><br>
</body>
</html>