<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<style>
	.form-select {
		width: 140px; 
		display: inline;
	}
	.searchValue {
		width: 150px; 
		display: inline;
	}
	.paging {
		cursor: pointer;
	}
	a {
		text-decoration: none;
		color: black;
	}
	.oneReport {
		cursor: pointer;
	}
	.statusChange {
		width: 110px;
	}
	.done {
		color: 	#C0C0C0;
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

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function () {
	//페이징
	$('.paging').on('click', function() {
		$('#page').val($(this).attr('data-page'));
		$('#sortForm').submit();
	})
	//정렬 기준 선택시 form 제출
	$("#status").on("change", function () {
		$("#sortForm").submit();
	});
	//해당 신고글로 이동
	$('.oneReport').on('click', function () {
		let id = $(this).attr('data-id')
		if ($("#content"+id).text()=='(삭제된 글입니다)') {
			$("#modalBtn").trigger("click");
			$("#mesg").text("이미 삭제된 글입니다.");
		} else {
			location.href = '/zzp/admin/report/'+id
		}
	})
	//신고 삭제 모달
 	$("#deleteModal").on("shown.bs.modal", function (e) {
 		let button = e.relatedTarget
 		if (button) {
 			let id = button.getAttribute("data-bs-id")
 			$("#deleteOne").val(id);
		}
	});
	//신고 삭제 모달 끄면 저장된 id 값 삭제
	$('#deleteModal').on('hidden.bs.modal', function () {
		$('#deleteOne').val('');
	});
	//신고 삭제
	$(".delReportBtn").on("click", function (e) {
		let id = [];
		
		//신고 1개 삭제
		if ($('#deleteOne').val()) {
			id.push($('#deleteOne').val())
			
		//신고 여러개 삭제
		} else {
			$('.delCheck:checked').each(function(idx, elem) {
				id.push(elem.value)
			})
		}
		$.ajax({
			url: '/zzp/admin/report',
			type: 'POST',
			traditional: true,
			data: {
				'id':id
			},
			success: function () {
				location.reload();
			},
			error: function () {
				alert('문제가 발생했습니다. 다시 시도해 주세요.');
			}
		})
	});
	//전체 선택 체크박스
	$('#checkAll').on('click', function () {
		$('.delCheck').prop('checked', $(this).prop('checked'))
	})
	//체크박스 선택 검사
	$('.delCheckBtn').on('click', function () {
		if ($('.delCheck:checked').length == 0) {
			$("#modalBtn").trigger("click");
			$("#mesg").text("삭제할 신고를 선택해 주세요.");
		} else {
			$('#deleteModal').modal('toggle')
		}
	})
	//신고 상태 변경
	$('.statusChange').on('change', function () {
		let id = $(this).attr('data-id')
		$.ajax({
			type:"put",
			url:"/zzp/admin/report/"+id,
			headers: {
				"Content-Type":"application/json"
			},
			data: JSON.stringify( 
					{
						'id':id,
						'status':$("#status"+id).val()
					} 
			),
			dataType:"text",
			success: function () {
				location.reload();
			},
			error: function () {
				alert("문제가 발생했습니다. 다시 시도해 주세요.");
			}
		});
	})
	
});
</script>



<div class="container mt-2 mb-2">
	<form id="sortForm" action="/zzp/admin/report">
	<input type="hidden" name="page" value="1" id="page">
	<input type="hidden" name="category" value="report">
		<div class="row">
		  <div class="col">
			  <select name="searchName" class="form-select" data-style="btn-info" id="inputGroupSelect01">
				   <option selected disabled hidden>검색 기준</option>
				   <option value="r.userid" <c:if test="${searchName=='r.userid'}">selected</c:if>>신고자</option>
				   <option value="reported_userid" <c:if test="${searchName=='reported_userid'}">selected</c:if>>작성자</option>
				   <option value="report_created" <c:if test="${searchName=='report_created'}">selected</c:if>>신고일</option>
			  </select>
		  	  <input type="text" class="form-control searchValue" name="searchValue" 
		  	  		<c:if test="${!empty searchValue && searchValue!='null'}">value="${searchValue}"</c:if>>
	      	  <input type="submit" class="btn btn-success" style="margin-top: -5px;" value="검색"></input>
	      </div>
	      <div class="col">
	      	<div class="float-end">
				<select name="status" id="status" class="form-select">
					<option selected disabled hidden>상태</option>
					<option value="0" <c:if test="${status=='0'}">selected</c:if>>처리 대기</option>
					<option value="1" <c:if test="${status=='1'}">selected</c:if>>처리 완료</option>
				</select> 
			</div>
	      </div>
		</div>
	 </form>
