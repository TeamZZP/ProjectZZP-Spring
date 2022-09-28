<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://kit.fontawesome.com/a4e70846ef.js" crossorigin="anonymous"></script>
<style>

#adminNav {
	text-indent: 20px;
	height: 500px;
}
#adminNav ul {
	width: 230px;
	margin: 0;
	padding: 0;
}
#adminNav .nav-link, #adminNav .submenu-link {
	display: block;
	padding: 8px;
	text-decoration: none;
	color: black;
}
#adminNav .submenu-link {
	margin-left: 75px;
	border-left: thin;
	border-left-style: solid;
}
#adminNav .nav-link:hover, #adminNav .submenu-link:hover {
	color: green !important;
	font-weight: bold;
	cursor: pointer;
}
.submenu-link {
	margin-left: 30px;
}
.storeSubMenu {
	margin-left: 50px;
}
.challSubMenu {
	margin-left: 52px;
}

</style>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function () {
	$(".category").click(function() {
		let category = $(this).attr("data-category");
		console.log(category);
		location.href="/zzp/admin/"+category; 
	});
	
	$('.store').on('click', function () {
		$('.storeSubMenu').toggleClass('fa-chevron-up')
		$('.storeSubMenu').toggleClass('fa-chevron-down')
	})
	$('.challengeBoard').on('click', function () {
		$('.challSubMenu').toggleClass('fa-chevron-up')
		$('.challSubMenu').toggleClass('fa-chevron-down')
	})
	
});
</script>

<div id="adminNav" class="col-lg-2 float-md-start">
	<ul class="nav flex-column">
	  <li class="nav-item">
	    <a class="nav-link dashboard" aria-current="page" href="/zzp/admin"><i class="fa-solid fa-house me-3"></i>Dashboard</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link category member" data-category="member" id="memberManagement"><i class="fa-solid fa-user-gear me-3"></i>회원관리</a>
	  </li>
	  <li class="nav-item has-submenu">
	    <a class="nav-link submenu-toggle store" href="#" data-bs-toggle="collapse" 
	    		data-bs-target="#submenu-1" aria-expanded="true" aria-controls="submenu-1"><i class="fa-solid fa-store me-3"></i>스토어 <i class="storeSubMenu fa-solid fa-chevron-up"></i></a>
			<div id="submenu-1" class="collapse submenu submenu-1 show" data-bs-parent="#menu-accordion">
				<ul class="submenu-list list-unstyled">
					<li class="submenu-item"><a class="submenu-link category product" data-category="product" id="productManagement">상품관리</a></li>
					<li class="submenu-item"><a class="submenu-link category order" data-category="order" id="orderManagement">주문관리</a></li>
					<li class="submenu-item"><a class="submenu-link category coupon" data-category="coupon" id="couponManagement">쿠폰관리</a></li>
				</ul>
			</div>
	  </li>
	  <li class="nav-item has-submenu">
	    <a class="nav-link submenu-toggle challengeBoard" href="#" data-bs-toggle="collapse" 
	    		data-bs-target="#submenu-2" aria-expanded="true" aria-controls="submenu-1"><i class="fa-solid fa-certificate me-3"></i>챌린지 <i class="challSubMenu fa-solid fa-chevron-up"></i></a>
			<div id="submenu-2" class="collapse submenu submenu-2 show" data-bs-parent="#menu-accordion">
				<ul class="submenu-list list-unstyled">
					<li class="submenu-item"><a class="submenu-link category challenge" data-category="challenge" id="challengeManagement">챌린지관리</a></li>
					<li class="submenu-item"><a class="submenu-link category report" data-category="report" id="reportManagement">신고관리</a></li>
				</ul>
			</div>
	  </li>
	</ul>
</div>
