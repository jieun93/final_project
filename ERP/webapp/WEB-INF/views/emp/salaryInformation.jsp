<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  
<h1>급여기본정보</h1>  

<div>
<table class="table table-bordered table-hover text-left">
	<thead class="table-primary">
		<tr >
			<th>사원ID  : </th>
			<td>${emp.emp_no}</td> 
			<th>입사일 : </th>
			<td>${emp.hire_date}</td>
			<th>부서 : </th>
			<td> ${depart.dep_name} </td>
		</tr>
		<tr >
			<th>성명  : </th>
			<td>${emp.emp_no}</td> 
			<th>소속 : </th>
			<td>${emp.hire_date}</td>
			<th>직급 : </th>
			<td> ${depart.dep_name} </td>
		</tr>
		<tr >
			<th>은행  : </th>
			<td>${emp.emp_no}</td> 
			<th>예금주 : </th>
			<td>${emp.hire_date}</td>
			<th>계좌번호 : </th>
			<td> ${depart.dep_name} </td>
		</tr>
		<tr >
			<th>구분  : </th>
			<td>${emp.emp_no}</td> 
			<th>급여일 : </th>
			<td>${emp.hire_date}</td>
			<th>부서 : </th>
			<td> ${depart.dep_name} </td>
		</tr>
	</thead>
</table>	
 </div> 
     
          <tr class="row">
				<td class="col text-right">
					<input class="btn btn-warning mr-2" type="reset" value="등록"> 
					<input class="btn btn-success mr-2" type="submit" value="수정">
					<!-- <input class="btn btn-secondary mr-2" type="submit" value="뒤로가기"
						onclick="history.back();"
					> -->
				</td>
			</tr>

<%-- <form id="searchForm" action="${pageContext.request.contextPath }/board">
	<input type="hidden" name="page" value="${param.page }"/>
	<input type="hidden" name="searchType" value=""/>
	<input type="hidden" name="searchWord" value=""/>
</form> --%>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/paiging.js"></script>
<script type="text/javascript">
	var listBody = $("#listBody");
	var searchForm = $("#searchForm").paging({
		searchUI:"#searchUI",
		searchBtn:"#searchBtn",
		pagination:"#pagingArea",
		pageParam:"page",
		byAjax:true,
		success:function(resp){
			let boardList = resp.dataList;
			let pagingHTML = resp.pagingHTML;
			let trTags = [];
			if(boardList.length>0){
				$.each(boardList, function(idx, board){
					let trTag = $("<tr>").append(
									$("<td>").text(board.rnum)
									, $("<td>").html(
										$("<a>").attr("href", "${pageContext.request.contextPath }/board/"+board.bo_no)
												.html(board.bo_title)													
									)
									, $("<td>").text(board.bo_writer)
									, $("<td>").text(board.bo_date)
									, $("<td>").text(board.bo_hit));
					trTags.push(trTag);
				});
				$("#pagingArea").html(pagingHTML);
			}else{
				trTags.push($("<tr>").html($("<td colspan='8'>").text("조건에 맞는 게시글이 없음.")));
				$("#pagingArea").empty();
			}
			listBody.html(trTags);
			listBody.data("currentpage", resp.currentPage);
			searchForm.find("[name='page']").val("");
		}
	}).submit();

</script> --%>