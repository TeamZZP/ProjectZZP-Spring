<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.dto.ProductDTO"%>
<%@page import="com.dto.MemberDTO"%>
<%@page import="com.dto.ImagesDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
   .item_info td{
      padding-left: 10px;
   }

</style>
<script type="text/javascript"
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
var productLike = 0;

function productChoice(n) {
      console.log(n);
 <%
    MemberDTO mdto = (MemberDTO) session.getAttribute("login");
   if (mdto != null) {%>

      $.ajax({

         type : "get",
         url : "ProductLikeServlet",
         data : {
            "p_id" : n,
         
         },
         dataType : "text",
         success : function(data) {
            
            var like_img = '';
            if (data == 0) {
               like_img = "images/like.png";
            } else {
               like_img = "images/liked.png";
            }
            $("#like_img" + n).attr('src', like_img);
            console.log("성공");
         },
         error : function(xhr, status, error) {
            alert(error);
         }

      }); //end ajax
<%} else {%>
      $("#modalBtn").trigger("click");
      $("#mesg").text("로그인이 필요합니다.");
      
      $("#closemodal").click(function() {
      location.href="LoginUIServlet";
      }) 
      event.preventDefault();
<%}%>

   }
   $(function() {
      
      var count = "1";
      $("button[name=up]").click(function() {
         
         var p_id =$(this).attr("data-p_id");
         console.log("up클릭 "+p_id);
         
         var p_amount= $("#p_amount"+p_id).val();
         $("#p_amount"+p_id).val(parseInt(p_amount)+1);
         count = $("#p_amount"+p_id).val();
         
         var price = $("#price"+p_id).text();
         
         var total = $("#total"+p_id).text(count*price);
         
      });//end up

       $("button[name=down]").click(function() {

         var p_id =$(this).attr("data-p_id");
         console.log("down클릭 "+p_id);
         var p_amount= $("#p_amount"+p_id).val();
         
         if(p_amount != 1){
         $("#p_amount"+p_id).val(parseInt(p_amount)-1);
         count = $("#p_amount"+p_id).val();
         console.log(count);
         var price = $("#price"+p_id).text();
         var total = $("#total"+p_id).text(count*price);
         }
         
      });//end down 

     $("button[name=cart]").on("click", function() {
        var p_id = $(this).attr("data-P_id");
        var p_name = $(this).attr("data-p_name");
        var p_selling_price = $(this).attr("data-p_selling_price");
        var p_image = $(this).attr("data-p_image");
         console.log(p_id, p_name, p_selling_price, count, p_image);
        
       <%if(mdto != null){%>
        $.ajax({
           type : "post",
           url : "addCartServlet",
             data : {
              p_id : p_id,
              p_name : p_name,
              p_selling_price : p_selling_price,
              p_amount:count,
              p_image:p_image
             },
             dataType : "text",
           success : function(data, status, xhr) {
            console.log("add성공");
         },
         error : function(xhr, status, error) {
            console.log(error);
         }
        })//end ajax
        
        $("#modalBtn2").trigger("click");
   <%} else{ %>
   $("#modalBtn").trigger("click");
   $("#mesg").text("로그인이 필요합니다.");
   
   $("#closemodal").click(function() {
    location.href="LoginUIServlet";
 }) 
      event.preventDefault();
   <% } %>
   
   })//cart 
   
   $("#order").on("click", function() {
      location.href="OrderServlet=";
      $("form").attr("action", "OrderServlet");
   })//order
 
   
   $(".imageChange").mouseover(function () {
      var src2 = $(this).attr("src");
       $("#firstImage").attr("src", src2);
   });
      
   })//end ready
   
    
</script>



<%
ProductDTO pdto = (ProductDTO) request.getAttribute("pdto");

int c_id = pdto.getC_id();
String p_content = pdto.getP_content();
int p_cost_price = pdto.getP_cost_price();
String p_created = pdto.getP_created();
int p_discount = pdto.getP_discount();
int p_id = pdto.getP_id();
String p_name = pdto.getP_name();
int p_selling_price = pdto.getP_selling_price();
int p_stock = pdto.getP_stock();
%>
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
   crossorigin="anonymous">

<%
MemberDTO member = (MemberDTO)session.getAttribute("login");
List<ImagesDTO> ilist = (List<ImagesDTO>) request.getAttribute("ImagesRetrieveList");

System.out.println("productRetrieve.jsp에서 파싱한 pdto==" + pdto);
System.out.println("productRetrieve.jsp에서 파싱한 ilist==" + ilist);

