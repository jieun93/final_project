<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div id='con'>
<h2>적요관리</h2>
<div class='middleDiv'>
<ul class="nav nav-pills nav-tabs">
	  <li class="nav-item" id="status_all">
	    <a class="nav-link status" data-toggle="tab" href="#">계정</a>
	  </li>
	  <li class="nav-item" id="status_ing">
	    <a class="nav-link active status" data-toggle="tab" href="#">적요</a>
	  </li>
</ul>
</div>
<form action="${cPath }/account/basic/account/summary">
		<div class="form-inline d-flex ml-md-auto d-print-none middleDiv" id="searchUI">
			<table>
				<tr>
					<th>적요코드</th>
					<th colspan='3'>적요</th>
				</tr>
				<tr>
					<td><input type="text" class="form-control mr-2" name='summary_no' readonly="readonly">
					</td>
					<td>
						<input type="text" class="form-control mr-2" name="summary">
						</td>
						<td>
							<input class="btn btn-success mr-2" type="button"
							value='등록' id="insertBtn">
						</td>
						<td>
							<input class="btn btn-danger mr-2" type="button"
							value='삭제' id="deleteBtn">
						</td>
					</tr>
				</table>
		</div>
</form>
<div class='tableStyle'>
<table class="table table-bordered table-hover text-left">
	<thead class="table-primary">
		<tr>
			<th>#</th>
			<th>적요코드</th>
			<th>적요</th>
		</tr>
	</thead>
	<tbody id="listBody">
	</tbody>
</table>
</div>
</div>
<script type="text/javascript">
var listBody = $("#listBody");
var page = function(summary){
	$.ajax({
		url : "${cPath}/account/basic/account/summary",
		method : "get",
		data : {
			summary : summary
		},
		dataType : "json", // Accept:application/json, Content-Type:application/json
		success : function(resp) {
			let trTags = [];
			if(resp.length>0){
				$.each(resp, function(idx, summary){
					let trTag = $("<tr>").append(
									$("<td>").text(idx+1)
									, $("<td>").text(summary.summary_no)
									, $("<td>").text(summary.summary)
									);
					trTags.push(trTag);
				});
			}else{
				trTags.push($("<tr>").html($("<td colspan='3'>").text("등록된 적요가 없습니다.")));
			}
			listBody.html(trTags);
		},
		error : function(errorResp) {
			console.log(errorResp.status + ":" + errorResp.responseText);
		}
	});
}
page();

var input_no = $("input[name='summary_no']");
var input_word = $("input[name='summary']");
var insertBtn = $("#insertBtn");
$("#insertBtn").on("click", function(){
	if($("input[name='summary']").val()==""){
		alert("적요를 입력하세요.");
		return false;
	}
	if($(this).val()=="새적요입력"){
		input_no.val("");
		input_word.val("");
		input_word.removeAttr('readonly');
		insertBtn.val("등록");
		return false;
	}else{
		$.ajax({
			url : "${cPath}/account/basic/account/summary",
			data : {
				summary : $("input[name='summary']").val()
			},
			method : "post",
			dataType : "text", // Accept:application/json, Content-Type:application/json
			success : function(resp) {
				if(resp=='success'){
				input_word.val("");
				page();
					alert('적요 등록 성공');
				}
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
	}
});
$("#deleteBtn").on("click", function(){
	if($("input[name='summary_no']").val()=="") return false;
	var no = $("input[name='summary_no']").val();
	$.ajax({
		url : "${cPath}/account/basic/account/summary",
		data : {
			_method : "delete",
			summary_no : no 
		},
		method : "post",
		dataType : "text", // Accept:application/json, Content-Type:application/json
		success : function(resp) {
			if(resp=='success') {
			input_no.val("");
			input_word.val("");
			insertBtn.val("등록");
			page();
			alert('적요 삭제 성공');
			}
		},
		error : function(errorResp) {
			console.log(errorResp.status + ":" + errorResp.responseText);
		}
	});
});
$("#listBody").on("click", "tr", function(){
	let summary_no = $(this).find("td").eq(1).text();
	let summary = $(this).find("td").eq(2).text();
	input_no.val(summary_no);
	input_word.val(summary);
	input_word.attr('readonly','readonly');
}).css({cursor:"pointer"});

$("input[name='summary_no']").on("input", function(){
	if($(this).val()!=""){
		insertBtn.val("새적요입력");
	}else{
		$("#insertBtn").val("등록");
	}
});

(function ($) {
    var originalVal = $.fn.val;
    $.fn.val = function (value) {
        var res = originalVal.apply(this, arguments);
 
        if (this.is('input:text') && arguments.length >= 1) {
            // this is input type=text setter
            this.trigger("input");
        }
 
        return res;
    };
})(jQuery);

$('.status').on('click', function () {
	let url = '${cPath}/account/basic/account';
	if(this.text=='적요') url+='/summary';
	else url+='/list';
	$.ajax({
		url : url,
		method: "post",
		dataType : "html", // Accept:application/json, Content-Type:application/json
		success : function(resp) {
			$("#con").html(resp);
		},
		error : function(errorResp) {
			console.log(errorResp.status + ":" + errorResp.responseText);
		}
	});
});
</script>