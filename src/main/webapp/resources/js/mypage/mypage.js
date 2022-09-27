$(document).ready(function() {
	
	$("#changeImg").on("click", function() {
		$("#openImgModal").trigger("click");
	});//end fn
	$("#changeTxt").on("click", function() {
		$("#openTxtModal").trigger("click");
	});//end fn
	$("#profile_txt").on("click", function() {
		$(this).text("");
	});//end fn
	$("#cancleChangTxt").on("click", function() {
		$("#profile_txt").text("프로필 텍스트");
	});//end fn
	
	//프로필 텍스트 수정 클릭
	$("#submitTxt").on("click", function() {
		var profile_txt=$("#profile_txt").val();//왜 text()는 안 넘어올까
			if (profile_txt.length == 0) {
			event.preventDefault();
			$("#modalBtn").trigger("click");
			$("#mesg").text("변경할 프로필 메세지를 입력하세요.");
		}
	});//end txt
	
	//프로필 이미지 수정 클릭
	$("#submitImg").on("click", function() {
		if ($("#imgFile").val() == "null" || $("#imgFile").val().length == 0) {//이미지 파일이 없을 때
			event.preventDefault();
			alert("사진을 업로드해 주세요.");
		} else if ($("#imgFile").val() != 0 && !checkFileExtension()) {
			console.log("이미지 확장자 검사");
		} else {
			console.log($("#imgFile").val());
			$("form").submit();
		}
	});//end img
	
});//end ready

//이미지 확장자 검사
function checkFileExtension(){ 
	let imgFile = $("#imgFile").val(); 
	let reg = /(.*?)\.(jpg|jpeg|png|gif)$/;
	if (imgFile.match(reg)) {
		return true;
	} else {
		alert("jpg, jpeg, png, gif 파일만 업로드 가능합니다.");
		return false;
	}
}