int likecheck = 0;

if (member != null) {
   likecheck = (int)request.getAttribute("likecheck");
} 
%>




<style>
   table {
   font-family: sans-serif;
   }
   
   
</style>

   <form  name="goodRetrieveForm" action="#" method="get">
      <div class="row">
         <div class="col-md-1"></div>
         <div class="col-md-5">
            <table>
               <!-- 제품사진 -->
               <input type="hidden" name="p_id" id="p_id" value="<%=p_id%>">   
               <input type="hidden" name="p_name" id="p_name" value="<%=p_name%>">   
               <input type="hidden" name="p_selling_price" id="p_selling_price" value="<%=p_selling_price%>">   
               
               <%
               for (int i = 0; i < ilist.size(); i++) {

                  String image_route = ilist.get(i).getImage_route();
                  int image_rnk = ilist.get(i).getImage_rnk();
                  String update_date = ilist.get(i).getUpdate_date();
               %>
                     
               <%
               if (image_rnk == 1) {
               %>
               <tr>
                  <td colspan="5">
                  <img id="firstImage" name="p_image"
                     src="images/p_image/<%=image_route%>"
                     class="img-thumbnail" style="height: 500; width: 600; " ></td>
                     <input type="hidden" name="p_image" id="p_image" value="<%=ilist.get(0).getImage_route() %>">
               </tr>
               <%
               }
               %>
               <tr>
                  <table style="display: inline;">
                     <tr>
                        <td colspan="5">
                           <img class="imageChange"
                              src="images/p_image/<%=image_route%>"
                              class="img-thumbnail" style="height: 100; width: 100;" > 
                        </td>
                     </tr>
                  </table>
               </tr>
            <%
            }
            %>
            </table>
         </div>
         <div class="col-md-1"></div>
         <div class="col-md-5" >
            <table class="item_info" style="line-height: 70px;">
               <!-- 상품 설명 -->
            
               <tr>
                  <th>상품명</th>
                  <td></td>
                  <td style="font-size: 20px; font-weight: bold;"><%=p_name%></td>
               </tr>

               <tr>
                  <td></td>
               </tr>

               <tr>
                  <th>설명</th>
                  <td></td>
                  <td><%=p_content%></td>
               </tr>

               <tr>
                  <td></td>
               </tr>

               <tr>
                  <th>상품가격</th>
                  <td></td>
                  <td><span id="price<%=p_id %>" name="p_selling_price"><%=p_selling_price%></span>원</td>
                  
               </tr>

               <tr>
                  <td></td>
               </tr>

               <tr>
                  <th>배송비</th>
                  <td></td>
                  <td>3,000원(50,000원 이상 무료배송)</td>
               </tr>

               <tr>
                  <td></td>
               </tr>

               <tr>
                  <th>수량</th>
                  <td></td>
                  <td>
                  <input id="p_amount<%=p_id %>" name="p_amount" value="1" class="form-control"
                  style=" text-align; right; margin-top: -4px; height:39px; width:80px; display: inline;  " maxlength="3"
                        size="2" >
                  
                     <button style="display:inline; margin-top: -7px;" type="button" class="btn btn-outline-success" name="up" id="up<%=p_id %>" data-p_id="<%=p_id%>">+</button>
                     <button style="display:inline; margin-top: -7px;" type="button" class="btn btn-outline-success" name="down" id="down<%=p_id%>"  data-p_id="<%=p_id%>">-</button>
                  
                  </td>
                  <td></td>

               </tr>

               <tr>
                  <td></td>
               </tr>

               <tr>
                  <th>총 상품가격</th>
                  <td></td>
                  <td style="font-size: 20px; font-weight: bold;"><span id="total<%=p_id%>"><%=p_selling_price%></span>원</td>
               </tr>

               <tr>
                  <td></td>
               </tr>

               <tr >
               <!-- 찜  -->
                   <td><a id="productChoice"
                  href="javascript:productChoice(<%=p_id%>)">
                   <%  if (likecheck == 1) {%> 
                   <img id="like_img<%=p_id%>" src="images/liked.png" width="50" height="50" class="liked">
                    <% } else { %> 
                    <img id="like_img<%=p_id%>" src="images/like.png" width="50"
                     height="50" class="liked">
                  <% } %>
               </a></td> 
               
                  <td><button type="submit" class="btn btn-success" id="order">주문하기</button>
                  </td>
                  
                  <td>
                  <!-- Button trigger modal -->
                  
                  </td>
               </tr>
               
            </table>
         </div>
      </div>
   </form>


