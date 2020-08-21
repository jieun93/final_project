<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">사원검색</h5>
			 	<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body"></div>
			<!-- <div class="modal-footer">
				<button type="button" class="btn btn-secondary" id="confirm_btn">확인</button>
			</div> -->
		</div>
	</div>
</div>
<form action="${cPath }/emp/retire/retirementRegister" method="post"> 
<h2>퇴직금정산</h2>  
<div class='middleDiv'>
<input type="button" class="btn btn-outline-primary" value="사원정보 검색" id="search"/>
</div>
<div class='tableStyle'>
<table class="table table-bordered  text-left">
	<thead class="table-primary">
		<tr >
			<th> 소속 </th>
			<td class="emp1">${emp.dep_no}</td>	
			<th>직급 </th>
			<td class="emp1"> ${emp.pos_no} </td>	
			<th>입사일 </th> 
			<td class="emp1">${emp.hire_date}</td>
		</tr>
		<tr>
			<th>사원ID </th>
			<td class="emp1"> ${emp.emp_no}</td>
			<th>성명 </th>
			<td class="emp1">${emp.emp_name}</td>
			<th>구분</th>
			<td class="emp1">${emp.name }</td>
		</tr>
		<tr>
			<th>은행명 </th>
			<td class="emp1"> ${emp.bank}</td>
			<th>계좌번호 </th>
			<td class="emp1">${emp.emp_bankno}</td>
			<th>예금주</th>
			<td class="emp1">${emp.emp_name}</td>
		</tr>
	</thead>
</table>	
</div> 
<div class='tableStyle'>
<table class="table table-bordered  text-left">
	<thead>
		<tr >
			<th>퇴직일</th>
			<td><input type="date" name="retire_day" required="required" class="form-control"></td>	
			<th>총 재직일수</th>
			<td class="total_work_cnt"></td>	
		
		</tr>
		<tr>	
			<th class="">정산구분</th>
			<td>
			<select class="dynamicElement form-control mr-2" name="retire_reason" value="${emp.retire_reason}" required="required"> 
														<!-- name ==>vo에 있는거 컨트롤러에 vo 값으로 들어갈수 잇도록  -->
				<option value="">정산구분</option>
				<c:forEach items="${retireList}" var="retire">
					<option value="${retire.code}">${retire.name}</option>
				</c:forEach>					
			</select>
			</td>
			<th>퇴직금 지급일</th>
			<td><input type="date" name="payment_day" required="required"  class="form-control"></td>	
<!-- 			<td>퇴직사유</td> -->
<!-- 			<td><input type="text" name="retire_reason"></td> -->
		</tr>	
	</thead>
</table>	
 </div> 
  <h3 class='middleDiv'>퇴직전  3개월 임금 총액 계산 내역</h3>
 <div class='tableStyle'>
<table class="table table-bordered  text-left ">	
	<!-- <tbody id="listBody2"> -->
		<tr>
			<th>퇴직금근속기간</th>
			<th>일수</th>
			<th>급여 </th>
			
			
		</tr>
		<tr>
			<td class=' form-inline'><input type="text" class="sal_date_start form-control" style="width: 200px;" readonly/> &nbsp; ~&nbsp; <input type="text" class="sal_date_end form-control" style="width: 200px;" readonly/></td>
			<td class="three_cnt"></td>
			<td class="actual_payment"></td>
		</tr>
		<tr>
			<td class=' form-inline'><input type="text" class="sal_date_start form-control" style="width: 200px;"  readonly/> &nbsp; ~&nbsp; <input type="text" class="sal_date_end form-control" style="width: 200px;"  readonly/></td>
			<td class="two_cnt"></td>
			<td class="actual_payment"></td>
		</tr>
		<tr>
			<td class=' form-inline'><input type="text" class="sal_date_start form-control" style="width: 200px;"  readonly/> &nbsp; ~&nbsp; <input type="text" class="sal_date_end form-control" style="width: 200px;"  readonly/></td>
			<td class="one_cnt"></td>
			<td class="actual_payment"></td>
		</tr>
		<tr>
			<td>계</td>
			<td class="total_work_cnt"></td>
			<td class="sum_pay"></td>
		</tr>
</table>
</div>		
		<h3 class='middleDiv'>퇴직금 계산</h3>
		<div class='tableStyle'>
<table class="table table-bordered  text-left">
		<tr>
			<th>월평균 임금</th>
			<td id='average'></td>
			<th>퇴직금 </th>
			<td id='money' ></td>
			
		</tr>
		<tr>
			<th>퇴직소득세</th>
			<td id='tax' ></td>
			<th>차인지급액</th>
			<td id='result'></td>
			
		</tr>
		
	<!-- </tbody> -->
	
</table>
</div>
<input type='hidden' name='deduction'>
<input type='hidden' name='retire_salary' readonly>
<input type='hidden' id='emp_no' name='emp_no' readonly>
 <div class='middleDiv'>
