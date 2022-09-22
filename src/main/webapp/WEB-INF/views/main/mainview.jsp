<%@page import="java.io.Console"%>
<%@page import="java.util.List"%>
<%@page import="com.dto.ChallengeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
<style type="text/css">
 .retrieve{
  cursor: pointer;
 }
 
 #card{
 height: 25;
 width: 15;
 }
</style>
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
    <div class="carousel-item active" data-bs-interval="3000" onclick="javascrip:location.href='IntroductionUIServlet';">
      <img src="resources/images/main/banner_zzp.png" class="d-block w-100" alt="ZZP소개">
    </div>
    <!-- 타임세일 -->
    <div class="carousel-item" data-bs-interval="3000" onclick="javascrip:location.href='ProductSearchServlet?c_id=6';">
      <img src="resources/images/main/banner_sale.png" class="d-block w-100" alt="타임세일">
    </div>
   <%--  <%
    	ChallengeDTO challThisMonth = (ChallengeDTO) request.getAttribute("challThisMonth");
    %> --%>
    <!-- 이달의챌린지 -->
    <div class="carousel-item" data-bs-interval="3000" onclick="javascrip:location.href='#';">
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
<!-- 추가해야함 -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
</body>
</html>