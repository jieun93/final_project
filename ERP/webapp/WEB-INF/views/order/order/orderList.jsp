<%--
* [[개정이력(Modification Information)]]
* 	수정일                 수정자      	수정내용
* ----------  ---------  -----------------
* 2020. 7. 5     이제경       		최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%-- <input type="hidden" id="nextExist" value="${order.deliv_no }"> --%>

<h1 style="padding-left: 30px;padding-top: 25px;">주문서조회</h1>

<div class="col-xs-12" style="padding-left: 30px; padding-top: 10px;">
	<div class="box">
		<div class="box-header">
<!-- 			<h3 class="box-title">주문서조회</h3> -->
			<table>
				<thead>
					
				</thead>
				<tbody>
					<tr>
						<td>
							<div class="#" id="searchUI">
							<!-- 탭 -->
							<ul class="nav nav-pills nav-tabs" style="margin-top: 10px; margin-bottom: 20px;">
							  <li class="nav-item" id="status_all">
							    <a class="nav-link active" data-toggle="tab" href="#">전체</a>
							  </li>
							  <li class="nav-item" id="status_ing">
							    <a class="nav-link" data-toggle="tab" href="#">진행중</a>
							  </li>
							  <li class="nav-item" id="status_ok">
							    <a class="nav-link" data-toggle="tab" href="#">완료</a>
							  </li>
							  <li class="nav-item" id="status_del">
							    <a class="nav-link" data-toggle="tab" href="#">취소</a>
							  </li>
							</ul>
							<spring:message code="date" />
							<input type="date" name="startDay"/>&nbsp;~&nbsp;<input type="date" name="endDay"/>	
							<spring:message code="buyer.buyer_name" />
							<input type="text" name="buyer_name">
							<spring:message code="emp.emp_name" />
							<input type="text" name="emp_name">
							<spring:message code="order.or_req_date" />
							<input type="date" name="or_req_date">
							</div>
						</td>
					</tr>
				</tbody>
				<tfoot>
				<tr>
					<td>
						<div style="margin-top: 10px;">
							<input type="button" value="검색" id="searchBtn" class="btn btn-outline-dark" > 
							<input type="button" value="신규등록" class="btn btn-outline-dark" onclick="location.href='<c:url value="/order/order/form" />';">
						</div>
					</td>
				</tr>
			</tfoot>
			</table>
		</div>
	</div>
	<!-- /.box-header -->
	<div style="background-color: white; margin: 30px; margin-right: 55px;">
	<div id="tableDiv" class="box-body table-responsive no-padding" style="height:600px;overflow-y: scroll;">
		<table class="table table-hover" id="orderTable">
			<thead>
			<tr>
				<tr role="row">
                <th class="sorting_asc" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="checkBox" aria-sort="checkBox">#</th>
                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="or_date"><spring:message code="date" /></th>
                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="buyer_name"><spring:message code="buyer.buyer_name" /></th>
                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="emp_name"><spring:message code="emp.emp_name" /></th>
                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="or_totalPrice"><spring:message code="order.or_totalprice" /></th>
                <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="2" aria-label="or_status"><spring:message code="status" /></th>
                </tr>
				<tr>
					
<!-- 					<th>#</th> -->
<%-- 					<th><spring:message code="date" /></th> --%>
<%-- 					<th><spring:message code="buyer.buyer_name" /></th> --%>
<%-- 					<th><spring:message code="emp.emp_name" /></th> --%>
<%-- 					<th><spring:message code="order.or_req_date" /></th> --%>
<%-- 					<th><spring:message code="order.or_totalprice" /></th> --%>
<%-- 					<th colspan="2"><spring:message code="status" /></th> --%>
<!-- 					<th>비고</th> -->
				</tr>
			</thead>
			<tbody id="listBody">
				

			</tbody>
			<tfoot>
				<tr>
					<td>
<!-- 						<input type="button" id="selectDelete" value="선택출하지시서등록"> -->
					</td>
					<td colspan="9">
						<form:form id="radioForm" action="${cPath }/order/delivery/form" method="get">
							<div id="deliveryPost"></div>
							<input type="button" id="selectDelivery" onclick="sendDelivery()" class="btn btn-outline-danger" value="출하지시서등록">
						</form:form>
					</td>
				</tr>
			</tfoot>

		</table>
	</div>
	</div>
	<div style="margin-bottom: 10px;">
		<input type="button" id="delBtn" class="btn btn-danger" value="삭제">
		<input type="button" id="print" class="btn btn-outline-dark" value="인쇄">
		<input type="button" id="exportBtn" class="btn btn-outline-dark" value="엑셀저장">
