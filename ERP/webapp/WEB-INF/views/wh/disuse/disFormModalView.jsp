<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    
    <%--
* [[�����̷�(Modification Information)]]
* ������                 ������      ��������
* ----------  ---------  -----------------
* 2020. 7. 6      �ۼ��ڸ� ������
      �����ۼ�
* Copyright (c) 2020 by DDIT All right reserved
 --%>



<table class="table table-striped" data-order="${pductlist.porder_no}" >

	<tr>
	<th>���� ������</th>
	<td>${pductlist.rep_date } </td>
	</tr>
	
	<tr>
	<th>��û�� ���</th>
	<td>${pductlist.emp_name }</td> 
	</tr>
	<tr>
	
		</table>
<table class="table table-striped">
<thead>
 <tr>
  <th>������ �̸�</th>
  <th>������ ��ȣ</th>
  <th>���� ������</th>
 </tr>
</thead>

<c:set var="Pitem" value="${pductlist.meterial }"/>

<c:forEach items="${Pitem }" var="item">
<tr>
<td>${item.mat_name }</td>
<td>${item.mat_no }</td>
<td>${item.mat_cnt }</td>

</tr>
</c:forEach>

</table>


