<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>餐饮店添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>PrintShop/frontlist">餐饮店管理</a></li>
  			<li class="active">注册餐饮店</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="printShopAddForm" id="printShopAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
					 <label for="printShop_shopUserName" class="col-md-2 text-right">餐饮店账号:</label>
					 <div class="col-md-8"> 
					 	<input type="text" id="printShop_shopUserName" name="printShop.shopUserName" class="form-control" placeholder="请输入餐饮店账号">
					 </div>
				  </div> 
				  <div class="form-group">
				  	 <label for="printShop_password" class="col-md-2 text-right">登录密码:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="printShop_password" name="printShop.password" class="form-control" placeholder="请输入登录密码">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="printShop_shopName" class="col-md-2 text-right">餐饮店名称:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="printShop_shopName" name="printShop.shopName" class="form-control" placeholder="请输入餐饮店名称">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="printShop_shopPhoto" class="col-md-2 text-right">餐饮店照片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="printShop_shopPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="printShop_shopPhoto" name="printShop.shopPhoto"/>
					    <input id="shopPhotoFile" name="shopPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="printShop_shopDesc" class="col-md-2 text-right">餐饮店介绍:</label>
				  	 <div class="col-md-8">
					    <textarea id="printShop_shopDesc" name="printShop.shopDesc" rows="8" class="form-control" placeholder="请输入餐饮店介绍"></textarea>
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="printShop_bornDateDiv" class="col-md-2 text-right">成立日期:</label>
				  	 <div class="col-md-8">
		                <div id="printShop_bornDateDiv" class="input-group date printShop_bornDate col-md-12" data-link-field="printShop_bornDate" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="printShop_bornDate" name="printShop.bornDate" size="16" type="text" value="" placeholder="请选择成立日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="printShop_connectPerson" class="col-md-2 text-right">联系人:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="printShop_connectPerson" name="printShop.connectPerson" class="form-control" placeholder="请输入联系人">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="printShop_telephone" class="col-md-2 text-right">联系电话:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="printShop_telephone" name="printShop.telephone" class="form-control" placeholder="请输入联系电话">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="printShop_address" class="col-md-2 text-right">餐饮店地址:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="printShop_address" name="printShop.address" class="form-control" placeholder="请输入餐饮店地址">
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxPrintShopAdd();" class="btn btn-primary bottom5 top5">餐饮店注册</span>
		          </div> 
		          <style>#printShopAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加餐饮店信息
	function ajaxPrintShopAdd() { 
		//提交之前先验证表单
		$("#printShopAddForm").data('bootstrapValidator').validate();
		if(!$("#printShopAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "PrintShop/add",
			dataType : "json" , 
			data: new FormData($("#printShopAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#printShopAddForm").find("input").val("");
					$("#printShopAddForm").find("textarea").val("");
				} else {
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
	//验证餐饮店添加表单字段
	$('#printShopAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"printShop.shopUserName": {
				validators: {
					notEmpty: {
						message: "餐饮店账号不能为空",
					}
				}
			},
			"printShop.password": {
				validators: {
					notEmpty: {
						message: "登录密码不能为空",
					}
				}
			},
			"printShop.shopName": {
				validators: {
					notEmpty: {
						message: "餐饮店名称不能为空",
					}
				}
			},
			"printShop.shopDesc": {
				validators: {
					notEmpty: {
						message: "餐饮店介绍不能为空",
					}
				}
			},
			"printShop.bornDate": {
				validators: {
					notEmpty: {
						message: "成立日期不能为空",
					}
				}
			},
			"printShop.connectPerson": {
				validators: {
					notEmpty: {
						message: "联系人不能为空",
					}
				}
			},
			"printShop.telephone": {
				validators: {
					notEmpty: {
						message: "联系电话不能为空",
					}
				}
			},
		}
	}); 
	//成立日期组件
	$('#printShop_bornDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#printShopAddForm').data('bootstrapValidator').updateStatus('printShop.bornDate', 'NOT_VALIDATED',null).validateField('printShop.bornDate');
	});
})
</script>
</body>
</html>