<!-- 		<input type="button" id="delBtn" class="btn btn-dark" value="삭제"> -->
	</div>

</div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">주문서</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
<!-- 			 <button type="button" id="updateBtn" class="btn btn-primary mr-2">수정</button> -->
			 <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<%-- <form:form id="radioForm" action="${cPath }/order/delivery/form" method="get"> --%>
<!-- 	<div id="deliveryPost"></div> -->
<!-- 	<input type="button" id="selectDelivery" onclick="sendDelivery()" value="출하지시서등록"> -->
<%-- </form:form> --%>

<form:form id="searchForm" 	action="${pageContext.request.contextPath }/order/order" method="get">
	<input type="hidden" name="page" value="${param.page }">
	<input type="hidden" name="startDay" value="" />
	<input type="hidden" name="endDay" value="" />
	<input type="hidden" name="buyer_name" value="">
	<input type="hidden" name="emp_name" value="">
	<input type="hidden" name="or_req_date" value="">
	<input type="hidden" id="status" name="status" value="">
<!-- 	<input type="hidden" name="searchType" value="" /> -->
<!-- 	<input type="hidden" name="searchWord" value="" /> -->
</form:form>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/paging.js" ></script>
<script type="text/javascript">
//listBody붙이기------------------------------------------------------------
	var listBody = $("#listBody");
	var searchForm = $("#searchForm").paging(
			{
				searchUI : "#searchUI",
				searchBtn : "#searchBtn",
				pagination : "#pagingArea",
				pageParam : "page",
				byAjax : true,
				success : function(resp) {
					let orderList = resp.dataList;
					let pagingHTML = resp.pagingHTML;
					let trTags = [];
					if(orderList!=null){
						if (orderList.length > 0) {
							$.each(orderList, function(idx, order) {
										console.log(order);
								let trTag = $("<tr>").append(
	// 									$("<td>").html(order.rnum),
										$("<td>").html($("<input>").attr({type:"radio", name:"inputChk"}).addClass("radio")).addClass("radio"),
										$("<td>").text(order.or_date),
										$("<td>").text(order.buyer_name),
										$("<td>").text(order.emp_name),
										$("<td>").text(order.or_req_date),
										$("<td>").text(order.orderList[0].orp_price),
										$("<input/>").addClass("orNo").attr({type:"hidden", value:order.or_no}),
	// 									$("<td>").text(order.prodVO.prod_validity)
										$("<td>").html(
												$("<select>").append(
													$("<option>").val("OR01").text("진행중"),
													$("<option>").val("OR02").text("완료"),
													$("<option>").val("OR99").text("취소")
												).addClass("select").val(order.or_status)
										).data({"or_no": order.or_no, "deliv_no":order.deliv_no}),
										$("<td>").html($("<input>").attr({type:"button", name:"selectBtn", value:"진행상태변경"}).addClass("btn btn-outline-danger")).addClass("selectBtn")
								).data({"or_no": order.or_no, "deliv_no": order.deliv_no});
								console.log(order.deliv_no);
								trTags.push(trTag);
							});
	// 						$("#pagingArea").html(pagingHTML);
						} else {
							trTags.push($("<tr>").html(
									$("<td colspan='8'>").text("조건에 맞는 게시글이 없음")));
							$("#pagingArea").empty();
					}
					}					
// 					}else{
// 						trTags.push($("<tr>").html(
// 									$("<td colspan='8'>").text("조건에 맞는 게시글이 없음")
// 								)
// 								);
// 						$("#pagingArea").empty();
// 					}
					listBody.html(trTags);
					listBody.data("currentPage", resp.currentPage);
					searchForm.find("[name='page']").val("");
					//엑셀저장------------------------------------------------------------
					orderTable = $("#orderTable").tableExport({
						   headers: true,        // (Bool), 테이블의 <thead> 태그 안에 <th> 나 <td> 가 있으면 표시함 (기본: true)
					       footers: true,       // (Bool), 테이블의 <tfoot> 태그 안에 <th> 나 <td> 가 있으면 표시함, (기본: false)
					       formats: ["xlsx"],    // (String[]), 저장할 파일 포맷 반드시 배열 타입이어야 함, 아니면 에러 발생. (기본: ['xlsx', 'csv', 'txt'])
//					 	        filename: "exceldata",// 다운로드 파일명(확장자 제외하고 이름만). (기본: 'id')
					       bootstrap: true,     // (Bool), 부트스트랩 사용시 true, 사용시 부트스트랩 버튼 스타일 유지해줌. (기본: true)
					       exportButtons: false,  // (Bool), 선택한 확장자 포맷들로 자동으로 내장 버튼을 출력해줌. (기본: true)
					       position: "top",      // (top, bottom), 캡션 표시 위치(버튼이 출력되는 위치로 테이블 상단(top), 하단(bottom)을 선택. (기본: 'bottom')
					       ignoreRows: null,     // (Number, Number[]), 엑셀 파일 저장시 제외할 테이블 행을 숫자, 또는 숫자 배열로 지정. (기본: null)
					       ignoreCols: null,     // (Number, Number[]), 엑셀 파일 저장시 제외할 테이블 열을 숫자, 또는 숫자 배열로 지정. (기본: null)
					       trimWhitespace: true, // (Boolean), 테이블 안의 텍스트 앞뒤에 붙은 줄바꿈, 공백, 탭을 모두 제거해줌. true 권장. (기본: false)
					       RTL: false,           // (Boolean), 엑셀 워크시트를 오른쪽에서 왼쪽으로 출력함. 아랍어 전용으로 false 고정. ( (기본: false)
					       sheetname: "Sheet1"   // (id, String), 시트이름 (기본: 'id')
					});
				}

			}).submit();
					       
