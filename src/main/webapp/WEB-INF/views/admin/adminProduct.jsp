<%@page import="com.dto.PageDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
	#search {
		text-decoration: none;
		color: black;
	}
	.form-select {
		width: 140px; 
		display: inline;
	}
	.searchValue {
		width: 150px; 
		display: inline;
	}
	.productDetail{
		cursor: pointer;
	}
	.modal-body{
		text-align: center;
	}	
	#mesg{
		margin: 0;
	}
	#modalBtn{
		display: none;
	}
</style>
<!-- 메세지 있는 경우 modal 일단 지움* 메세지 안 뜨면 jstl로 바꿔서 추가하기 -->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script>
	$(document).ready(function () {
		//관리자페이지 카테고리
		$(".category").click(function() {
			let category = $(this).attr("data-category");
			location.href="AdminCategoryServlet?category="+category;
		});
		//페이징
 		$('.paging').on('click', function() {
			$('#page').val($(this).attr('data-page'));
			$('form').attr('action', 'admin/product').submit();
		})
		//상품검색
		$("#searchProd").click(function() {
			$("#sortForm").submit();
		});
		//정렬 기준 선택시 form 제출
		$("#sortBy").on("change", function () {
			$("#sortForm").submit();
		});
		//상품등록 버튼
		$("#addProduct").click(function() {
			location.href="../adminProductAdd.jsp";
		});
		//상품 상세페이지
		$(".productDetail").click(function() {
			let p_id = $(this).attr("data-p_id");
			location.href="AdminProdDetailServlet?p_id="+p_id;
		});
		//상품보기 버튼
		$("body").on("click", "#prodDetail", function () {
			let p_id = $(this).attr("data-id");
			location.href="ProductRetrieveServlet?p_id="+p_id;
		});
		//삭제 모달
		$("#deleteModal").on("shown.bs.modal", function (e) { //삭제모달 띄우면 발생하는 이벤트
 		let button = e.relatedTarget //삭제모달 띄우려고 누른 버튼
 		if (button) {
 			let id = button.getAttribute("data-bs-id") //삭제모달띄우는 버튼의 data-bs-id값
 			$("#delp_id").val(id); //삭제 시 넘어가는 p_id 값으로 설정
		}
		});
		//상품삭제 버튼
		$(".delProdBtn").on("click", function (e) { //삭제모달 안의 확인버튼
			$('#prodForm').attr('action', 'ProductDeleteServlet').submit() //form 제출
		});
		//체크박스 전체선택
		$("#checkAll").click(function() {
			$(".delCheck").prop('checked', $(this).prop('checked'));
		});
		//체크박스 선택 삭제
		$(".delCheckBtn").click(function() {
			if ($('.delCheck:checked').length == 0) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("삭제할 상품을 선택해 주세요.");
			} else {
				$("#modalBtn").trigger("click");
				$("#mesg").text("선택한 상품을 삭제하시겠습니까?"); //확인 클릭 시 prodForm이 submit됨
			}
		});
		
	});//end ready
	
</script>
<%
	PageDTO pDTO = (PageDTO) request.getAttribute("pDTO");
	List<CategoryProductDTO> product_list = pDTO.getList();
	String searchName = (String) request.getAttribute("searchName");
	String searchValue = (String) request.getAttribute("searchValue");
	String sortBy = (String) request.getAttribute("sortBy");
%>

<c:set value="${pDTO.list}" var="product_list" />

<!-- 검색 / 정렬 -->
<div class="container mt-2 mb-2">
	<form action="AdminCategoryServlet" id="sortForm">
	<input type="hidden" name="category" value="product">
		<div class="row">
			<!-- 검색 -->
			<div class="col">
				<select class="form-select sortBy" name="searchName" data-style="btn-info" id="inputGroupSelect01">
					<option selected disabled hidden>검색 기준</option>
					<option value="c_id" <% if("c_id".equals(searchName)){%> selected
					<%}%>>카테고리</option>
					<option value="p_id" <% if("p_id".equals(searchName)){%> selected
					<%}%>>상품번호</option>
					<option value="p_name" <% if("p_name".equals(searchName)){%>
					selected <%}%>>상품명</option>
					<option value="p_selling_price"
					<% if("p_selling_price".equals(searchName)){%> selected <%}%>>판매가</option>
					<option value="p_created" <% if("p_created".equals(searchName)){%>
					selected <%}%>>등록일</option>
				</select> 
				<input type="text" name="searchValue" class="form-control searchValue" 
				<% if(searchValue!=null && !searchValue.equals("null")) {%>value="<%= searchValue %>"<% } %>>
				<button type="button" class="btn btn-success" id="searchProd" style="margin-top: -5px;">검색</button>
			</div>
			<!-- 정렬 -->
			<div class="col">
				<div class="float-end">
				<select class="form-select sortBy" name="sortBy" id="sortBy" data-style="btn-info">
					<option selected disabled hidden>정렬</option>
					<option value="p_id" <% if("p_id".equals(sortBy)){%>selected<%}%>>최신상품순</option>
					<option value="p_selling_price" <% if("p_selling_price".equals(sortBy)){%>selected<%}%>>판매가순</option>
					<option value="p_name" <% if("p_name".equals(sortBy)){%>selected<%}%>>상품명순</option>
					<option value="p_stock" <% if("p_stock".equals(sortBy)){%>selected<%}%>>재고순</option>
				</select>
				<a href="adminProductAdd.jsp" class="btn btn-success" style="margin-top: -5px;">상품등록</a>
				</div>
			</div>
		</div>
	</form> 
