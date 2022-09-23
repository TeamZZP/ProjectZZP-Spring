 	$(document).ready(function () {
 		//정렬 기준 선택시 form 제출
		$("#sortBy").on("change", function () {
			$("form").submit();
		});
		//좋아요 추가/삭제
		$(".liked_area").on("click", ".liked", function () {
			if ("${empty login}" == "true") {
				alert("로그인이 필요합니다.");
			} else {
				let cid = $(this).attr("data-cid");
				$.ajax({
					type:"post",
					url:"challenge/"+cid+"/like",
					data: {
						chall_id:cid,
						userid:"${login.userid}"
					},
					dataType:"text",
					success: function (data) {
						$("#liked_area"+cid+" .liked").attr("src", data);
						countLikes(cid);
					},
					error: function () {
						alert("문제가 발생했습니다. 다시 시도해 주세요.");
					}
				}); 
			}
		});
		//좋아요 개수 구해오기
		function countLikes(cid) {
			$.ajax({
				type:"post",
				url:"LikeCountServlet",
				data: {
					chall_id:cid,
				},
				dataType:"text",
				success: function (data) {
					$("#likeNum"+cid).text(data);
				},
				error: function () {
					alert("문제가 발생했습니다. 다시 시도해 주세요.");
				}
			});
		}
		
		//툴팁 활성화
		let tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
		let tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
				  			return new bootstrap.Tooltip(tooltipTriggerEl)
						})
		
	}); 