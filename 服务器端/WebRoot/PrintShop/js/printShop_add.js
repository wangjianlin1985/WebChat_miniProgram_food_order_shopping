$(function () {
	$("#printShop_shopUserName").validatebox({
		required : true, 
		missingMessage : '请输入餐饮店账号',
	});

	$("#printShop_password").validatebox({
		required : true, 
		missingMessage : '请输入登录密码',
	});

	$("#printShop_shopName").validatebox({
		required : true, 
		missingMessage : '请输入餐饮店名称',
	});

	$("#printShop_shopDesc").validatebox({
		required : true, 
		missingMessage : '请输入餐饮店介绍',
	});

	$("#printShop_bornDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#printShop_connectPerson").validatebox({
		required : true, 
		missingMessage : '请输入联系人',
	});

	$("#printShop_telephone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	//单击添加按钮
	$("#printShopAddButton").click(function () {
		//验证表单 
		if(!$("#printShopAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#printShopAddForm").form({
			    url:"PrintShop/add",
			    onSubmit: function(){
					if($("#printShopAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#printShopAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#printShopAddForm").submit();
		}
	});

	//单击清空按钮
	$("#printShopClearButton").click(function () { 
		$("#printShopAddForm").form("clear"); 
	});
});