</div>

<!-- product_list 출력 -->
<div class="container col-md-auto">
<div class="row justify-content-md-center">
	<form id="prodForm">
	<input type="hidden" name="curPage" value="<%= pDTO.getCurPage() %>">
	<input type="hidden" name="searchName" value="<%= searchName %>">
	<input type="hidden" name="searchValue" value="<%= searchValue %>">
	<input type="hidden" name="sortBy" value="<%= sortBy %>">
	<input type="hidden" name="category" value="product">
	<input type="hidden" name="p_id" id="delp_id">
	<!-- 상품 List -->	
	<table class="table table-hover table-sm">
		<tr>
			<th><input type="checkbox" id="checkAll"></th>
			<th>상품번호</th>
			<th>카테고리</th>
			<th>상품명</th>
			<th>판매가</th>
			<th>할인</th>
			<th>재고</th>
			<th>등록일</th>
			<th>관리</th>
		</tr>
		<%
		for ( int i = 0 ; i < product_list.size() ; i++ ) {
		    int p_id = product_list.get(i).getP_id(); //상품번호
		    String p_name =product_list.get(i).getP_name(); //상품이름
			String p_content =product_list.get(i).getP_content(); //상품설명
			int c_id =product_list.get(i).getC_id(); //카테고리 번호
			int p_cost_price =product_list.get(i).getP_cost_price(); //판매가
			int p_selling_price =product_list.get(i).getP_selling_price(); //할인적용판매가
			int p_discount =product_list.get(i).getP_discount(); //할인
			String p_created=product_list.get(i).getP_created(); //등록일
			int p_stock =product_list.get(i).getP_stock(); // 재고
			String p_image = product_list.get(i).getP_image(); //이미지
			
		%>
		<tr id="list">
			<td><input type="checkbox" class="delCheck" name="p_id" value="<%= p_id %>"></td>
			<td class="productDetail" data-p_id="<%= p_id %>"><%= p_id %></td>
			<td class="productDetail" data-p_id="<%= p_id %>">
			<% if(6==c_id) {%>sale<%} %>
			<% if(8==c_id) {%>bath<%} %>
			<% if(9==c_id) {%>kitchen<%} %>
			<% if(10==c_id) {%>life<%} %>
			</td>
			<td class="productDetail" data-p_id="<%= p_id %>"><%= p_name %></td>
			<td class="productDetail" data-p_id="<%= p_id %>"><%= p_selling_price %>&nbsp;</td>
			<td class="productDetail" data-p_id="<%= p_id %>"><%= p_discount %></td>
			<td class="productDetail" data-p_id="<%= p_id %>"><%= p_stock %>&nbsp;&nbsp;</td>
			<td class="productDetail" data-p_id="<%= p_id %>"><%= p_created %></td>
			<td>
			<!-- 모달버튼 -->
			<button type="button" id="prodDetail" data-id="<%= p_id %>" class="btn btn-outline-success btn-sm">상품보기</button>
			<button type="button" id="delPopup<%= p_id %>" data-bs-id="<%= p_id %>" class="btn btn-outline-dark btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal">
					삭제
			</button>
			</td>
			<%		
			}	
			%>
		</tr>
	</table>
	</form>
	<!-- 선택삭제 -->
	<div>
		<div class="float-end me-3" style="margin-top: -8px;">
			<button type="button" class="delCheckBtn btn btn-outline-dark btn-sm" style="width: 80px;"
			data-bs-target="#deleteModal" data-bs-id="">선택삭제</button>
		</div>
	</div>
	<!-- 페이징 -->
	<div class="p-2 text-center productPage">
	<%
	int curPage = pDTO.getCurPage();
	int perPage = pDTO.getPerPage();
	int totalCount = pDTO.getTotalCount();
	int totalPage = totalCount/perPage;
	if(totalCount%perPage!=0) totalPage++;
	for(int p=1; p<=totalPage; p++){
		if(p==curPage){
			out.print("<b>"+p+"</b>&nbsp;&nbsp;");
		} else {
			out.print("<a id='search' href='AdminCategoryServlet?curPage="+p
	   				+"&searchName="+searchName+"&searchValue="+searchValue
	   				+"&sortBy="+sortBy+"&category=product'>"+p+"</a>&nbsp;&nbsp;");
			}
		} %>
	</div>
</div>
</div>

<!-- Modal -->
<div id="deleteModal" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">ZZP</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        선택한 상품을 삭제하시겠습니까? 
      </div>
      <div class="modal-footer">
        <button type="button" class="delProdBtn btn btn-success">삭제</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div> 
  </div>
</div> 
<!-- Modal2 -->		
<div class="modal fade" id="checkVal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">ZZP</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p id="mesg"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="delProdBtn btn btn-success">확인</button>
		<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
<button type="button" id="modalBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#checkVal">modal</button>