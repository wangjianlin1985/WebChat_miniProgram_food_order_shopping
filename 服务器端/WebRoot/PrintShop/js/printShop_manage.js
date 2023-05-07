var printShop_manage_tool = null; 
$(function () { 
	initPrintShopManageTool(); //建立PrintShop管理对象
	printShop_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#printShop_manage").datagrid({
		url : 'PrintShop/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "shopUserName",
		sortOrder : "desc",
		toolbar : "#printShop_manage_tool",
		columns : [[
			{
				field : "shopUserName",
				title : "餐饮店账号",
				width : 140,
			},
			{
				field : "shopName",
				title : "餐饮店名称",
				width : 140,
			},
			{
				field : "shopPhoto",
				title : "餐饮店照片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "bornDate",
				title : "成立日期",
				width : 140,
			},
			{
				field : "connectPerson",
				title : "联系人",
				width : 140,
			},
			{
				field : "telephone",
				title : "联系电话",
				width : 140,
			},
		]],
	});

	$("#printShopEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#printShopEditForm").form("validate")) {
					//验证表单 
					if(!$("#printShopEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#printShopEditForm").form({
						    url:"PrintShop/" + $("#printShop_shopUserName_edit").val() + "/update",
						    onSubmit: function(){
								if($("#printShopEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#printShopEditDiv").dialog("close");
			                        printShop_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#printShopEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#printShopEditDiv").dialog("close");
				$("#printShopEditForm").form("reset"); 
			},
		}],
	});
});

function initPrintShopManageTool() {
	printShop_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#printShop_manage").datagrid("reload");
		},
		redo : function () {
			$("#printShop_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#printShop_manage").datagrid("options").queryParams;
			queryParams["shopUserName"] = $("#shopUserName").val();
			queryParams["shopName"] = $("#shopName").val();
			queryParams["bornDate"] = $("#bornDate").datebox("getValue"); 
			queryParams["connectPerson"] = $("#connectPerson").val();
			queryParams["telephone"] = $("#telephone").val();
			$("#printShop_manage").datagrid("options").queryParams=queryParams; 
			$("#printShop_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#printShopQueryForm").form({
			    url:"PrintShop/OutToExcel",
			});
			//提交表单
			$("#printShopQueryForm").submit();
		},
		remove : function () {
			var rows = $("#printShop_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var shopUserNames = [];
						for (var i = 0; i < rows.length; i ++) {
							shopUserNames.push(rows[i].shopUserName);
						}
						$.ajax({
							type : "POST",
							url : "PrintShop/deletes",
							data : {
								shopUserNames : shopUserNames.join(","),
							},
							beforeSend : function () {
								$("#printShop_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#printShop_manage").datagrid("loaded");
									$("#printShop_manage").datagrid("load");
									$("#printShop_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#printShop_manage").datagrid("loaded");
									$("#printShop_manage").datagrid("load");
									$("#printShop_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#printShop_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "PrintShop/" + rows[0].shopUserName +  "/update",
					type : "get",
					data : {
						//shopUserName : rows[0].shopUserName,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (printShop, response, status) {
						$.messager.progress("close");
						if (printShop) { 
							$("#printShopEditDiv").dialog("open");
							$("#printShop_shopUserName_edit").val(printShop.shopUserName);
							$("#printShop_shopUserName_edit").validatebox({
								required : true,
								missingMessage : "请输入餐饮店账号",
								editable: false
							});
							$("#printShop_password_edit").val(printShop.password);
							$("#printShop_password_edit").validatebox({
								required : true,
								missingMessage : "请输入登录密码",
							});
							$("#printShop_shopName_edit").val(printShop.shopName);
							$("#printShop_shopName_edit").validatebox({
								required : true,
								missingMessage : "请输入餐饮店名称",
							});
							$("#printShop_shopPhoto").val(printShop.shopPhoto);
							$("#printShop_shopPhotoImg").attr("src", printShop.shopPhoto);
							$("#printShop_shopDesc_edit").val(printShop.shopDesc);
							$("#printShop_shopDesc_edit").validatebox({
								required : true,
								missingMessage : "请输入餐饮店介绍",
							});
							$("#printShop_bornDate_edit").datebox({
								value: printShop.bornDate,
							    required: true,
							    showSeconds: true,
							});
							$("#printShop_connectPerson_edit").val(printShop.connectPerson);
							$("#printShop_connectPerson_edit").validatebox({
								required : true,
								missingMessage : "请输入联系人",
							});
							$("#printShop_telephone_edit").val(printShop.telephone);
							$("#printShop_telephone_edit").validatebox({
								required : true,
								missingMessage : "请输入联系电话",
							});
							$("#printShop_address_edit").val(printShop.address);
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