<table>
	<tr class="row">
		<td class="col text-right">
		<input class="btn btn-success mr-2" type="submit" value="등록"> 
		<input 	class="btn btn-outline-secondary mr-2" type="submit" value="뒤로가기"	onclick="history.back();">
		</td>
	</tr>
</table>
</div>
</form>
<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript"
		src="${pageContext.request.contextPath }/resources/js/paging.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript">
$(".sal_date_start").val('');
$(".sal_date_end").val('');
$(".actual_payment").text('');
$(".three_cnt").text('');
$(".two_cnt").text('');
$(".one_cnt").text('');
		var exampleModal = $("#exampleModal").modal({ // 모달창이 꺼질때 show가 사라지는거
			show : false
		}).on("hidden.bs.modal", function() {
			exampleModal.find(".modal-body").empty();
		});
	function loadAssetsView(){ // 검색버튼 눌렀을 떄 모달창 띄우는거 
		// 3번 ajax를 타고 jsp를 불러오는거 
			$.ajax({
				url : "<c:url value='/emp/retire/retireEmpModal'/>", // retireEmpModal 컨솔창으로 넘어가는거 
				dataType : "html",
				success : function(resp){ // retireEmpModal.jsp  (내용)가 담기는거 
					exampleModal.find(".modal-body").html(resp);
					exampleModal.modal("show");
				}
			}); 
	}
	
	var average = 0;
			$("#search").on("click", function() { // 1번 클릭하면
				loadAssetsView(); //  2번  위의 function을 불러오는거 
			}).css({
				cursor : "pointer"
			});
	
			// 행하나 클릭시 선택한 사원의 정보가 화면에 뿌져지도록
			function empInfoView(emp_no){
				$.ajax({
					url :"<c:url value='/emp/retire/retirementForm/'/>"+emp_no, // 페이지전환이 아니라 정보만 빼오는거 
					dataType :"json",
					success: function(resp){ // 컨트롤러에서 vo를 넘겨준 값 ㄴ
						$(".sal_date_start").val('');
						$(".sal_date_end").val('');
						$(".actual_payment").text('');
						$(".three_cnt").text('');
						$(".two_cnt").text('');
						$(".one_cnt").text('');
						console.log($(".emp1"));
						$(".emp1").eq(0).text(resp.depVO.dep_name); 
						$(".emp1").eq(1).text(resp.pos_no);
						$(".emp1").eq(2).text(resp.hire_date); 
						$(".emp1").eq(3).text(resp.emp_no);
						$(".emp1").eq(4).text(resp.emp_name);
						$(".emp1").eq(5).text(resp.name); 
						$(".emp1").eq(6).text(resp.bank); 
						$(".emp1").eq(7).text(resp.emp_bankno); 
						$(".emp1").eq(8).text(resp.emp_name); 
						$("#exampleModal").modal("hide");// 행을 클릭하면 모달이 숨겨지는거	
						$("#emp_no").val(emp_no);
						
						if(resp.transList !=null)
						$.each(resp.transList, function(idx, item){
// 						$(".three_cnt").text(resp.transList[0].three_cnt);
// 						$(".two_cnt").text(resp.transList[0].two_cnt);
// 						$(".one_cnt").text(resp.transList[0].one_cnt);
						
// 						$(".total_work_cnt").text(resp.transList[0].total_work_cnt);
						$(".sum_pay").text(numberWithCommas(item.sum_pay));
							$(".sal_date_start").eq(idx).val(item.sal_date_start);
							$(".sal_date_end").eq(idx).val(item.sal_date_end);
							$(".actual_payment").eq(idx).text(numberWithCommas(item.actual_payment));
							$("#average").text(numberWithCommas(Math.floor(item.sum_pay/3)));
							average = Math.floor(resp.transList[0].sum_pay/3);
						});
						
					}
				});
			}
			
			$("#exampleModal").on("click","tr", function(){
				let empInfo = $(this).find("td").eq(3).text();
				empInfoView(empInfo);
			}).css({
				cursor : "pointer"
			});
			
			
			$("input[name='retire_day']").on("change", function(){
				hire_date = new Date($(".emp1").eq(2).text());
				var day = ((new Date($(this).val())).getTime() - hire_date.getTime())/1000/60/60/24;
				$(".total_work_cnt").text(day);
				var year = Math.floor(day/365);
				var minus = 0;
				if(year <= 5)
					minus = year*300000;
				else if(year<=10)
					minus = 1500000+500000*(year - 5);
				else if(year<=20)
					minus = 4000000+800000*(year - 10);
				else 
					minus = 12000000+1200000*(year - 20);
				money = average * year;
				$("#money").text(numberWithCommas(money));
				$("input[name='retire_salary']").val(money);
				tax = Math.floor((money - minus)*0.15*0.22);
				$("#tax").text(numberWithCommas(tax));
				$("input[name='deduction']").val(tax);
				$("#result").text(numberWithCommas(money-tax));
				console.log()
			});
	// 금액 ,  찍어주는거 
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '원';
	}
	
	$("form").on("submit", function(){
		if($("input[name='emp_no']").val() == '') {
			alert("직원을 선택하세요");
			return false;
		}
	});
</script>