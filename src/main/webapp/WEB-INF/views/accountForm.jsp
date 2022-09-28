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
</head>
<body>
<!-- Button trigger modal -->
<button type="button" id="openModal" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#mypageModal" style="display: none;"></button>

<!-- Modal -->
<div class="modal fade" id="mypageModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="text-align: center;">
        <span id="modalMesg"></span>
      </div>
      <div class="modal-footer">
        <button type="button" id="confirm" class="btn btn-outline-success" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>
<jsp:include page="common/header.jsp" flush="true"></jsp:include>
<jsp:include page="mypage/accountForm.jsp" flush="true"></jsp:include>
<jsp:include page="common/footer.jsp" flush="true"></jsp:include>
</body>
</html>