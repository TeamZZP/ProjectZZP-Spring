<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ZZP</title>
<style type="text/css">

</style>
</head>
<body>
<jsp:include page="../common/header.jsp" flush="true"></jsp:include><br>

<div class="container">
<div class="text-center">
	<img alt="error" src="/zzp/resources/images/error/error.png" width="300"><br><br>
	<b style="font-size: 30px;">${mesg1}</b><br>
	${mesg2}<br>
	문제가 지속될 경우 관리자에게 문의해 주세요.<br>
	이용에 불편을 드려 죄송합니다.<br>
	<a href="/zzp/" style="font-size: 14px;text-decoration: none;color: green;">메인으로 가기</a>
</div>
</div>
<br>

<jsp:include page="../common/footer.jsp" flush="true"></jsp:include><br>
</body>
</html>