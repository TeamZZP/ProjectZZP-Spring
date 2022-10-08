<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ZZP</title>
<c:if test="${not empty mesg}">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		$("#modalBtn").trigger("click");
		$("#mesg").text("${mesg}");
	});
</script>
</c:if>
<style type="text/css">
.member {
	background-color: #EBFFED;
	color: green !important;
}
.memberPage:after{
	content:'';
	display:block;
	clear:both;
}
#modalBtn{
	display: none;
}
.modal-body{
	text-align: center;
}
#mesg{
	margin: 0;
}
</style>
</head>
<body>
<jsp:include page="common/header.jsp" flush="true"></jsp:include><br>
<jsp:include page="admin/adminCategory.jsp" flush="true"></jsp:include>
<jsp:include page="admin/adminMember.jsp" flush="true"></jsp:include>
<jsp:include page="common/footer.jsp" flush="true"></jsp:include><br>

<!-- modal -->
<div class="modal" id="checkVal" data-bs-backdrop="static">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">ZZP</h5>
      </div>
      <div class="modal-body">
        <p id="mesg"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<button type="button" id="modalBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#checkVal">modal</button>
</body>
</html>