$(document).ready(function () {
	$("#noticeUpdate").click(function() {
		$("form").attr("method", "get").attr("action", "../notice/write/${nDTO.notice_id}");
	});
	$("#noticeDelete").click(function() {
		$("form").attr("action", "../notice/${nDTO.notice_id}");
	});
});//end ready