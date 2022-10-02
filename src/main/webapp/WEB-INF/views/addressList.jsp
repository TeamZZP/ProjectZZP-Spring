<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ZZP</title>
<link rel="stylesheet" type="text/css" href="resources/css/mypage/mypage.css">
<c:if test="${not empty mesg}">
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#openModal").trigger("click");
			$("#modalMesg").text("${mesg}");
		});//end ready
	</script>
</c:if>
</head>
<body>
<jsp:include page="common/header.jsp" flush="true"></jsp:include>
<jsp:include page="mypage/addressList.jsp" flush="true"></jsp:include>
<jsp:include page="common/footer.jsp" flush="true"></jsp:include>
</body>
</html>