function totalprice(){
		var sum_money = 0;
		$(".item_price").each(function(idx,data){
			sum_money += Number.parseInt($(data).text());
		});
		$("#sum_money").text(sum_money+"원");
	 	var fee = sum_money >= 50000 ? 0 : 3000;
		var total = sum_money+fee;
		console.log(sum_money,fee,total);
		$("#fee").text(fee+"원");
		$("#total").text(total+"원");
	
	}
		
	$(function() {
		
		totalprice(); //합계 구하는 함수 호출
		
		//장바구니 수량 수정
		$(".updBtn").on("click", function() {
			
			var cart_id = $(this).attr("data-xxx"); //장바구니 번호
			var p_selling_price = $(this).attr("data-price"); //상품가격
			var p_amount = $("#cartAmount" + cart_id).val(); //카트번호 이용 class 선택하여 수량을 가져옴
			var sum_money = $(this).attr("data-sum_money"); //총금액
			
			console.log(cart_id, p_selling_price, p_amount)
			
			$.ajax({
				type : "put",
				url : "${contextPath}/cart/"+cart_id,
				data :JSON.stringify( {
					cart_id : cart_id,
					p_amount : p_amount
				}),
				dataType : "text",
				contentType:'application/json;charset=UTF-8',
				success : function(data, status, xhr) {
					
					var sum = p_amount * p_selling_price;
					$("#item_price" + cart_id).text(sum+"원");
					totalprice(); // 수정 후 합계부분 다시 불러옴
				},
				error : function(xhr, status, error) {
					console.log(error);
				}
				
			}) // end ajax
		})//end updBtn
		
		//개별 삭제
		$(".delBtn").on("click", function() {
			var cart_id = $(this).attr("data-xxx");
			var xxx = $(this); //클릭된 버튼 자체
			console.log("delBtn 클릭"+cart_id);
			
			 $.ajax({
				type : "delete",
				url : "${contextPath}/cart/"+cart_id,
				data :{
					cart_id : cart_id
				},
				dataType : "text",
				success : function(data, status, xhr) {
					//삭제 버튼의 부모 요소 중 tr을 remove
					console.log("성공");
					xxx.parents().filter("tr").remove();  
					totalprice(); // 수정 후 합계부분 다시 불러옴  	
				},
				error : function(xhr, status, error) {
					console.log(error);
				}
				
			}) // end ajax
			
		})//end
		
		//체크박스 미선택시 alert창 / 전체 선택시 전체선택 주소로 이동
		$("#delAllCart").on("click", function() {
			if ($(".individual_cart_checkbox").is(":checked") == false) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("삭제할 상품을 선택하세요.");
				event.preventDefault();
			}
		 	$("form").attr("action", "../cart"); 
		})//체크박스미선택
		
		//폼 제출시 선택된 체크박스 값만 가져오기
	 	$("#order").on("click", function() {
	 		
            var select_obj = $("input[name=check]:checked");
            var p_id = "";
            var p_amount = 0;
            $.each(select_obj, function (i, e) {
             	p_id += $(this).attr("data-p_id")  + ","; 
             });
            location.href = "OrderServlet?p_id="+p_id;	

	 	});//end order
		
	 	
 	//숫자 천단위 ,찍기
 		var sum_money= parseInt($("#sum_money").text());
		var fee = parseInt($("#fee").text());
		var total = parseInt($("#total").text());
		var item_price = parseInt($("span[name=item_price]").text());
		
		$("#sum_money").text(sum_money.toLocaleString('ko-KR')+"원");
		$("#fee").text(fee.toLocaleString('ko-KR')+"원");
		$("#total").text(total.toLocaleString('ko-KR')+"원");
		$("#item_price").text(item_price.toLocaleString('ko-KR')+"원");
		
		
	
		//전체선택
	 	$("#allCheck").on("click", function() {
			console.log("click====");
			if ($(this).is(":checked")) {
				$("input[name=check]").prop("checked", true);//체크박스 전체 선택
				
				var sum_money = $("#sum_money").text();//현재 장바구니 상품 금액
				sum_money = sum_money.replace(/,/g, "");//콤마 제거 문자열 변환
				sum_money = parseInt(sum_money);//정수로
				console.log("장바구니 금액 : "+sum_money);
				
				//체크박스 전체 가격 데이터 더한 값==text()
				$("input[name=check]").each(function (index, data) {
					var cart_id=$(this).val();
					console.log(cart_id);
					
					var item_price = $("#item_price" + cart_id).text();//상품 가격
					item_price = item_price.replace(/,/g, "");//콤마 제거 문자열 변환
					item_price = parseInt(item_price);//정수로
					console.log("상품 가격 : "+item_price);
					
					sum_money =  parseInt(sum_money) + parseInt(item_price);//장바구니에 상품 가격 추가
					console.log("최종 장바구니 가격 : "+sum_money);

					var fee = sum_money >= 50000 ? 0 : 3000;
					var total = sum_money + fee;
					

				});
				var sum_money2=sum_money.toLocaleString('ko-KR')+"원";
				var fee2=fee.toLocaleString('ko-KR')+"원";
				var total2=total.toLocaleString('ko-KR')+"원";
				$("#sum_money").text(sum_money2);
				$("#fee").text(fee2);
				$("#total").text(total2);
			} else {
				$("input[name=check]").prop("checked", false);//체크박스 전체 선택 해제
				
				var sum_money = $("#sum_money").text();//현재 장바구니 상품 금액
				sum_money = sum_money.replace(/,/g, "");//콤마 제거 문자열 변환
				sum_money = parseInt(sum_money);//정수로
				console.log("장바구니 금액 : "+sum_money);
				
				//체크박스 전체 가격 데이터 뺀 값==text()
				$("input[name=check]").each(function (index, data) {
					var cart_id=$(this).val();
					console.log(cart_id);
					
					var item_price = $("#item_price" + cart_id).text();//상품 가격
					item_price = item_price.replace(/,/g, "");//콤마 제거 문자열 변환
					item_price = parseInt(item_price);//정수로
					console.log("상품 가격 : "+item_price);
					
					sum_money =  parseInt(sum_money) - parseInt(item_price);//장바구니에서 상품 가격 빼기
					console.log("최종 장바구니 가격 : "+sum_money);
					var fee = sum_money >= 50000 ? 0 : 3000;
					var total = sum_money + fee;
					
					var sum_money2=sum_money.toLocaleString('ko-KR')+"원";
					var fee2=fee.toLocaleString('ko-KR')+"원";
					var total2=total.toLocaleString('ko-KR')+"원";

					$("#sum_money").text(sum_money2);
					$("#fee").text(fee2);
					$("#total").text(total2);
				});

			}
		})//end fn
		
		//전체선택 안됐을 경우 체크 해제
		$("input[name=check]").click(function() {
			var total = $("input[name=check]").length;
			var checked = $("input[name=check]:checked").length;
	
			if(total != checked) $("#allCheck").prop("checked", false);
			else $("#allCheck").prop("checked", true); 
		});
		
		//개별체크박스 선택시 가격 변동
		$(".individual_cart_checkbox").on("click",function(){
			var n = $(this).val();
			console.log("체크박스의 카트 아이디 : "+n);
			
			var sum_money = $("#sum_money").text();//현재 장바구니 상품 금액
			sum_money = sum_money.replace(/,/g, "");//콤마 제거 문자열 변환
			sum_money = parseInt(sum_money);//정수로 '원' 삭제됨
			console.log("장바구니 금액 : "+sum_money);
			
			var item_price = $("#item_price" + n).text();//상품 가격
			item_price = item_price.replace(/,/g, "");//콤마 제거 문자열 변환
			item_price = parseInt(item_price);//정수로
			console.log("상품 가격 : "+item_price);

			if($(this).is(":checked")==true){
				console.log("check true");
				console.log("체크 된 상품 가격 : "+item_price);
				
				sum_money = sum_money + item_price;//장바구니에 상품 가격 추가

				var fee = sum_money >= 50000 ? 0 : 3000;
				var total = sum_money + fee;
				
				var sum_money2=sum_money.toLocaleString('ko-KR')+"원";
				var fee2=fee.toLocaleString('ko-KR')+"원";
				var total2=total.toLocaleString('ko-KR')+"원";
				$("#sum_money").text(sum_money2);
				$("#fee").text(fee2);
				$("#total").text(total2);
			} else {
				console.log("check false XXX");
				console.log("체크 해제 된 상품 가격 : "+item_price);
				
				console.log(sum_money);
				console.log(item_price);

				sum_money =  sum_money - item_price;//장바구니에서 상품 가격 빼기
				console.log(sum_money);
				
				var fee = sum_money >= 50000 ? 0 : 3000;
				var total = sum_money + fee;

				var sum_money2=sum_money.toLocaleString('ko-KR')+"원";
				var fee2=fee.toLocaleString('ko-KR')+"원";
				var total2=total.toLocaleString('ko-KR')+"원";
				$("#sum_money").text(sum_money2);
				$("#fee").text(fee2);
				$("#total").text(total2);
			}
		})//end individual_cart_checkbox
		

      
    
      
		
		
		
   })//end