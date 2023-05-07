<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.PrintShop" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<PrintShop> printShopList = (List<PrintShop>)request.getAttribute("printShopList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String shopUserName = (String)request.getAttribute("shopUserName"); //餐饮店账号查询关键字
    String shopName = (String)request.getAttribute("shopName"); //餐饮店名称查询关键字
    String bornDate = (String)request.getAttribute("bornDate"); //成立日期查询关键字
    String connectPerson = (String)request.getAttribute("connectPerson"); //联系人查询关键字
    String telephone = (String)request.getAttribute("telephone"); //联系电话查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>餐饮店查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>PrintShop/frontlist">餐饮店信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>PrintShop/printShop_frontAdd.jsp" style="display:none;">添加餐饮店</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<printShopList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		PrintShop printShop = printShopList.get(i); //获取到餐饮店对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>PrintShop/<%=printShop.getShopUserName() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=printShop.getShopPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		餐饮店账号:<%=printShop.getShopUserName() %>
			     	</div>
			     	<div class="field">
	            		餐饮店名称:<%=printShop.getShopName() %>
			     	</div>
			     	<div class="field">
	            		成立日期:<%=printShop.getBornDate() %>
			     	</div>
			     	<div class="field">
	            		联系人:<%=printShop.getConnectPerson() %>
			     	</div>
			     	<div class="field">
	            		联系电话:<%=printShop.getTelephone() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>PrintShop/<%=printShop.getShopUserName() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="printShopEdit('<%=printShop.getShopUserName() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="printShopDelete('<%=printShop.getShopUserName() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>餐饮店查询</h1>
		</div>
		<form name="printShopQueryForm" id="printShopQueryForm" action="<%=basePath %>PrintShop/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="shopUserName">餐饮店账号:</label>
				<input type="text" id="shopUserName" name="shopUserName" value="<%=shopUserName %>" class="form-control" placeholder="请输入餐饮店账号">
			</div>
			<div class="form-group">
				<label for="shopName">餐饮店名称:</label>
				<input type="text" id="shopName" name="shopName" value="<%=shopName %>" class="form-control" placeholder="请输入餐饮店名称">
			</div>
			<div class="form-group">
				<label for="bornDate">成立日期:</label>
				<input type="text" id="bornDate" name="bornDate" class="form-control"  placeholder="请选择成立日期" value="<%=bornDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="connectPerson">联系人:</label>
				<input type="text" id="connectPerson" name="connectPerson" value="<%=connectPerson %>" class="form-control" placeholder="请输入联系人">
			</div>
			<div class="form-group">
				<label for="telephone">联系电话:</label>
				<input type="text" id="telephone" name="telephone" value="<%=telephone %>" class="form-control" placeholder="请输入联系电话">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="printShopEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;餐饮店信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#printShopEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxPrintShopModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.printShopQueryForm.currentPage.value = currentPage;
    document.printShopQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.printShopQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.printShopQueryForm.currentPage.value = pageValue;
    documentprintShopQueryForm.submit();
}

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
				$('#printShopEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除餐饮店信息*/
function printShopDelete(shopUserName) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "PrintShop/deletes",
			data : {
				shopUserNames : shopUserName,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#printShopQueryForm").submit();
					//location.href= basePath + "PrintShop/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

