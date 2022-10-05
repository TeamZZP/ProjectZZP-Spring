<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ZZP</title>
<style type="text/css">
.challengeBoard {
	background-color: #EBFFED;
	color: green !important;
}
.challenge {
	color: green !important;
}
.challPage:after{
	content:'';
	display:block;
	clear:both;
}
</style>
</head>
<body>
<jsp:include page="common/header.jsp" flush="true"></jsp:include><br>
<jsp:include page="admin/adminCategory.jsp" flush="true"></jsp:include>
<jsp:include page="admin/adminChallengeWrite.jsp" flush="true"></jsp:include>
<jsp:include page="common/footer.jsp" flush="true"></jsp:include><br>
</body>
</html>