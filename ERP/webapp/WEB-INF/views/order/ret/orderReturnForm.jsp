<%--
* [[개정이력(Modification Information)]]
* 	수정일                	 수정자      		수정내용
* ----------  ---------  -----------------
* 2020. 7. 23       송효진 	          최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link href="https://unpkg.com/bootstrap-table@1.17.1/dist/bootstrap-table.min.css" rel="stylesheet">
<script src="https://unpkg.com/bootstrap-table@1.17.1/dist/bootstrap-table.min.js"></script>

<style>
	.stepwizard-step p {
	    margin-top: 10px;
	}
	
	.stepwizard-row {
	    display: table-row;
	}
	
	.stepwizard {
	    display: table;
	    width: 100%;
	    position: relative;
	}
	
	.stepwizard-step button[disabled] {
	    opacity: 1 !important;
	    filter: alpha(opacity=100) !important;
	}
	
	.stepwizard-row:before {
	    top: 14px;
	    bottom: 0;
	    position: absolute;
	    content: " ";
	    width: 100%;
	    height: 1px;
	    background-color: #ccc;
	    z-order: 0;
	
	}
	
	.stepwizard-step {
	    display: table-cell;
	    text-align: center;
	    position: relative;
	}
	
	.btn-circle {
	  width: 30px;
	  height: 30px;
	  text-align: center;
	  padding: 6px 0;
	  font-size: 12px;
	  line-height: 1.428571429;
	  border-radius: 15px;
	}
</style>
<div>
<h2>반품 신청</h2>
<div class="container">
	<div class="stepwizard">
	    <div class="stepwizard-row setup-panel">
	        <div class="stepwizard-step">
	            <a href="#step-1" type="button" id="step1" class="btn btn-primary btn-circle">1</a>
	            <p>Step 1</p>
	        </div>
	        <div class="stepwizard-step">
	            <a href="#step-2" type="button" id="step2" class="btn btn-default btn-circle" disabled="disabled">2</a>
	            <p>Step 2</p>
	        </div>
	        <div class="stepwizard-step">
	            <a href="#step-3" type="button" id="step3" class="btn btn-default btn-circle" disabled="disabled">3</a>
	            <p>Step 3</p>
	        </div>
	    </div>
	</div>
</div>
</div>

<div style="margin: 30px 30px 10px 30px; margin-right: 55px;">
<div id="stepDiv">
	<h3>Step1. 출하서 조회</h3>
	<table 
		id="myTable" class="table"
	    data-toggle="table"
	    data-height="500"
	    data-detail-view="true"
	    data-detail-formatter="detailFormatter"
	    data-ajax="ajaxRequest"
	    style="background-color: white;"
	>
		<thead class="table-primary">
			<tr>
				<th data-field="ship_no">출하등록 번호</th>
				<th data-field="ship_p_date">출하일</th>
				<th data-field="ship_date">출고요청일</th>
				<th data-field="orderpVO.buyer_name">거래처명</th>
				<th data-field="emp_name">담당자명</th>
			</tr>
		</thead>
	</table>
	<input type="button" id="nextPage" class="btn btn-outline-danger" value="다음"/>
</div>
</div>


