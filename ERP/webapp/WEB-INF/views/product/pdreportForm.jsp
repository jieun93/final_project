<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    
    <%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2020. 7. 6      작성자명 박정민
      최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
 
<!DOCTYPE html>
<html>

 <style type="text/css">
 
 
  .wrap-loading{ /*화면 전체를 어둡게 합니다.*/
    position: fixed;
    left:0;
    right:0;
    top:0;
    bottom:0;
    background: rgba(0,0,0,0.2); /*not in ie */
    filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');    /* ie */
}
    .wrap-loading div{ /*로딩 이미지*/
        position: fixed;
        top:50%;
        left:50%;
        margin-left: -21px;
        margin-top: -21px;
    }
    .display-none{ /*감추기*/
        display:none;
    }
 
.container{
  margin-left:auto;
  margin-right:auto;  
  margin-top:calc(calc(100vh - 405px)/2);
}
#form1{
  width:auto;
}
.alert{
  text-align:center;
}
 
#preview{  
  max-height:256px;
  height:auto;
  width:auto;
  display:block;
  margin-left: auto;
   margin-right: auto;
  padding:5px;
}
#img_container{
  border-radius:5px;
  margin-top:20px;
  width:auto;  
}
.input-group{  
  margin-left:370px;
  margin-top:40px;
  width:320px;
}
.imgInp{  
  width:150px;
  margin-top:10px;
  padding:10px;
  background-color:#d3d3d3;  
}
.loading{
   animation:blinkingText ease 2.5s infinite;
}
@keyframes blinkingText{
    0%{     color: #000;    }     
    50%{   color: #transparent; }
    99%{    color:transparent;  }
    100%{ color:#000; }
}
.custom-file-label{
  cursor:pointer;
}
 
 </style>


<h2>
생산보고서 작성
</h2>


<form id = "Pform" action="${cPath }/report" method="post">
<div style = "width: 1000px;
 ">
<table class="table" style="background-color: white;">
		<tbody><tr >
			<td>생산의뢰번호</td>
			<td>
				<input type="text" name="porder_no" data-toggle = "modal" class = "clickpop"  data-target = "#viewModal" data-remote="${cPath }/report/list" >
			</td>
		</tr>
		<tr >
			<td>상품코드</td>
			<td>
				<input type="text" name="prod_no" class = "Agroup" >
				
			</td>
		</tr>
		<tr >
			<td>상품이름</td>
			<td>
				<input type="text" name="prod_name" class = "Agroup" >
				
			</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>
				<input type="text" name="emp_name" class = "Agroup" >
				<input type="hidden" name="emp_no" value = "2020070901">
			</td>
		</tr>
		<tr>
			<td>작성일</td>
			<td>
				<input type="date" name="rep_date" > 
			</td>

		</tr>
		<tr>
			<td>수량</td>
			<td>
				<input type="number" name="pduct_cnt" class = "Agroup"> 
				
			</td>
		</tr>
		<tr>
			<td>폐기수량</td>
			<td> 
				<input type="number" name="pduct_discnt">
				
			</td>
		</tr>
	</tbody>
	</table>
		<div style="margin-top: 30px;">
			<input type="submit" value="저장" class="btn btn-success" >
			<input type="reset" value="다시쓰기" class="btn btn-info" >
			<input type="button" value="뒤로가기" class = "btn btn-outline-secondary" onclick="history.back();">
			<input type="button" value="목록으로 " class = "btn btn-outline-secondary" onclick="location.href='/ERP/product';">
			<input type="button" name="multifile" class = "btn btn-outline-secondary" value="OCR분석" id = "ocr" >
			<input type="button" class = "btn btn-outline-secondary" value="이미지 변환"  onClick="location.href='${cPath}/resources/pdftojpg/pdf-to-png.html'" >
			

		</div>
</div>
</form>

<%-- <form:form id="boardForm" modelAttribute="board"  method="post" enctype="multipart/form-data" class="w-100" --%>
<%-- 	action="${pageContext.request.contextPath }${currentAction }"> --%>
	
<%-- 	</form:form> --%>

<div class="modal fade " id="viewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-xl"  role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">생산보고서 작성</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id = "modalbody">
      
      </div>
      <div class="modal-footer">
      
        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="OrderFirm(event)">의뢰확정</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade " id="viewModal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-xl"  role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">OCR 보고서 분석기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id = "modalbody1">
      <div class=" animated bounce">
<form id = "fileupload" method="post" enctype="multipart/form-data">

    <div class="alert"></div>
    <div id='img_container'><img id="preview" src="${cPath }/resources/images/AI.jpg" alt="your image" title=''/></div> 
    <div class="input-group"> 
    <div class="custom-file">
    <input type="file" multiple="true" id="inputGroupFile01" class="imgInp custom-file-input" aria-describedby="inputGroupFileAddon01" name = "fileupload">
    <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
  </div>
</div>
</form>
</div>
      
      </div>
      <div class="modal-footer">
      
        <button type="button" class="btn btn-secondary" data-dismiss="modal" id = "analysis">분석요청</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<div class="wrap-loading display-none">

    <div><img src="${cPath }/resources/img/loading.gif"></div>

</div>   


<c:if test="${not empty message}">

 <div class="alert alert-success alert-dismissible fade show">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <strong>Success!</strong> ${message }
  </div>

</c:if>
<c:if test="${not empty Failmessage}">

<div class="alert alert-light alert-dismissible fade show">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <strong>Fail!</strong> ${Failmessage }
  </div>
</c:if>


<script type="text/javascript">


$("#inputGroupFile01").change(function(event) {  
	  RecurFadeIn();
	  readURL(this);    
	});
	$("#inputGroupFile01").on('click',function(event){
	  RecurFadeIn();
	});
	function readURL(input) {    
	  if (input.files && input.files[0]) {   
	    var reader = new FileReader();
	    var filename = $("#inputGroupFile01").val();
	    filename = filename.substring(filename.lastIndexOf('\\')+1);
	    reader.onload = function(e) {
	      $('#preview').attr('src', e.target.result);
	      $('#preview').hide();
	      $('#preview').fadeIn(500);      
	      $('.custom-file-label').text(filename);             
	    }
	    reader.readAsDataURL(input.files[0]);    
	  } 
	  $(".alert").removeClass("loading").hide();
	}
	function RecurFadeIn(){ 
	  console.log('ran');
	  FadeInAlert("Wait for it...");  
	}
	function FadeInAlert(text){
	  $(".alert").show();
	  $(".alert").text(text).addClass("loading");  
	}



// aaa
$("#analysis").on("click",function(){
	var form = $("#fileupload")[0]
	var formData = new FormData(form)
	
	$.ajax({
        url : '${cPath}/report/analysis',
        enctype: 'multipart/form-data',
        type : 'POST',
        data : formData,
        contentType : false,
        beforeSend:function(){
            $('.wrap-loading').removeClass('display-none'); }
        ,complete:function(){
            $('.wrap-loading').addClass('display-none');
        },
        processData : false
        
    }).done(function(data){
    	
    	if(data.porder_confirm == "Y"){
    		alert("이미 보고되었습니다. 다른 보고서를 작성해주십시오")
    		return
    	}
        console.log(data)
        	$("input[name = porder_no]").val(data.porder_no)
			$("input[name = prod_no]").val(data.prod_no)
			$("input[name = pduct_cnt]").val(data.pduct_cnt)
			$("input[name = prod_name]").val(data.prod_name)
			$("input[name = emp_name]").val(data.emp_name)
			
        
    });

})


 
 $("#ocr").on("click",function(){
	$("#viewModal1").modal("show")
	 
 })
 
$('.clickpop').on("click", function() {
	var modal = $(this);
	var modalbody = $("#modalbody")
	
	modalbody.load(modal.data("remote"));

}).css({
		cursor:"pointer"
	});

function inputdisable(type){
	$("#Pform").find("input.Agroup").attr("disabled",type)
}
inputdisable(true)


$(document).on("click",".order",function(){


	var child = $(this).children()
	
	let porder_no = $(child[0]).text().trim()
	let prod_no = $(child[2]).data("name")
	let pduct_cnt = parseInt($(child[4]).text())
	
	$("input[name = porder_no]").val(porder_no)
	$("input[name = prod_no]").val(prod_no)
	$("input[name = pduct_cnt]").val(pduct_cnt)
	
// 	$.each(child,function(idx,order){
		
// 		console.log($(order).text() )
		
// 	})
})
	
	
	


</script>

