<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
	a {
		text-decoration: none;
		color: black;
	}
	.img {
		border-radius: 15px;
	}
	.category:hover {
  		color: green;
		font-weight: bold;
		cursor: pointer;
	}
</style>

<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		$("body").on("click", ".category", function () {
			let category = $(this).attr("data-category")
			if (category == 'all') {
				location.href = '/zzp/profile/${profile.userid}'
			} else {
				$.ajax({
					type:"get",
					url:"/zzp/profile/${profile.userid}/"+category,
					data: {
						userid:"${profile.userid}",
						category:category
					},
					dataType:"html",
					success: function (data) {
						$("#profileContent").html(data);
					},
					error: function () {
						alert("문제가 발생했습니다. 다시 시도해 주세요.");
					}
				});
			}
		});
	});
</script>


<div class="col-lg-1 float-md-start">
	   <ul class="mt-5">
	     <li class="nav-link px-2 mb-1 link-dark"><a class="category" data-category="all">모두보기</a></li>
	     <li class="nav-link px-2 mb-1 link-dark"><a class="category" data-category="review">구매후기</a></li>
	     <li class="nav-link px-2 mb-1 link-dark"><a class="category" data-category="challenge">챌린지</a></li>
	     <li class="nav-link px-2 mb-1 link-dark"><a class="category" data-category="stamp">도장</a></li>
	   </ul>
</div>



<div class="container">
  <div class="row">
  
    <div class="col-lg-3 p-5">
		<div class="card" style="width: 100%; height: 22rem;">
		  <div class="text-center">
	      <img class="card-img-top w-50 pt-4" src="/zzp/resources/upload/profile/${profile.profile_img}"><br>
	      </div>
	        <div class="card-body mt-4">
		      <h3 class="card-title text-center fw-bold">${profile.userid}</h3>
		      <p class="card-text text-center">${profile.profile_txt}</p>
		    </div>
		      <c:if test="${!empty login and login.userid==profile.userid}">
		      	<div><a href="/zzp/mypage/${login.userid}" class="float-end p-2">마이페이지</a></div>
		      </c:if>
		</div>
	</div>
	
	
	<div id="profileContent" class="col-lg-9 p-5">
	
	
	
		<div>
		  <div class="row p-2 mx-4">
		    <div class="col">구매후기 <span class="text-success fw-bold">${rPDTO.totalCount}</span></div>
			 <div class="col"><div class="float-end"><small><a class="category" data-category="review">전체보기</a></small></div></div>
		  </div>
		  <div class="text-center mt-2">
		        <c:forEach var="r" items="${rPDTO.list}">
		        <a href="/zzp/product/${r.p_id}"> 
					<img src="/zzp/resources/images/product/p_image/${r.image_route}" border="0" align="middle" class="img"
						width="200" height="200" onerror="this.src='/zzp/resources/images/challenge/uploadarea.png'"></a>
			    </c:forEach> 
			    <c:set var="rLength" value="${fn:length(rPDTO.list)}"/>
			    <c:if test="${rLength < 4}">
			    	<c:forEach begin="1" end="${4 - rLength}">
			    		<img src="/zzp/resources/images/challenge/none.png" class="img" width="200" height="200" >
			    	</c:forEach>
			    </c:if>
	      </div>
		</div><!-- end review -->
		
		
	
		<div>
		  <div class="row p-2 mx-4 mt-5">
		    <div class="col">챌린지 <span class="text-success fw-bold">${cPDTO.totalCount}</span></div>
			 <div class="col"><div class="float-end"><small><a class="category" data-category="challenge">전체보기</a></small></div></div>
		  </div>
		  <div class="text-center mt-2">
		        <c:forEach var="c" items="${cPDTO.list}">
		        <a href="/zzp/challenge/${c.chall_id}"> 
					<img src="/zzp/resources/upload/challenge/${c.chall_img}" border="0" align="middle" class="img"
						width="200" height="200" onerror="this.src='/zzp/resources/images/challenge/uploadarea.png'"></a>
		        </c:forEach> 
			    <c:set var="cLength" value="${fn:length(cPDTO.list)}"/>
			    <c:if test="${cLength < 4}">
			    	<c:forEach begin="1" end="${4 - cLength}">
			    		<img src="/zzp/resources/images/challenge/none.png" class="img" width="200" height="200" >
			    	</c:forEach>
			    </c:if>
	      </div>
		</div><!-- end challenge -->
		
		
		
		<div>
		  <div class="row p-2 mx-4 mt-5">
		    <div class="col">도장 <span class="text-success fw-bold">${stampTotalNum}</span></div>
			 <div class="col"><div class="float-end"><small><a class="category" data-category="stamp">전체보기</a></small></div></div>
		  </div>
		  <div class="text-center mt-2">
		        <c:forEach var="s" items="${sPDTO.list}">
					<img src="/zzp/resources/upload/challenge/${s.stamp_img}" border="0" align="middle" class="img"
						width="200" height="200" onerror="this.src='/zzp/resources/images/challenge/uploadarea.png'"
						 data-bs-toggle="modal" data-bs-target="#stampModal${s.stamp_id}">
						<!-- Modal -->
							<div class="modal fade" id="stampModal${s.stamp_id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							  <div class="modal-dialog">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="exampleModalLabel">${s.stamp_name}</h5>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div>
							      <div class="modal-body text-center">
							      <img src="/zzp/resources/upload/challenge/${s.stamp_img}" width="400">
							      </div>
							      <div class="modal-footer mb-3 text-center">
							       ${s.stamp_content}
							      </div>
							    </div>
							  </div>
							</div>
		        </c:forEach> 
			    <c:set var="sLength" value="${fn:length(sPDTO.list)}"/>
			    <c:if test="${sLength < 4}">
			    	<c:forEach begin="1" end="${4 - sLength}">
			    		<img src="/zzp/resources/images/challenge/none.png" class="img" width="200" height="200" >
			    	</c:forEach>
			    </c:if>
	      </div>
		</div><!-- end stamp -->
		
		
		
		
		
	</div><!-- end profileContent -->
	
	
  </div><!-- end row -->

   
        
     
     
</div><!-- end container -->

