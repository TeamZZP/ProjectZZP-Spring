<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	a {
		text-decoration: none;
		color: green;
	}
</style>  
  
<div style="text-align: center;">
	<img alt="소개" src="/zzp/resources/images/introduction/int.png" width="130px" height="50px"><br>
	<br>
	<hr>
	<img alt="소개" src="/zzp/resources/images/introduction/int1.png"><br>
	<br>
	<img alt="소개" src="/zzp/resources/images/introduction/int2.png"><br>
	<br>
	<img alt="소개" src="/zzp/resources/images/introduction/int3.png"><br>
	<br>
	<img alt="소개" src="/zzp/resources/images/introduction/int4.png">
	<br>
</div>

<div class="container row mt-5 justify-content-center">
<div class="col-md-4"></div>
    <div class="col-md-8">
       <table>
       	<tr>
       		<td><div class="text-center" id="map" style="width:450px;height:350px;"></div></td>
       		<td>
       		<div class="ms-2"><span style="font-size: 20px;">찾아오시는 길</span><br><br>
       		서울 강남구 테헤란로 124 삼원타워 5층<br>
			(우) 06234(지번) 역삼동 823<br>
			<a href="https://map.kakao.com/link/search/에이콘아카데미강남" target="_blank">카카오지도로 보기</a>
			</div>
       		</td>
       	</tr>
       </table>
	</div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2b4ec8810c86c5e20ae7720b969e7fb1"></script>
<script type="text/javascript">
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(37.4988896, 127.0315494), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
	};
	
	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
	var imageSrc = '/zzp/resources/images/introduction/marker.png', // 마커이미지의 주소입니다    
    imageSize = new kakao.maps.Size(48, 69), // 마커이미지의 크기입니다
    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
      
	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	    markerPosition = new kakao.maps.LatLng(37.4988896, 127.0315494); // 마커가 표시될 위치입니다
	
	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition, 
	    image: markerImage // 마커이미지 설정 
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);  
</script>