</div>


<c:set var="list" value="${pDTO.list}" />
<div class="container col-md-auto">
<div class="row justify-content-md-center">
<input type="hidden" name="report_id" id="deleteOne">

<table class="table table-hover table-sm">
	<tr>
		<th><input type="checkbox" id="checkAll"></th>
		<th>신고 번호</th>
		<th>신고자</th>
		<th>구분</th>
		<th>작성자</th>
		<th>제목 및 내용</th>
		<th>신고사유</th>
		<th>신고일</th>
		<th>상태</th>
		<th>관리</th>
	</tr>
	
<c:forEach var="r" items="${list}">
	<tr id="list" <c:if test="${r.report_status=='처리 완료'}">class="done"</c:if>>
		<td><input type="checkbox" class="delCheck" name="report_id" value="${r.report_id}"></td>
		<td class="oneReport" data-id="${r.report_id}">${r.report_id}</td>
		<td class="oneReport" data-id="${r.report_id}">${r.userid}</td>
		<td class="oneReport" data-id="${r.report_id}">${r.report_category}</td>
		<td class="oneReport" data-id="${r.report_id}">${r.reported_userid}</td>
		<td class="oneReport" data-id="${r.report_id}" id="content${r.report_id}">${r.content}</td>
		<td class="oneReport" data-id="${r.report_id}">${r.report_reason}</td>
		<td class="oneReport" data-id="${r.report_id}">${r.report_created}</td>
		<td>
			<select id="status${r.report_id}" class="statusChange form-select form-select-sm" data-id="${r.report_id}">
			  <option value="0" <c:if test="${r.report_status=='처리 대기'}">selected</c:if>>처리 대기</option>
			  <option value="1" <c:if test="${r.report_status=='처리 완료'}">selected</c:if>>처리 완료</option>
			</select>
		</td>
		<td>
			<button type="button" class="btn btn-outline-dark btn-sm" 
					data-bs-toggle="modal" data-bs-target="#deleteModal" data-bs-id="${r.report_id}">삭제</button>
		</td>
	</tr>
</c:forEach>
	
</table>

	<div>
	  <div class="float-end me-3" style="margin-top: -8px;">
		<button type="button" class="delCheckBtn btn btn-outline-dark btn-sm" style="width: 80px;"
						data-bs-target="#deleteModal" data-bs-id="">선택삭제</button>
	  </div>
	</div>
</div>
</div>

	<!-- 페이징 -->
	<div class="container">
	  <div class="p-2 text-center orderPage">
		  <c:if test="${pDTO.prev}">
		  	<a class="paging" data-page="${pDTO.startPage-1}">prev&nbsp;&nbsp;</a>
		  </c:if>
		  <c:forEach var="p" begin="${pDTO.startPage}" end="${pDTO.endPage}">
			  <c:choose>
		  		<c:when test="${p==pDTO.page}"><b>${p}</b>&nbsp;&nbsp;</c:when>
		  		<c:otherwise><a class="paging" data-page="${p}">${p}&nbsp;&nbsp;</a></c:otherwise>
		  	  </c:choose>
		  </c:forEach>
		  <c:if test="${pDTO.next}">
		  	<a class="paging" data-page="${pDTO.endPage+1}">next</a>
		  </c:if>
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
			        선택한 신고 기록을 삭제하시겠습니까? <br>(게시글은 삭제되지 않습니다.)
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="delReportBtn btn btn-success">삭제</button>
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			      </div>
			    </div> 
			  </div>
			</div> 
			
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
        <button type="button" class="btn btn-success" data-bs-dismiss="modal">확인</button>
		<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
<button type="button" id="modalBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#checkVal">modal</button>