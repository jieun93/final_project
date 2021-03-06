<%--
* [[개정이력(Modification Information)]]
* 	수정일                 수정자      		수정내용
* ----------  ---------  -----------------
* 2020. 7. 28      송효진      		최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${cPath }/resources/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="${cPath }/resources/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.6.2/css/buttons.dataTables.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.3.1/css/select.dataTables.min.css">

<h2>반품 현황</h2>
<div style="margin: 30px 30px 10px 30px; margin-right: 55px;">
<table id="myTable" class="table table-hover" style="background-color: white;">
  <thead class="table-primary">
    <tr>
      <th scope="col">#</th>
      <th scope="col">반품번호</th>
      <th scope="col">작성일자</th>
      <th scope="col">거래처명</th>
      <th scope="col">반품 개수</th>
      <th scope="col">작성자</th>
      <th scope="col">상태</th>
    </tr>
  </thead>
</table>
<input type="button" id="delBtn" class="btn btn-outline-danger" value="반품취소"/>
</div>


<!-- 모달창 -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>


<!-- DataTables -->
<script src="${cPath }/resources/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="${cPath }/resources/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="${cPath }/resources/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="${cPath }/resources/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>

<script src="https://cdn.datatables.net/buttons/1.6.2/js/dataTables.buttons.min.js   "></script>
<script src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.flash.min.js        "></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js         "></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js    "></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js      "></script>
<script src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.html5.min.js        "></script>
<script src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.print.min.js        "></script>
<script src="https://cdn.datatables.net/select/1.3.1/js/dataTables.select.min.js     "></script>
<script type="text/javascript">
	
	//dataTable 세팅
	var myDataTable= $("#myTable").DataTable({
		"language": {
            "emptyTable": "데이터가 존재하지 않습니다.",
            "lengthMenu": "페이지당 _MENU_ 개씩 보기",
            "info": "현재 _START_ - _END_ / _TOTAL_건 중",
            "infoEmpty": "데이터가 존재하지 않습니다.",
            "infoFiltered": "( _MAX_건의 데이터에서 필터링됨 )",
            "search": "검색:",
            "zeroRecords": "데이터가 존재하지 않습니다.",
            "loadingRecords": "로딩중...",
            "processing":     "잠시만 기다려 주세요...",
            "paginate": {
            	"first" : "첫 페이지",
                "last" : "마지막 페이지",
                "next": "다음",
                "previous": "이전"
            }
        },
        bPaginate: true,
    	searching: true,
        "destroy":true,
        "responsive": true,
        "autoWidth": false,
        stateSave: true,
        "pageLength": 10, //기본 데이터건수
        dom: 'Bfrtip',
        buttons: [ 'copy', 'excel', 'print' ],
	    ajax:{
	       url: "${cPath}/order/return"
	       ,dataType:"json"
	    },
	    columns:[
	    	{
	    		render: function () {		//빈 td태그 만들기
	    			return null;
	    		}
	    	}
	    	,{className: "retNo", data:"or_retp_no"}
			,{data:"or_retp_date"}
			,{data:"buyer_no"}
			,{data:"pcnt"}
			,{data:"emp_name"}
			,{data:"status"}
	    ],
	    columnDefs: [ {
            orderable: true,
            className: 'select-checkbox',
            targets:   0
        } ],
	    select: {
            style:    'multi',
            selector: 'td:first-child'
        }
//      	,order: [[ 1, 'desc' ]]	//초기 정렬 순서 (1열을 기준으로 오름차순 정렬)
	});
	
	
	//상세보기
	$('#myTable tbody').on('click', 'tr', function (e) {
		if($(e.target).hasClass("select-checkbox")) return;		//체크박스 부분에는 이벤트 제외
		var data = myDataTable.row(this).data();
		let view = $("<table>").addClass("table table-bordered").append(
			$("<tr>").append($("<th>").text("반품번호"), $("<td>").text(data.or_retp_no)  ),
			$("<tr>").append($("<th>").text("반품일자"), $("<td>").text(data.or_retp_date)  ),
			$("<tr>").append($("<th>").text("주문번호"), $("<td>").text(data.or_no)  ),
			$("<tr>").append($("<th>").text("주문일자"), $("<td>").text(data.or_date)  ),
			$("<tr>").append($("<th>").text("거래처코드"), $("<td>").text(data.buyer_no)  ),
			$("<tr>").append($("<th>").text("거래처명"), $("<td>").text(data.buyer_name)  ),
			$("<tr>").append($("<th>").text("반품 개수"), $("<td>").text(data.pcnt)  ),
			$("<tr>").append($("<th>").text("담당자 부서"), $("<td>").text(data.dep_name)  ),
			$("<tr>").append($("<th>").text("담당자명"), $("<td>").text(data.emp_name)  )
		);
		
		//서브테이블 만들기
		let prodTr = "<tr><td colspan='2'>";
		prodTr += "<table><h4>반품 신청 물품</h4>";
		prodTr += "<tr><th>품목코드</th><th>품목명</th><th>분류명</th><th>규격단위</th><th>수량</th><th>금액</th></tr>";
		for(var i=0; i<data.ret_pList.length; i++){
			prodTr += "<tr><td>"+data.ret_pList[i].prodVO.prod_no+"</td>";
			prodTr += "<td>"+data.ret_pList[i].prodVO.prod_name+"</td>";
			prodTr += "<td>"+data.ret_pList[i].lprod_name+"</td>";
			prodTr += "<td>"+data.ret_pList[i].prodVO.prod_stand_size+"</td>";
			prodTr += "<td>"+data.ret_pList[i].ret_list_qty+"</td>";
			prodTr += "<td>"+data.ret_pList[i].orp_price+"</td></tr>";
		}
		prodTr += "</table></td></tr>";
		view.append(prodTr);
		
		$("#exampleModal").find(".modal-body").html(view);
		$('#exampleModal').modal();
	});
	
	//삭제 
	$("#delBtn").on("click", function(){
		let retList = [];
		$(".selected").each(function(){
			let retNo = $(this).find(".retNo").text();
			retList.push(retNo);
		});
		if(retList.length == 0){	//체크박스가 선택되지 않았을 경우
			alert("취소할 반품서를 선택해주세요.");ㄴ
			return;
		}
		jsonData = {or_retp_noList : retList};
		$.ajax({
			url : "${cPath}/order/return",
			contentType : "application/json;charset=UTF-8",
			data : JSON.stringify(jsonData),
			method : "DELETE",
			dataType : "text",
			success : function(resp) {
				alert(resp);
				location.reload();
			},
			error : function(errorResp) {
				console.log(errorResp.status + ":" + errorResp.responseText);
			}
		});
	});
	
</script>



