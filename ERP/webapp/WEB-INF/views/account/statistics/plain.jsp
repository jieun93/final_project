<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<script src="https://d3js.org/d3.v5.min.js"></script>
  <script src="https://d3js.org/d3-array.v2.min.js"></script>
<h2>상품별매출현황</h2>
				<div class="form-inline d-flex ml-md-auto d-print-none middleDiv" id="searchUI">
					<text>년도</text>
					<select name="dataChange" class="form-control mr-2">
					</select>
					<input class="btn btn-primary mr-2" type="button" value="확인" id="searchBtn">
				</div>
				<div class='tableStyle'>
    <div id='renderingArea'></div>
    </div>
    <script type="text/javascript">
  var today = new Date();
	for(var i = today.getFullYear(); i >= ${prodyear}; i--){
		$("select[name='dataChange']").append($("<option>").text(i).val(i));
	}
</script>
    <script type="module">
      import {makeChart} from "${cPath}/resources/bar-chart-race/plain.js"
	
      let dataChange = function(event){
        makeChart(new URL("${cPath}/account/pm/product/"+event,import.meta.url), '#renderingArea');
      }
		$("#searchBtn").on("click",function(){
			dataChange($("select[name='dataChange']").val());
		});
	$("#searchBtn").click();
    </script>
