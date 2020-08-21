<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<table class="table table-bordered table-hover">
  <thead>
    <tr>
      <th scope="col">��ǰ���� ��ȣ</th>
      <th scope="col">���� ����̸�</th>
      <th scope="col">���� ǰ��</th>
      <th scope="col">������ ��¥</th>
      <th scope="col">�������</th>
    </tr>
  </thead>
    <tbody id = "tablebody">

  	<c:set value = "${order }" var = "pdorder"/>
  	<c:if test="${not empty pdorder }">
  	 <c:forEach items="${pdorder }" var = "order">
  	  <tr data-toggle = "modal" data-target = "#viewModal" class="order">
  	   <td>${order.porder_no } </td>
  	   <td>${order.emp_name } </td>
  	   <td data-name="${order.prod_no}" >${order.prod_name } </td>
  	   <td>${order.porder_date } </td>
  	   <td>${order.pduct_cnt } </td>
  	   </tr>
  	  </c:forEach>
  	  </c:if>
  	  
  	  <c:if test="${empty pdorder }">
  	  <tr><td colspan="7"> �����Ƿ� �����ϴ�. </td></tr>
  	  </c:if>
    <tr>
  </tbody>
  </table>