<style type="text/css">
	.yellows {background-color:#D9D9D9;}
</style>

<script type="text/javascript">
	
	var shipVOList;
	function ajaxRequest(params) {
		let url="${cPath}/order/shipment/json";
	    $.get(url).then(function (res) {
	        params.success(res);
	        shipVOList = res;
	    })
	}
	
	function detailFormatter(index, row) {
		shipVO = row;
	    var html = [];
	    html.push("<table><tr><th>품목코드</th><th>품목명</th><th>분류명</th><th>규격</th><th>규격단위</th><th>수량</th></tr>");
	    console.log(row);
	    for(var i=0; i<row.orderpVO.orderList.length; i++){
			html.push("<tr><td>"+row.orderpVO.orderList[i].prod_no+"</td>");
			html.push("<td>"+row.orderpVO.orderList[i].prod_name+"</td>");
			html.push("<td>"+row.orderpVO.orderList[i].lprod_name+"</td>");
			html.push("<td>"+row.orderpVO.orderList[i].prod_stand_size+"</td>");
			html.push("<td>"+row.orderpVO.orderList[i].orp_qty+"</td>");
			html.push("<td>"+row.orderpVO.orderList[i].orp_price+"</td></tr>");
	    }
	    html.push("</table>");
	    return html.join('')
	}
	$(document).on("click", "tr", function(){
	    $(document).find(".yellows").removeClass();
	    $(this).addClass("yellows");
	});
	
	
	var shipNo = "";
	var shipVO;
	$("#nextPage").on("click", function(){
		shipNo = $(".yellows").eq(0).find("td").eq(1).text()		//pk값 구하기	(선택된 tr의 2번째 td값(인덱스는 0부터 시작))
		if(shipVOList.length>0){
			$.each(shipVOList, function(idx, ship){
				if(ship.ship_no == shipNo){
					shipVO = ship;
				}
			});
		}
		if(shipNo == null || shipNo==""){
			alert("출하서 목록을 선택해주세요.");
			return;
		}
		$("#step2").removeClass('btn-default').addClass('btn-primary');
		$("#stepDiv").empty();
		
		step2(shipVO);	// step2
		
		//step2 반품등록 버튼 클릭
		$("#step2Btn").on("click", function(){
			let retList = [];
			let retVO = [];
			$("input[class=step2Check]:checked").each(function(idx){     
				let orp_no = $(this).parent().find(".orp_no").val();	//주문상품목록
				let ret_list_qty = $(this).parent().parent().find(".ret_list_qty").val();	//반품수량
				
				if(orp_no && ret_list_qty){
					retVO = [];
					retVO = {orp_no: orp_no, ret_list_qty: ret_list_qty};
					retList.push(retVO);
				}
			});
			jsonData = {
				ship_no : shipVO.ship_no,	//매입번호
				emp_no : $("#empNo").val(),	//사원번호
				ret_pList : retList,
			}
			// insert 작업
			$.ajax({
				url : "${cPath}/order/return",
				method: "post",
			    contentType: "application/json;charset=UTF-8",	//보내는 data 타입
				data : JSON.stringify(jsonData),	//마샬링
				dataType : "html",	//받는 data타입
				success : function(resp) {
					$("#stepDiv").empty();
					$("#step3").removeClass('btn-default').addClass('btn-primary');
					$("#stepDiv").append(resp);
				},
				error : function(errorResp) {
					console.log(errorResp.status + ":" + errorResp.responseText);
				}
			});
		});
		
	});
	
	function step2(shipVO){	//step2
		let title = "<h4>Step2. 반품 목록 선택</h4>";
		let shipTr = "<table class='step2Table table table-hover'><h5>출하 물품</h5>";
		shipTr += "<thead><tr><th>#</th><th>품목코드</th><th>품목명</th><th>분류명</th><th>규격단위</th><th>수량</th><th>단가</th></tr></thead><tbody>";
		for(var i=0; i<shipVO.orderpVO.orderList.length; i++){
			shipTr += "<tr><td><input type='checkbox' class='step2Check'/>";
			shipTr += "<input type='hidden' class='orp_no' value='"+shipVO.orderpVO.orderList[i].orp_no+"'></td>";
			shipTr += "<td class='prod_no'>"+shipVO.orderpVO.orderList[i].prod_no+"</td>";
			shipTr += "<td>"+shipVO.orderpVO.orderList[i].prod_name+"</td>";
			shipTr += "<td>"+shipVO.orderpVO.orderList[i].lprod_name+"</td>";
			shipTr += "<td>"+shipVO.orderpVO.orderList[i].prod_stand_size+"</td>";
			shipTr += "<td><input type='number' class='ret_list_qty' value='"+shipVO.orderpVO.orderList[i].orp_qty+"' style='width:70px;'/></td>";
			shipTr += "<td>"+shipVO.orderpVO.orderList[i].orp_price+"</td>";
		}
		shipTr += "</tbody></table></tr>";
		let endBtn = "<input type='button' id='step2Btn' class='btn btn-outline-danger' value='반품 등록'/>";
		
		$("#stepDiv").append(title).append(shipTr).append(endBtn);
		
		// step2 테이블 체크박스 체크
		$(document).on("click", ".step2Table td", function(){
			let check = $(this).parent().find(".step2Check").prop("checked");
			if(check==false){
				$(this).parent().find(".step2Check").prop("checked", true);			
			}else{
				$(this).parent().find(".step2Check").prop("checked", false);
			}
		});
	}
	
</script>

