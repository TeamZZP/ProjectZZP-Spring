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
    <div class="carousel-item" data-bs-interval="3000" onclick="javascrip:location.href='store/6';">
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
<div id="carouselExampleInterval2" class="carousel slide" style="margin-top: -130px;">
  <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="true">
  <div class="carousel-inner">
  	<!-- carousel_1 -->
    <div class="carousel-item active" data-bs-interval="false">
      <div class="container px-4 py-5" id="custom-cards">
	    <div class="row row-cols-1 row-cols-lg-3 align-items-stretch g-4 py-5">
	    <c:set var="idx" value="2"></c:set>
	    <c:if test="${fn:length(bestProdudctlist)<2}">
	    	<c:set var="idx" value="${fn:length(bestProdudctlist)}"></c:set>
	    </c:if>
	    <c:forEach var="p" items="${bestProdudctlist}" begin="0" end="${idx}">
	      <div class="col retrieve" onclick="javascrip:location.href='productRetrieve?p_id=${p.p_id}';">
	        <div class="card card-cover h-100 overflow-hidden text-bg-dark rounded-4 shadow-lg" 
	        	style="background-image: url('resources/images/product/p_image/${p.p_image}'); background-size:cover;">
	          <div class="d-flex flex-column h-100 p-5 pb-3 text-white fw-bold text-shadow-1">
	            <h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold text-shadow-1">${p.p_content}</h2>
	            <ul class="d-flex list-unstyled mt-auto">
	              <li class="me-auto">
	              </li>
	              <li class="d-flex align-items-center me-3">
	                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#geo-fill"></use></svg>
	                <small>${p.p_name}</small>
	              </li>
	              <li class="d-flex align-items-center">
	                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#calendar3"></use></svg>
	                <small>${p.p_selling_price}</small>
	              </li>
	            </ul>
	          </div>
	        </div>
	      </div>
	      </c:forEach>
	    </div>
  	  </div>
    </div>
    <!-- carousel_2 -->
    <div class="carousel-item" data-bs-interval="false">
      <div class="container px-4 py-5" id="custom-cards">
	    <div class="row row-cols-1 row-cols-lg-3 align-items-stretch g-4 py-5">
	    <c:set var="idx2" value="5"></c:set>
	    <c:if test="${fn:length(bestProdudctlist)<5}">
	    	<c:set var="idx2" value="${fn:length(bestProdudctlist)}"></c:set>
	    </c:if>
	    <c:forEach var="p" items="${bestProdudctlist}" begin="3" end="${idx2}">
	   	<div class="col retrieve" onclick="javascrip:location.href='productRetrieve?p_id=${p.p_id}';">
	        <div class="card card-cover h-100 overflow-hidden text-bg-dark rounded-4 shadow-lg" 
	        	style="background-image: url('resources/images/product/p_image/${p.p_image}'); background-size:cover;">
	          <div class="d-flex flex-column h-100 p-5 pb-3 text-white fw-bold text-shadow-1">
	            <h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold text-shadow-1">${p.p_content}</h2>
	            <ul class="d-flex list-unstyled mt-auto">
	              <li class="me-auto">
	              </li>
	              <li class="d-flex align-items-center me-3">
	                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#geo-fill"></use></svg>
	                <small>${p.p_name}</small>
	              </li>
	              <li class="d-flex align-items-center">
	                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#calendar3"></use></svg>
	                <small>${p.p_selling_price}</small>
	              </li>
	            </ul>
	          </div>
	        </div>
	      </div>
        </c:forEach>
	    </div>
  	  </div>
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleInterval2" data-bs-slide="prev">
    <span class="carousel-control-prev-icon"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleInterval2" data-bs-slide="next">
    <span class="carousel-control-next-icon"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
</div>


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
		<c:set var="idx" value="7"></c:set> 
		<c:if test="${fn:length(callenge_list)<7}">
			<c:set var="idx" value="${fn:length(callenge_list)}"></c:set>
		</c:if>
		<c:forEach var="c" items="${callenge_list}" begin="0" end="${idx}" >
			<div class="col-lg-3 col-md-6" style="margin-bottom: 5px;">
				<a href="challenge/${c.chall_id}">
					<img src="resources/upload/challenge/${c.chall_img}" width="250" height="250" class=" mx-auto d-block" alt="챌린지" onerror="this.src='resources/images/challenge/uploadarea.png'">
				</a>
			</div>
		</c:forEach>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
</body>
</html>