<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/gridstick/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/gridstick/demo.css" >
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/gridstick/810-many-columns.css" >


<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/gridstick/jquery-ui.min.js"></script>  
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/gridstick/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/gridstick/gridstack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/gridstick/gridstack.jQueryUI.js"></script>




</head>
<body>


 <div class="container-fluid">
    <h1>â�� ����ȭ</h1>
    <div>
      
    </div>
    <div class="grid-stack"></div>
  </div>
  
 

<script type="text/javascript">
var json
let jsondate = null;
var store_no;



function changeFail(store_no){
	var imagesrc = "${cPath}/ware"
}


function lpad(str, padLen, padStr) {
    if (padStr.length > padLen) {
        console.log("���� : ä����� �ϴ� ���ڿ��� ��û ���̺��� Ů�ϴ�");
        return str;
    }
    str += ""; // ���ڷ�
    padStr += ""; // ���ڷ�
    while (str.length < padLen)
        str = padStr + str;
    str = str.length >= padLen ? str.substring(0, padLen) : str;
    return str;
}
 


function changeJsonPath(filepath){
// 	if(filepath == "fail"){ // ���еǾ��� ��, ����â�� �̹����� ����Ǿ, �߰��ϼ��� ��� �̹����� ������ �� �ϰ� �ʹ�.
// 	}

	json = "${cPath}/resources/warejson/" + filepath + ".json"
	store_no = filepath
	
$(".grid-stack-item").each(function(index,item){
	grid.removeWidget( $(item) )
}) 
	
readTextFile(json, function(text){
	
	jsondate = JSON.parse(text);
    let maxnum = 0;
    
    jsondate.forEach(function(item){
   	 addNewWidget(item)
   	 if(  item.y > maxnum ){
   		 maxnum = item.y
   	 }
   	 
   	 })
   	 console.log(maxnum)
   	 grid.addWidget('<div><div class="grid-stack-item-content " id = "delete"></div></div>', {x: 0 , y: maxnum + 3, width: 1 , height: 1, id : 'delete'} );
    $("#delete").parent().remove()
   	 

});
	
}

readTextFile = function(file, callback) {
    var rawFile = new XMLHttpRequest();
    rawFile.overrideMimeType("application/json");
    rawFile.open("GET", file, true);
    rawFile.onreadystatechange = function() {
        if (rawFile.readyState === 4 && rawFile.status == "200") {
            callback(rawFile.responseText);
        }
    }
    rawFile.send(null);
}
// json������ �а� �ش�� ������ �о���� ��Ȱ


  
 plusNewWidget = function(){
 	 grid.addWidget('<div><div class="grid-stack-item-content "></div></div>', {x: 0 , y: 0, width: 1 , height: 1 } );
 }


var options = {
		column: 30, // width���� 30���� �÷ȴٶ�� �ǹ�
	      cellHeight: 'auto',
	      float: true
	    };
	    var grid = GridStack.init(options);
		// ������ ���� �����ϸ� options�̶�� grid ���¸� ���¿� ���� ���� ��ü ���·� ���� ������, �װ͵��� ����� grid�� �����ȴ�.
		// �ｼ, grid�� ���밡 �Ǵ� �κ��̴�.
		
		// grid�� �߰��ϴ� ��ɾ��.
	 
	    addNewWidget = function(item) {
	      grid.addWidget('<div><div class="grid-stack-item-content ">' + item.id + '</div></div>', {id: item.id, x: item.x , y: item.y, width: item.width , height: item.height });
	      grid.movable('.grid-stack-item', false);
	      grid.resizable('.grid-stack-item', false);
		 
	    };
	    


$(document).on("click","div .grid-stack-item",function(){
	var select = $(".grid-stack-item")
	
 	$("#box").val( $(this).data("gsId") )
 	
 	let sector_part = $(this).data("gsId")
	
	// �ڱ� �ڽ��� ������ ������ select Ŭ���� ����
	$(this).find(".grid-stack-item-content").addClass("select")
	select.not( $(this) ).find(".grid-stack-item-content").removeClass("select")
	
	let sector_one = store_no.substring(3)
	let sector_two = lpad(sector_part+"", 3, "0")
	let sector_no = sector_one + sector_two
	
	 parent.selectGrid(sector_no)

	})
	
	// �׸��� �ϳ��� �����ؼ� �����ϴ°�

	    

	
    
	    

</script>
</body>
</html>