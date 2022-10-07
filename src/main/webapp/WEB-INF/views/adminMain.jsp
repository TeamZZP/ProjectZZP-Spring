<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ZZP</title>
<style>
.dashboard {
	background-color: #EBFFED;
	color: green !important;
}
.container:after{
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
<%
	String mesg=(String) session.getAttribute("mesg");
	if (mesg != null && mesg.length() != 0){
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#modalBtn").trigger("click");
	$("#mesg").text("<%= mesg %>");
});
</script>
<%
		session.removeAttribute("mesg");
	}
%>
</head>
<body>
<div class="modal" id="checkVal">
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

<jsp:include page="common/header.jsp" flush="true"></jsp:include><br>
<jsp:include page="admin/adminCategory.jsp" flush="true"></jsp:include>
<jsp:include page="admin/adminMain.jsp" flush="true"></jsp:include><br>
<jsp:include page="common/footer.jsp" flush="true"></jsp:include><br>
</body>
</html>