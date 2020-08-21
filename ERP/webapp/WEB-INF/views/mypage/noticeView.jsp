<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<!-- 마이페이지 공지사항 상세보기 -->
<h2> 공지사항 상세보기</h2>
<div class = 'tableStyle'>
<table class="table table-bordered">
	<tbody>
		<tr>
			<td>제목  : ${notice.notice_title}</td>
			<td>조회수 : ${notice.notice_view}</td>
		</tr>
		<tr>
		</tr>
		<tr>
			<td>작성자 : ${notice.emp_name}</td>
			<td>작성일  : ${notice.notice_date }</td>
		</tr>
		<tr>
			<td colspan="2">
			<form id="delForm" method="post">
			<input type="hidden" name="emp_no" id="emp_no"/>
			<input type="hidden" name="_method" value="delete"/>
			<input type="hidden" name="notice_no" value="${notice.notice_no }"/>
				<c:forEach items="${notice.attatchList }" var="attatch" varStatus="vs">
					<input type="hidden" id="delAtt" name="deleteAttatches" value="${attatch.att_no }">
					<a href="<c:url value='/notice/file/${attatch.att_no }'/>">${attatch.att_filename }</a> ${not vs.last?"&nbsp;":"" }
				</c:forEach>
			</form>
			</td>
		</tr>	
		<tr>
			<td colspan="2">${notice.notice_content }</td>
		</tr>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="2">
				<input type="button" class="btn btn-outline-secondary" value="뒤로가기" 
					onclick="history.back();"/>
			</td>
		</tr>
	</tfoot>
</table>
</div>
<script>
// 	var emp_no = $("#emp_no");
	
// 	$("#del").on("click", function(){
// 		let pass = prompt("사원번호입력");
// 		emp_no.val(pass);
// 		$("#delForm").submit();
// 	});

</script>







