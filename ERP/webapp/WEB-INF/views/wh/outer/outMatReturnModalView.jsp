<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- jQuery -->
<script src="${pageContext.request.contextPath }/resources/plugins/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- Font Awesome Icons -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/plugins/fontawesome-free/css/all.min.css">
<!-- IonIcons -->
<link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/dist/css/adminlte.min.css">
<!-- Google Font: Source Sans Pro -->
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/bootstrap-4.5.0-dist/js/bootstrap.bundle.min.js"></script>
<!-- 부트스트랩 -->
<script src="${pageContext.request.contextPath }/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

<h2 style="padding-left: 30px; padding-top: 25px;" >원자재 반품의뢰서 상세 보기</h2>

<div style="background-color: white; margin: 30px; margin-right: 55px;">
	<input type="hidden" value="${buyReVO.met_out_no }" id="met_out_no"/>
	<table class="table">
		<thead>
			<tr>
				<th>반품서 번호</th>
				<td>${buyReVO.ret_no}</td>
				<th>반품 요청 일자</th>
				<td>${buyReVO.ret_date}</td>
			</tr>
			<tr>
				<th>반품 담당자 사원번호</th>
				<td>${buyReVO.emp_no }</td>
				<th>사원명</th>
				<td>${buyReVO.emp_name }</td>
			</tr>
			<tr>
				<th>출고 담당자 사원번호</th>
				<td><!-- 사원코드 session에서 꺼내기 -->
					<input type="number" name="emp_no" value="${authUser.emp_no }" readonly="readonly">
				</td>
				<th>반품 일자</th>
				<td>
					<input type="date" name="met_out_date" id="currentDay" readonly="readonly">
				</td>
			</tr>
		</thead>
	</table>
</div>

<h3 style="padding-left: 30px; padding-top: 25px;">출하 원자재 목록</h3>
<div id="outform" style="background-color: white; margin: 30px; margin-right: 55px;">
	<table class="table" id="matTable">
		<tr>
			<th>
				<spring:message code="mat.mat_no"/>
			</th>
			<th>
				<spring:message code="mat.mat_name"/>
			</th>
			<th>
				반품수량
			</th>
			<th>
				<spring:message code="store.store_no"/>
			</th>
			<th>
				<spring:message code="sector.sector_no"/>
			</th>
			<th>
				창고저장수량 
			</th>
		</tr>
		<c:if test="${not empty buyretmatList}">
			<c:forEach items="${buyretmatList }" var="retMat">
				<tr>
					<td class="mat_no">${retMat.mat_no }</td>
					<td>${retMat.mat_name }</td>
					<td>${retMat.retmat_qty}</td>
					<td>
						<select name=mat_store class="dynamicElement storeSelect" data-source="${retMat.mat_no }">
							<option value="">창고선택</option>
							<c:if test="${not empty storeList }">
								<c:forEach items="${storeList }" var="store">
									<option value="${store.store_no }">${store.store_no }</option>
								</c:forEach>
							</c:if>
						</select>
					</td>
					<td>
						<select name="sector_no" class="dynamicElement sectorSelect" data-target="${retMat.mat_no }"
						data-url="<c:url value='/ware/lprod/outSectorList'/>">
							<option></option>
						</select>
					</td>
					<td>
						<input type="number" class="mat_cnt" id="mat_cnt" readonly="readonly">
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	
	<input type="button" id="returnMatBtn" value="출고" class="btn btn-success" style="float: right">
</div>

<!-- 진행 완료 상태일때 보여주는 div -->
<main id="resultdiv"  style="background-color: white; margin: 30px; margin-right: 55px;">
	<table class="table">
		<tr class="table-info">
			<th>
				<spring:message code="mat.mat_name"/>
			</th>
			<th>
				<spring:message code="mat.mat_no"/>
			</th>
			<th>반품수량</th>
			<th>
				<spring:message code="store.store_no"/>
			</th>
			<th>
				<spring:message code="sector.sector_no"/>
			</th>
		</tr>
		<c:if test="${not empty buyretmatList}">
			<c:forEach items="${buyretmatList }" var="retMat">
				<tr>
					<td class="mat_no">${retMat.mat_no }</td>
					<td>${retMat.mat_name }</td>
					<td>${retMat.retmat_qty}</td>
					<td>
						<!-- 창고 -->
						${retMat.sector_no }
					</td>
					<td>
 						<!-- 창고구역 -->
						${retMat.mat_sector_no }
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
		<!-- Footer -->
		<footer class="text-center mt-4">
		 <div class="btn-group btn-group-sm d-print-none"> <a href="javascript:window.print()" class="btn btn-light border text-black-50 shadow-none"><i class="fa fa-print"></i> 프린트</a></div>
		</footer>
