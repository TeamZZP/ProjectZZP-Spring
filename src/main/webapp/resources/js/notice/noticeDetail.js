$(document).ready(function () {
	$("#noticeUpdate").click(function() {
		$("form").attr("method", "get").attr("action", "/zzp/notice/write/${nDTO.notice_id}");
	});
	$("#noticeDelete").click(function() {
		$("form").attr("action", "/zzp/notice/${nDTO.notice_id}");
	});
});//end ready