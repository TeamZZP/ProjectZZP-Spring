<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
</head>
<body>


<div id="prodTop">
	<jsp:include page="common/header.jsp" flush="true"></jsp:include><br>
	<jsp:include page="store/productRetrieve.jsp" flush="true"></jsp:include><br>
</div>
<div style="margin: 80px;">

	<div class="row">
		<div class="btn-group" role="group" aria-label="Basic example">
			<a class="btn btn-outline-success" href="#prodDetail" role="button" style="text-decoration: none; color: green;">제품상세</a>
			<a class="btn btn-outline-success" href="#prodReview" role="button" style="text-decoration: none; color: green;">구매후기</a>
			<a class="btn btn-outline-success" href="#prodQA" role="button" style="text-decoration: none; color: green;">QnA</a>
		</div>
	</div>
	<div id="prodDetail">
		<jsp:include page="store/prodDetail.jsp" flush="true"></jsp:include><br>
	</div>
	<div id="prodReview">
		<jsp:include page="store/prodReview.jsp" flush="true"></jsp:include><br>
	</div>
	<div id="prodQA">
		<jsp:include page="store/prodQA.jsp" flush="true"></jsp:include><br>
	</div>
	<hr>
	<div style="text-align: right; padding-right: 50px;">
		<a class="btn btn-outline-success" href="#prodTop" role="button" style="text-decoration: none; color: green;">위로가기</a>
	</div>

</div>
<jsp:include page="common/footer.jsp" flush="true"></jsp:include><br>

<!-- modal -->
<div class="modal" id="checkVal" data-bs-backdrop="static">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">ZZP</h5>
      </div>
      <div class="modal-body">
        <p id="mesg" style="text-align: center;"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<button style="display: none;" type="button" id="modalBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#checkVal">modal</button>
</body>
</html>