//모달창 띄우기------------------------------------------------------------
	var sampleModal = $("#exampleModal").modal({
		show:false
	}).on("hidden.bs.modal",function(){
		sampleModal.find(".modal-body").empty();
		sampleModal.data("or_no","");
	});	

//listBody붙이기------------------------------------------------------------
	function loadOrderView(or_no) {
		$.ajax({
			url : "<c:url value='/order/order/'/>" + or_no,
			dataType : "html",
			// Accept : 
			// html > text/html, Content-Type:text/html
			// json >  application/json 
			success : function(resp) {
				sampleModal.find(".modal-body").html(resp);
				sampleModal.data("or_no", or_no);
				sampleModal.modal("show");
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
	}
	
//tr태그 클릭------------------------------------------------------------
	var or_num;
	var listView = $("#listBody").on("click", "tr", function(e){
		if($(e.target).attr("class")=='radio') return;
		if($(e.target).attr("class")=='selectBtn') return;
		if($(e.target).attr("class")=='select') return;
		if($(e.target).attr("class")=='btn btn-outline-danger') return;
		or_num = $(this).data("or_no");					//확인
		loadOrderView(or_num);
	}).css({cursor:"pointer"});
	
//라디오버튼클릭------------------------------------------------------------
	
	function sendDelivery(){
		var listBody = document.getElementById('listBody');
		var confirm_val = confirm("선택한 주문서의의 출하지시서를 입력하겠습니까?");
		
		//PK값 가져오기
		var chkRadio = $("input[name=inputChk]:checked").parent().parent().find(".orNo").val();
// 		var chkRadioVal = $("input[name=inputChk]:checked").parent().parent().find("select[class=select option:selected]").val();
		var chkRadioVal = $("input[name=inputChk]:checked").parent().parent().find(".select").val();
		alert(chkRadio);
		console.log(chkRadioVal);
		console.log("라디오 값 확인 : " +chkRadio);
		
		$("#deliveryPost").append("<input type='hidden' name='or_no' value='"+ chkRadio +"'/>");
		
		if(confirm_val){
			if(chkRadioVal=="OR01"){
				$("#radioForm").submit();
			}else{
				alert("진행중인 주문서가 아닙니다.");
			}
			
		}
 
	}

//tr엑셀파일로 저장하기------------------------------------------------------------
	let orderTable = null;
   $("#exportBtn").on("click", function(){
		let name = prompt("file name");
		let exportData = orderTable.getExportData()['orderTable']['xlsx'];
		console.log(exportData.filename);
	    //                   // data          // mime              // name              // extension
	    orderTable.export2file(exportData.data, exportData.mimeType, name, exportData.fileExtension);
   });
   
//수정버튼------------------------------------------------------------
  	
	$("#updateBtn").on("click", function(){
		let or_no = sampleModal.find("tr").eq(1).find("td").eq(0).text();
// 		console.log(est_no);
// 		let or_no = or_num;
// 		console.log(or_no);
		location.href= "${pageContext.request.contextPath }/order/order/"+or_no+"/form";
	});
	
   
//진행상태변경------------------------------------------------------------
	
	var selectBtn = $("#listBody").on("click", "input[type=button]", function(){
// 		alert(1);
// 		console.log(e);
		let or_status = $(this).parent().prev().find("select").val();
		console.log(or_status);
		let or_no = $(this).parent().parent().data("or_no");
		let deliv_no = $(this).parent().parent().data("deliv_no");
		alert(deliv_no);
		if(deliv_no!=null){
			alert("해당하는 주문서에 대한 출하지시서가 존재합니다. 출하지시서를 삭제하고 시도해주세요")
			return;			
		}else{
			loadSelect(or_no, or_status);
		}
	});
	
	function loadSelect(or_no, or_status) {
		$.ajax({
			url : "<c:url value='/order/prog/order'/>",
			dataType : "html",
			data : {
				or_no : or_no,
				or_status : or_status},
			// Accept : 
			// html > text/html, Content-Type:text/html
			// json >  application/json 
			success : function(resp) {
				alert("진행상태가 변경되었습니다.");
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
	}	

//탭버튼------------------------------------------------------------
	
	//전체
	$("#status_all").on("click", function(){
		$("#status").val("");
		searchBtn.click();
	});
	
	//진행중
	$("#status_ing").on("click", function(){
		$("#status").val("OR01");
		searchBtn.click();
	});
	
	//완료
	$("#status_ok").on("click", function(){
		$("#status").val("OR02");
		searchBtn.click();
	});
	$("#status_del").on("click", function(){
		$("#status").val("OR99");
		searchBtn.click();
	});
	
//삭제버튼클릭------------------------------------------------------------
	var delBtn = $("#delBtn").on("click", function(){
// 		var or_noList = [];
		var chkRadio = $("input[name=inputChk]:checked").parent().parent().find(".orNo").val();
// 		alert(chkRadio);
// 		deleteOrder(chkRadio);
		let deliv_no = $("input[name=inputChk]:checked").parent().parent().data("deliv_no");
		
		if(deliv_no!=null){
			alert("해당하는 주문서에 대한 출하지시서가 존재합니다. 출하지시서를 삭제하고 시도해주세요")
			return;			
		}else{
			deleteOrder(chkRadio);
		}
		
// 		let est_no = $("#listBody").find("tr").eq(0).find("td").eq(2);
// 		alert(est_no);
		
		//선택된값 가져오기
// 		var chkbox = $("input[name=inputChk]:checked").parent().parent().find("#est_no").val();
// 		var chkbox = $("input[name=inputChk]:checked").parent().parent().find("td[name=est_no]").text();
// 		console.log(chkbox);
		
// 		var chkbox='';
// 			chkbox = $("input[name=inputChk]:checked").parent().parent().find("td[name=or_no]");
		
		//값을 리스트에 담아주기
// 		$.each(chkbox,function(idx,item){
// 			est_noList.push($(item).text()); //
// 			console.log(est_noList);
// 			deleteEstimate(est_noList);
// 		});
		
	});
	
	
	
	function deleteOrder(chkRadio){
// 		jsonData = {chkRadio : chkRadio};
		$.ajax({
			url : "${cPath}/order/order/delete",
// 			contentType : "application/json;charset=UTF-8",
			dataType : "text",
			type : "POST",
			data :{
				or_no : chkRadio
			},
			success : function(resp) {
				alert(resp);
				searchBtn.click();
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		}); 
		
	}
	
	
//인쇄버튼클릭------------------------------------------------------------
	$("#print").on("click", function() {
		var no = [];
		let chk = true;
		$.each($("input[name='inputChk']"), function(idx, input) {
// 			alert(input);
			if ($(input).is(":checked")) {
				var tr = $(this).closest('tr');
				no.push(tr.data("or_no"));
				// 				alert("no값 : "+no);
				chk = false;
			}
		});
		if (chk) {
			alert("인쇄할 전표를 선택하지 않았습니다.")
			return;
		}
		// 		alert(no);
		printset(no);

	});

	var print = function() {
		$("#printhtml").empty()
	};
	var printset = function(no) {
		console.log(new Date());
		$.ajax({
			url : "${cPath}/order/order/print/all",
			method : "post",
			dataType : "html" // Accept:application/json, Content-Type:application/json
			,
			contentType : "application/json"
			//	 				,data : {list:no}
			,
			data : JSON.stringify({
				list : no
			}),
			success : function(resp) {
				const setting = "width=890, height=841";
				const objWin = window.open('', 'print', setting);
				objWin.document.open();
				objWin.document.write(resp);
				objWin.document.write('<div class="page_break"></div>');
				objWin.focus();
				//					 	ojWin.document.close();
				setTimeout(function() {
					objWin.print();
					objWin.close();
				}, 100);
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
	};

	var exampleModal = $("#exampleModal").modal({
		show : false
	}).on("hidden.bs.modal", function() {
		exampleModal.find(".modal-body").empty();
	});

	


   
</script>

