<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ZZP</title>
<style type="text/css">
.store {
	background-color: #EBFFED;
	color: green !important;
}
.coupon {
	color: green !important;
}
.container:after{
	content:'';
	display:block;
	clear:both;
}
</style>
</head>
<body>
<jsp:include page="common/header.jsp" flush="true"></jsp:include><br>
<jsp:include page="admin/adminCategory.jsp" flush="true"></jsp:include>
<jsp:include page="admin/adminCoupon.jsp" flush="true"></jsp:include>
<jsp:include page="common/footer.jsp" flush="true"></jsp:include><br>
</body>
</html>