</main>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript">
	
	var met_out_no = $("#met_out_no").val();
	
	console.log("met_out_no  " + met_out_no);
	
	$("#resultdiv").hide();
	
	// 진행중이면 met_out_no가 null이니까 outform이 나오고 
	// 반품완료 라면 met_out_no가 not null 이니까 resultdiv가 나와야 한다. 
	
	if(met_out_no!=""){
		$("#outform").hide();
		$("#resultdiv").show();
	}

	//오늘 날짜 뿌려주기 
	$('#currentDay').val(new Date().toISOString().substring(0,10));
	
	// 원자재가 저장된 창고와 창고구역 불러오기 
	var optionPtrn = "<option value='%V' %S>%T</option>";
	var data_source = "";
	
	var store_Tag = $(".storeSelect").on("change",function(){
		
		data_source = $(this).attr("data-source");
		let store_no = $(this).val();
		let mat_no = $(this).parent().parent().find(".mat_no").text();
		
		let zz = $("select[data-target='"+data_source+"']");
		
		zz.trigger("renew",{
			store_no : store_no,
			mat_no : mat_no
		});
	
	});
	
	var sector_Tag = $(".sectorSelect").data("success", function(resp){
		var html = "<option value=''>구역선택</option>";
		$.each(resp, function(idx,sector){
			html += optionPtrn
						.replace("%V",sector.sector_no)
						.replace("%T",sector.sector_no)
						.replace("%S","data-cnt='"+sector.mat_cnt+"' class='mat_cnt' ");
		});
		let sector_Tag_target = $("select[data-target='"+data_source+"']");
		sector_Tag_target.html(html);
		
	});
	
	$(".sectorSelect").on("change",function(){
		let cnt = $(this).children("option:selected").data("cnt");
		let aa = $(this).parent().parent().find("input[class=mat_cnt]");
		aa.val(cnt);
	});
	
	$(".dynamicElement").dynamicSelect();
	
	$("#returnMatBtn").on("click",function(){
		// 반품서를 토대로 출고시킬 원자재들을 객체로 담아서 컨트롤러에 보내준다. 
		// 필요한 정보는 반품서 번호 , 
		
		var buyRet = new Object(); // 반품서 vo
		buyRet.ret_no = "${buyReVO.ret_no}"; // 반품서 번호 
		buyRet.retmat_no="${buyReVO.retmat_no}";
		
		var matList = new Array(); // matList
		
		var matTable = $("#matTable");
		var matArr = matTable.find("tbody tr");

		$(matArr).each(function(){
			let matVO = new Object(); // matVO;
			matVO.mat_no = $(this).find("td").eq(0).text();
			matVO.sector_no=$(this).find(".sectorSelect").val();
			matList.push(matVO);
		});
		
		matList.shift(); // list에 있는 첫번째 값 빼기 
		
		buyRet.matList=matList; // 객체에 matList 넣기 
		
		console.log(JSON.stringify(buyRet));// JSON.stringify : json문자열로 변환할 값
		
		$.ajax({
			url : "${cPath}/ware/outer/matreturn",
			contentType : "application/json;charset=UTF-8",
			data : JSON.stringify(buyRet),
			method : "post",
			dataType : "text",
			success : function(resp){
				console.log("resp >> "+resp);
				let res = resp;
				if(res="ok"){
					alert("원자재 출고완료");
			 		window.close();
				}else{
					alert("원자재 출고 실패");
				}
			},
			error : function(errorResp){
				console.log(errorResp.status + ":"+ errorResp.responseText);
			}
		});
	});
</script>
