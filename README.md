# :earth_asia: 지구 지키기 프로젝트 (ZZP)
>제로웨이스트 쇼핑몰&커뮤니티 (Spring 팀프로젝트)<br>
>Demo Link.  http://zzp.co.kr/zzp/ <br>
>+ 쇼핑몰 : 스토어에서 제로웨이스트 관련 상품을 구매
>+ 커뮤니티 : 일상에서 실천 중인 제로웨이스트 생활 방식을 챌린지 사진 게시판에 인증

<br>

## :pushpin: 프로젝트 배경
+ 기후위기에 대한 문제의식에서 출발
+ 하나의 라이프스타일로서 자리잡으며 점차 수요가 증가하는 제로웨이스트 산업에 주목
+ 기본적인 웹 애플리케이션 개발 학습을 위해 쇼핑몰과 게시판 구축

<br>

## :pushpin: 개발기간&참여인원
+ 2022.09.19 ~ 2022.10.14
+ 팀프로젝트 (6명)
  - [✨Cho Yeram](https://github.com/yeramcho) : 팀장, DB 설계, 챌린지 사진게시판, 프로필 페이지, 관리자 페이지, 서버 배포
  - [🐢YeonEy](https://github.com/YeonEy) : DB 설계, 소개 페이지, 공지사항, 문의, 마이페이지 주문내역, 구매후기, 관리자 쿠폰관리
  - [🚀youngin](https://github.com/uyoungin) : 회원가입, 로그인, 메인 뷰 페이지, 관리자 상품관리
  - [😼Who-Are-YOU-Who](https://github.com/Who-Are-YOU-Who) : DB 설계, 스토어 메인, 스토어 상품 상세, 찜 기능, 주문
  - [🐧binsucha](https://github.com/binsucha) : 마이페이지 메인, 마이페이지 배송지 관리, 마이페이지 계정 관리, 관리자 회원관리
  - [🦝dmlwjd1921](https://github.com/dmlwjd1921) : 스토어 상품 상세, 장바구니, 찜 기능, 주문

<br>

## :pushpin: 개발환경
+ OS : Window 10
+ Server
  - Oracle Linux 8.6
  - Apache Tomcat 8.5
+ Database
  - Oracle 11g EX
  - Oracle Cloud
+ Language : Java 8
+ WEB - Front
  - HTML5, CSS3
  - JavaScript, jQuery
  - Bootstrap 5.2
+ WEB - Server
  - JSP
  - Spring Framework 4.3.22
+ Tool
  - Eclipse, STS
  - JDBC, MyBatis

<br>

## :pushpin: 프로젝트 설계
### 화면설계서&기능명세서
+ [ZZP 화면설계서&기능명세서](https://docs.google.com/presentation/d/12npgU4vnXomp_Sd5CBj0koK2aIAaDe6f4Rv5K1_vpQ4/edit#slide=id.g153e7d0feda_2_247)

<br>

### ERD 설계
![ProjectZZP_ERD](https://user-images.githubusercontent.com/109123745/190850775-bc020784-6da3-4f82-a01c-1a40a0c4cea0.png)

<br>

### REST API 네이밍 규칙
+ [Notion](https://catkin-education-eae.notion.site/REST-API-3eddc4066930455c80291259a8319ce3)

<br>

## :pushpin: 주요기능
<details>
<summary>메인</summary>
<img src="https://user-images.githubusercontent.com/109123745/196941417-16415f60-3f06-4586-b642-f2cece2fb229.png">
<img src="https://user-images.githubusercontent.com/109123745/196941428-b1dfc7c0-3fdf-4109-8c42-408a91a5b742.png">
</details>

<details>
<summary>회원가입/로그인</summary>
<img src="https://user-images.githubusercontent.com/109123745/196943451-970f5340-26d7-4538-9715-809bf15b934d.png">
<img src="https://user-images.githubusercontent.com/109123745/196943457-f88fac54-46d9-4f72-94c9-301fa24f5723.png">
<img src="https://user-images.githubusercontent.com/109123745/196943463-e0c06d4d-bb53-45ac-ae39-99e0c0918d47.png">
</details>

<details>
<summary>소개</summary>
<img src="https://user-images.githubusercontent.com/109123745/196943947-5cbc9a4f-20b3-40eb-9f78-bb5d53ce6d8d.png">
</details>

<details>
<summary>스토어</summary>
<img src="https://user-images.githubusercontent.com/109123745/196944198-9ffe8521-d80b-4061-b3d1-74c7a47eee65.png">
<img src="https://user-images.githubusercontent.com/109123745/196944203-ef9d8f5f-3c2c-4e39-8741-d811c45a2df4.png">
<img src="https://user-images.githubusercontent.com/109123745/196944205-327ec48d-b799-4510-9fdd-a86c58c5dddc.png">
<img src="https://user-images.githubusercontent.com/109123745/196944206-f3cc1ce0-3fbf-4541-bdf0-da099b0af5f3.png">
<img src="https://user-images.githubusercontent.com/109123745/196944208-13d45541-38e0-41cf-a968-e23e0d653a9c.png">
<img src="https://user-images.githubusercontent.com/109123745/196944220-b0ec5232-2870-4f72-807b-f46a5529310b.png">
<img src="https://user-images.githubusercontent.com/109123745/196944191-d493c21b-6801-43b5-a80b-aa3980f49158.png">
</details>

<details>
<summary>장바구니/주문</summary>
<img src="https://user-images.githubusercontent.com/109123745/196944699-5124d81c-ca86-4aba-9af5-3685d89c8529.png">
<img src="https://user-images.githubusercontent.com/109123745/196944706-41af1d9a-dc91-4eca-a3c1-7f44b5722f93.png">
<img src="https://user-images.githubusercontent.com/109123745/196944711-73fba0f7-ec8f-4138-a7a5-dd284aa8414b.png">
<img src="https://user-images.githubusercontent.com/109123745/196944716-196b3eea-0876-482f-849f-35e43f03857a.png">
<img src="https://user-images.githubusercontent.com/109123745/196944717-139fad74-8666-4720-bf2c-8ccec2e30303.png">
<img src="https://user-images.githubusercontent.com/109123745/196944720-3811c9b1-3a1e-4b6d-8fad-4679e7da843f.png">
</details>

<details>
<summary>챌린지</summary>
<img src="https://user-images.githubusercontent.com/109123745/196945727-9f39c5dc-81e7-4b9a-bb57-a87bea0f25b5.png">
<img src="https://user-images.githubusercontent.com/109123745/196945737-f9d044a7-9f34-4a9c-847d-7204a5eca2f9.png">
<img src="https://user-images.githubusercontent.com/109123745/196945739-871b7fdb-4e04-41df-8592-6725d923de90.png">
<img src="https://user-images.githubusercontent.com/109123745/196945903-21a023a0-9b4d-461a-98a4-ba42420ee2ae.png">
</details>

<details>
<summary>공지사항</summary>
<img src="https://user-images.githubusercontent.com/109123745/196945005-797c6194-7861-449f-8faf-d37af0f5ae23.png">
<img src="https://user-images.githubusercontent.com/109123745/196945009-f319a0b1-b301-4b7b-9c8e-683346d4be20.png">
<img src="https://user-images.githubusercontent.com/109123745/196945011-634f0387-f252-43ee-9ae2-e9bd2db1af05.png">
</details>

<details>
<summary>문의</summary>
<img src="https://user-images.githubusercontent.com/109123745/196945185-5c31df7c-76a5-4ee0-b30c-e3f4666b8b37.png">
<img src="https://user-images.githubusercontent.com/109123745/196945192-91eb26e1-c237-4a2a-b8f6-6956bb91a089.png">
<img src="https://user-images.githubusercontent.com/109123745/196945195-a328588f-5563-4367-aa2c-ff809332c28b.png">
</details>

<details>
<summary>마이페이지</summary>
<img src="https://user-images.githubusercontent.com/109123745/196945445-9bb39110-edad-4859-89b8-8b9ac4b6cd45.png">
<img src="https://user-images.githubusercontent.com/109123745/196945447-4cee3f18-f1e1-49e0-9a8d-ab747d03ed22.png">
<img src="https://user-images.githubusercontent.com/109123745/196945451-d4b0e4b3-baaf-4acf-8800-f88e1f91edbd.png">
<img src="https://user-images.githubusercontent.com/109123745/196945457-537492fa-b86c-4fd4-85be-ad07d6b5ad64.png">
<img src="https://user-images.githubusercontent.com/109123745/196945461-602b4e4a-1160-4371-8407-4b8c6a594c83.png">
<img src="https://user-images.githubusercontent.com/109123745/196945422-183e2b01-d7e3-49e9-85c9-bfc72771639c.png">
<img src="https://user-images.githubusercontent.com/109123745/196945429-1f5158ea-4dfd-40c9-ab47-6565fe516c92.png">
<img src="https://user-images.githubusercontent.com/109123745/196945432-7fb1c5cd-9643-488d-a88d-ce9645d376a8.png">
<img src="https://user-images.githubusercontent.com/109123745/196945437-d581d8c2-8e28-4f76-b722-c34c818e6e1b.png">
<img src="https://user-images.githubusercontent.com/109123745/196945440-74dddb19-55b5-4f42-a17f-abbf68c740a9.png">
</details>

<details>
<summary>관리자페이지</summary>
<img src="https://user-images.githubusercontent.com/109123745/196946004-e2d697d8-10b8-41c9-bff2-2eb3a633704a.png">
<img src="https://user-images.githubusercontent.com/109123745/196946011-651a6faa-5593-4b63-bb82-b5aa2df9a63d.png">
<img src="https://user-images.githubusercontent.com/109123745/196946017-e80e682c-4751-487f-b542-a521235507f5.png">
<img src="https://user-images.githubusercontent.com/109123745/196946020-8da24a0e-da27-4c15-baba-b5f054764321.png">
<img src="https://user-images.githubusercontent.com/109123745/196946021-b130cc07-bf35-444f-b17c-2597843c49ff.png">
<img src="https://user-images.githubusercontent.com/109123745/196946023-6b2494fe-e079-4ff2-8e7e-83ae2ee4df44.png">
<img src="https://user-images.githubusercontent.com/109123745/196946026-fe23e01f-ba8b-4916-950e-20d244ee79ef.png">
<img src="https://user-images.githubusercontent.com/109123745/196946029-28799751-10e9-427a-b2e0-0aeb6f3c15cc.png">
<img src="https://user-images.githubusercontent.com/109123745/196946031-42e5ecaf-e955-4ff4-9730-40cb50cd08c2.png">
<img src="https://user-images.githubusercontent.com/109123745/196946035-363c007c-9dac-48d1-b38f-277603b4ed1b.png">
<img src="https://user-images.githubusercontent.com/109123745/196946044-919c1b93-a17c-44ee-8d66-af19eb23158a.png">
</details>

<br>

