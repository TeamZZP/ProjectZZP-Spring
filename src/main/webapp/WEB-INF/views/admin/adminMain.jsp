<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
	a {
		text-decoration: none;
		color: black;
	}
	.percent[data-n^='+'] {
		color: green;
	}
	.percent[data-n^='-'] {
		color: red;
	}
	.oneOrder:hover, .oneMember:hover, .oneQuestion:hover {
		cursor: pointer;
	}
</style>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function () {
	//주문 상세보기
	$(".oneOrder").on("click", function () {
		location.href = "";
	});
	//회원 상세보기
	$(".oneMember").on("click", function () {
		location.href = "AccountManagementServlet?memberId="+$(this).attr("data-id");
	});
	//문의 상세보기
	$(".oneQuestion").on("click", function () {
		location.href = "QuestionOneSelect?USERID=admin1&Q_ID="+$(this).attr("data-id")+"&before=myQuestion";
	});
	
});
</script>


<c:choose>
	<c:when test="${fn:length(orderList) > 5}"><c:set var="orderListSize" value="4"/></c:when>
	<c:otherwise><c:set var="orderListSize" value="${fn:length(orderList)}"/></c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${fn:length(memberList) > 5}"><c:set var="memberListSize" value="4"/></c:when>
	<c:otherwise><c:set var="memberListSize" value="${fn:length(memberList)}"/></c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${fn:length(questionList) > 5}"><c:set var="qListSize" value="4"/></c:when>
	<c:otherwise><c:set var="qListSize" value="${fn:length(questionList)}"/></c:otherwise>
</c:choose>


<div class="container mt-5">

<div class="row">

  <div class="col-md-4">
	<div class="card">
	  <div class="card-body text-center">
	    <h5 class="card-title">총 판매액</h5>
	    <h2 class="card-text">${sales}</h2>
	    <h6 class="card-text percent" data-n="${salesIncrease}">${salesIncrease}</h6>
	  </div>
	</div>
  </div>
  
  <div class="col-md-4">
	<div class="card">
	  <div class="card-body text-center">
	    <h5 class="card-title">회원수</h5>
	    <h2 class="card-text">${member}</h2>
	    <h6 class="card-text percent" data-n="${memberIncrease}">${memberIncrease}</h6>
	  </div>
	</div>
  </div>
  
  <div class="col-md-4">
	<div class="card">
	  <div class="card-body text-center">
	    <h5 class="card-title">오늘 방문자수</h5>
	    <h2 class="card-text">${todayVisit}</h2>
	    <h6 class="card-text percent" data-n="${visitIncrease}">${visitIncrease}</h6>
	  </div>
	</div>
  </div>
  
  <div class="col-md-4 mt-5">
    <div class="card">
	  <div class="card-body text-center">
	    <h5 class="card-title">신규 주문 ${fn:length(orderList)}건</h5>
	    <table class="card-text w-100">
	    	<tr>
	    		<th>번호</th>
	    		<th>주문자</th>
	    		<th>상품명</th>
	    		<th>가격</th>
	    	</tr>
	    	
	      <c:forEach var="o" items="${orderList}" end="${orderListSize}">
	      		<c:choose>
	      		  <c:when test="${fn:length(o.p_name) > 8}"><c:set var="p_name" value="${fn:substring(o.p_name,0,8)}..."/></c:when>
	      		  <c:otherwise><c:set var="p_name" value="${o.p_name}"/></c:otherwise>
	      		</c:choose>
	    	<tr>
	    		<td>${o.order_id}</td>
	    		<td>${o.userid}</td>
	    		<td>${p_name}</td>
	    		<td>${o.total_price}</td>
	    	</tr>
	      </c:forEach>
	    	
	    </table>
	    <c:if test="${orderListSize == 0}"><br>신규 주문이 없습니다.<br></c:if>
	    <div class="card-text">
	      <div class="float-end">
		    <small>
		    	<a href="/zzp/admin/order">more</a>
		    </small>
		  </div>
	    </div>
	  </div>
	</div>
  </div>
  
  
  <div class="col-md-4 mt-5">
    <div class="card">
	  <div class="card-body text-center">
	    <h5 class="card-title">신규 회원 ${fn:length(memberList)}명</h5>
	    <table class="card-text w-100">
	    	<tr>
	    		<th>아이디</th>
	    		<th>이름</th>
	    		<th>이메일</th>
	    	</tr>
	    	
	    <c:forEach var="m" items="${memberList}" end="${memberListSize}">
	    	<tr class="oneMember" data-id="${m.userid}">
	    		<td>${m.userid}</td>
	    		<td>${m.username}</td>
	    		<td>${m.email1}@${m.email2}</td>
	    	</tr>
	    </c:forEach>
	    
	    </table>
	    <c:if test="${memberListSize == 0}"><br>신규 회원이 없습니다.<br></c:if>
	    <div class="card-text">
	      <div class="float-end">
		    <small>
		    	<a href="/zzp/admin/member">more</a>
		    </small>
		  </div>
	    </div>
	  </div>
	</div>
  </div>
  
  
  <div class="col-md-4 mt-5">
    <div class="card">
	  <div class="card-body text-center">
	    <h5 class="card-title">답변대기 문의 ${fn:length(questionList)}건</h5>
	    <table class="card-text w-100">
	    	<tr>
	    		<th>번호</th>
	    		<th>작성자</th>
	    		<th>제목</th>
	    	</tr>
	    	
	      <c:forEach var="q" items="${questionList}" end="${qListSize}">
	      		<c:choose>
	      		  <c:when test="${fn:length(q.q_title) > 10}"><c:set var="title" value="${fn:substring(q.q_title,0,10)}..."/></c:when>
	      		  <c:otherwise><c:set var="title" value="${q.q_title}"/></c:otherwise>
	      		</c:choose>
	    	<tr class="oneQuestion" data-id="${q.q_id}">
	    		<td>${q.q_id}</td>
	    		<td>${q.userid}</td>
	    		<td>${title}</td>
	    	</tr>
	      </c:forEach>
	    
	    </table>
	    <c:if test="${qListSize == 0}"><br>답변대기 문의가 없습니다.<br></c:if>
	    <div class="card-text">
	      <div class="float-end">
		    <small>
		    	<a href="/zzp/qna">more</a>
		    </small>
		  </div>
	    </div>
	  </div>
	</div>
  </div>
  
  
  
  
</div>
</div>