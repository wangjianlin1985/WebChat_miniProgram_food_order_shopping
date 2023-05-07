<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.PrintShop" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    PrintShop printShop = (PrintShop)request.getAttribute("printShop");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改餐饮店信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">餐饮店信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="printShopEditForm" id="printShopEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="printShop_shopUserName_edit" class="col-md-3 text-right">餐饮店账号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="printShop_shopUserName_edit" name="printShop.shopUserName" class="form-control" placeholder="请输入餐饮店账号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="printShop_password_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="printShop_password_edit" name="printShop.password" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="printShop_shopName_edit" class="col-md-3 text-right">餐饮店名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="printShop_shopName_edit" name="printShop.shopName" class="form-control" placeholder="请输入餐饮店名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="printShop_shopPhoto_edit" class="col-md-3 text-right">餐饮店照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="printShop_shopPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="printShop_shopPhoto" name="printShop.shopPhoto"/>
			    <input id="shopPhotoFile" name="shopPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="printShop_shopDesc_edit" class="col-md-3 text-right">餐饮店介绍:</label>
		  	 <div class="col-md-9">
			    <textarea id="printShop_shopDesc_edit" name="printShop.shopDesc" rows="8" class="form-control" placeholder="请输入餐饮店介绍"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="printShop_bornDate_edit" class="col-md-3 text-right">成立日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date printShop_bornDate_edit col-md-12" data-link-field="printShop_bornDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="printShop_bornDate_edit" name="printShop.bornDate" size="16" type="text" value="" placeholder="请选择成立日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="printShop_connectPerson_edit" class="col-md-3 text-right">联系人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="printShop_connectPerson_edit" name="printShop.connectPerson" class="form-control" placeholder="请输入联系人">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="printShop_telephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="printShop_telephone_edit" name="printShop.telephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="printShop_address_edit" class="col-md-3 text-right">餐饮店地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="printShop_address_edit" name="printShop.address" class="form-control" placeholder="请输入餐饮店地址">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxPrintShopModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#printShopEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改餐饮店界面并初始化数据*/
function printShopEdit(shopUserName) {
	$.ajax({
		url :  basePath + "PrintShop/" + shopUserName + "/update",
		type : "get",
		dataType: "json",
		success : function (printShop, response, status) {
			if (printShop) {
				$("#printShop_shopUserName_edit").val(printShop.shopUserName);
				$("#printShop_password_edit").val(printShop.password);
				$("#printShop_shopName_edit").val(printShop.shopName);
				$("#printShop_shopPhoto").val(printShop.shopPhoto);
				$("#printShop_shopPhotoImg").attr("src", basePath +　printShop.shopPhoto);
				$("#printShop_shopDesc_edit").val(printShop.shopDesc);
				$("#printShop_bornDate_edit").val(printShop.bornDate);
				$("#printShop_connectPerson_edit").val(printShop.connectPerson);
				$("#printShop_telephone_edit").val(printShop.telephone);
				$("#printShop_address_edit").val(printShop.address);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交餐饮店信息表单给服务器端修改*/
function ajaxPrintShopModify() {
	$.ajax({
		url :  basePath + "PrintShop/" + $("#printShop_shopUserName_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#printShopEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#printShopQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse > a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*成立日期组件*/
    $('.printShop_bornDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    printShopEdit("<%=request.getParameter("shopUserName")%>");
 })
 </script> 
</body>
</html>

