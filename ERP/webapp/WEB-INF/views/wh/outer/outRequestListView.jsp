<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">출하지시서 상세보기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
			 <button type="button" class="btn btn-primary" >상품출고</button>
			 <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<h2 style="padding-left: 30px; padding-top: 25px;">출하지시서 목록</h2>

<div style="padding-left: 30px; padding-top: 10px;">
	<form:form id="searchForm" action="${pageContext.request.contextPath }/ware/outer/doc" method="get">
	<input type="hidden" name="page" value=""/>
		<!-- 탭 -->
		<ul class="nav nav-pills nav-tabs">
		  <li class="nav-item" id="status_all">
		    <a class="nav-link active" data-toggle="tab" href="#">전체</a>
		  </li>
		  <li class="nav-item" id="status_ing">
		    <a class="nav-link" data-toggle="tab" href="#">진행중</a>
		  </li>
		  <li class="nav-item" id="status_finish">
		    <a class="nav-link" data-toggle="tab" href="#">출고 완료</a>
		  </li>
		  <li class="nav-item" id="status_cancle">
		    <a class="nav-link" data-toggle="tab" href="#">진행 취소</a>
		  </li>
		</ul>
		<input type="hidden" name="status" id="status" value=""/> <!-- 진행상태 넘겨주기 -->
		<table class="table">
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="emp_name">
				</td>
			</tr>
			<tr>
				<th>작성 일자</th>
				<td>
					<input type="date" name="startDay"/>&nbsp;~&nbsp;<input type="date" name="endDay"/>
				</td>
				<td><input type="button" class="btn btn-info" value="검색" id="searchBtn"/></td>
			</tr>
		</table>
	</form:form>
</div>

<div style="background-color: white; margin: 30px; margin-right: 55px;">
	<table class="table">
		<thead class="table-primary">
			<tr>
				<th>No.</th>
				<th>부서 명</th>
				<th>작성자</th>
				<th>작성일자</th>
			</tr>
		</thead>
		<tbody id="listbody"></tbody>
	</table>
</div>

<div style="padding-left: 30px; padding-top: 10px;">
	<nav id="pagingArea" class="d-flex ml-md-auto d-print-none">
		${pagingVO.pagingHTML }
	</nav>	
</div>

<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/paging.js"></script>
<script type="text/javascript">
	// 탭
	//전체
	$("#status_all").on("click", function(){
		$("#status").val("");
		searchBtn.click();
	});
	//진행중
	$("#status_ing").on("click", function(){
		$("#status").val("OR02");
		searchBtn.click();
	});
	//출고 완료
	$("#status_finish").on("click", function(){
		$("#status").val("OR01");
		searchBtn.click();
	});
	//취소
	$("#status_cancle").on("click", function(){
		$("#status").val("OR99");
		searchBtn.click();
	});
	
	// 목록띄우기 
	var listbody = $("#listbody");
	var searchForm = $("#searchForm").paging({
		searchUI : "#searchUI",
		searchBtn : "#searchBtn",
		pagination : "#pagingArea",
		pageParam : "page",
		byAjax : true,
		success : function(resp){
			let docList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			console.log(docList);
			let trTags = [];
			if(docList.length > 0){
				$.each(docList,function(idx,doc){
					let trTag = 
						$("<tr>").append(
							$("<td>").text(doc.rnum),
							$("<td>").text(doc.dep_name),
							$("<td>").text(doc.emp_name),
							$("<td>").text(doc.write_date)
						).data("board_no",doc.board_no);
					trTags.push(trTag);
				});
				$("#pagingArea").html(pagingHTML);
			}else{
				trTags.push($("<tr>").html(
					$("<td colspan='5'>").text("조건에 맞는 상품이 없습니다.")	
				));
				$("#pagingArea").empty();
			}
			
			$("#listbody").html(trTags);
			listbody.data("currentPage",resp.currentPage);
			searchForm.find("[name='page']").val("");
		}
	}).submit();
	
	// 새창띄우기 
	var listBody = $("#listbody").on("click","tr",function(){
		let board_no = $(this).data("board_no");
		let url = "<c:url value='/ware/outer/doc/order/'/>"+board_no;
		let _width = '1100';
		let _height = '650';
		let _left = Math.ceil((window.screen.width - _width)/2);
		let _top = Math.ceil((window.screen.width - _height)/6);
		let popupOption = "width="+_width+", height="+_height+", left="+_left+", top="+_top;
		window.open(url,"",popupOption);
	}).css({cursor:"pointer"});
	
	
</script>