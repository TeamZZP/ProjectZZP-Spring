<%@page import="java.io.Console"%>
<%@page import="java.util.List"%>
<%@page import="com.dto.ChallengeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
</head>
<body>
<!-- 배너 -->
<div id="carouselExampleInterval" class="carousel slide" data-bs-ride="carousel">
   <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="true">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
     </div>
  <div class="carousel-inner">
  	<!-- ZZP소개 -->
    <div class="carousel-item active" data-bs-interval="3000" onclick="javascrip:location.href='about';">
      <img src="resources/images/main/banner_zzp.png" class="d-block w-100" alt="ZZP소개">
    </div>
    <!-- 세일 -->
    <div class="carousel-item" data-bs-interval="3000" onclick="javascrip:location.href='#';">
      <img src="resources/images/main/banner_sale.png" class="d-block w-100" alt="세일">
    </div>
    <!-- 이달의챌린지 -->
    <div class="carousel-item" data-bs-interval="3000" onclick="javascrip:location.href='challenge/${challThisMonth}';">
      <img src="resources/images/main/banner_monthchall.png" class="d-block w-100" alt="이달의챌린지">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
</div>
<br>


<!-- 베스트상품 -->
<div class="container px-4 py-5">
	<nav class="nav" >
	  <b style="font-size: xx-large; color: black;">BEST PRODUCT</b>
	</nav>
</div>
<!-- 베스트상품_carousel -->
<!-- 추가해야함 -->


<!-- middle banner -->
<img src="resources/images/main/banner_middle.png" class="d-block w-100" alt="중간배너">


<!-- 뉴챌린지 -->
<div class="container" style="margin-top: 60px;">
	<ul class="nav justify-content-center" style="margin-bottom: 20px;">
	  <li class="nav-item">
	    <b style="font-size: xx-large; color: green;">NEW CHALLENGE</b>
	  </li>
	</ul>

	<div class="row" style="float: none; margin:100 auto;">
	<%
		int idx3 = 8;
		List<ChallengeDTO> callenge_list = (List<ChallengeDTO>)request.getAttribute("newchall");
		if(callenge_list.size()<8){
			idx3 = callenge_list.size();
		}
			for(int i=0; i<idx3; i++){
				ChallengeDTO dto = callenge_list.get(i);
				int chall_id = dto.getChall_id();
				String chall_img = dto.getChall_img();
				System.out.println(chall_id);
	%>
		<div class="col-lg-3 col-md-6" style="margin-bottom: 5px;">
			<a href="ChallengeDetailServlet?chall_id=<%=chall_id%>">
				<img src="/eclipse/upload/<%=chall_img%>" width="250" height="250" class=" mx-auto d-block" alt="챌린지" onerror="this.src='images/uploadarea.png'">
			</a>
		</div>
	<%
		}
	%>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
</body>
</html>